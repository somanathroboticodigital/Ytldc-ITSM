# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.de/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --

package Kernel::Modules::AdminUser;

use strict;
use warnings;

use Kernel::Language qw(Translatable);

use parent qw(Kernel::System::AsynchronousExecutor);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get needed objects
    my $ParamObject     = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $LayoutObject    = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigObject    = $Kernel::OM->Get('Kernel::Config');
    my $LogObject       = $Kernel::OM->Get('Kernel::System::Log');
    my $UserObject      = $Kernel::OM->Get('Kernel::System::User');
    my $MainObject      = $Kernel::OM->Get('Kernel::System::Main');
    my $CheckItemObject = $Kernel::OM->Get('Kernel::System::CheckItem');

    my $Search       = $ParamObject->GetParam( Param => 'Search' )       || '';
    my $Notification = $ParamObject->GetParam( Param => 'Notification' ) || '';

    # Get list of valid IDs.
    my @ValidIDList = $Kernel::OM->Get('Kernel::System::Valid')->ValidIDsGet();

    # ------------------------------------------------------------ #
    #  switch to user
    # ------------------------------------------------------------ #
    if (
        $Self->{Subaction} eq 'Switch'
        && $ConfigObject->Get('SwitchToUser')
        )
    {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        my $UserID   = $ParamObject->GetParam( Param => 'UserID' ) || '';
        my %UserData = $UserObject->GetUserData(
            UserID        => $UserID,
            NoOutOfOffice => 1,
        );

        my $SessionObject = $Kernel::OM->Get('Kernel::System::AuthSession');
        my $NewSessionID  = $SessionObject->CreateSessionID(
            %UserData,
            UserLastRequest => $Kernel::OM->Create('Kernel::System::DateTime')->ToEpoch(),
            UserType        => 'User',
            SessionSource   => 'AgentInterface',
        );

        # create a new LayoutObject with SessionIDCookie
        my $Expires = '+' . $ConfigObject->Get('SessionMaxTime') . 's';
        if ( !$ConfigObject->Get('SessionUseCookieAfterBrowserClose') ) {
            $Expires = '';
        }

        # Restrict Cookie to HTTPS if it is used.
        my $CookieSecureAttribute = $ConfigObject->Get('HttpType') eq 'https' ? 1 : undef;

        $Kernel::OM->ObjectParamAdd(
            'Kernel::Output::HTML::Layout' => {
                %UserData,
                SetCookies => {
                    SessionIDCookie => $ParamObject->SetCookie(
                        Key      => $ConfigObject->Get('SessionName'),
                        Value    => $NewSessionID,
                        Expires  => $Expires,
                        Path     => $ConfigObject->Get('ScriptAlias'),
                        Secure   => $CookieSecureAttribute,
                        HTTPOnly => 1,
                    ),
                },
                SessionID   => $NewSessionID,
                SessionName => $ConfigObject->Get('SessionName'),
            }
        );

        $Kernel::OM->ObjectsDiscard( Objects => ['Kernel::Output::HTML::Layout'] );
        my $LayoutObjectSession = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

        # log event
        $LogObject->Log(
            Priority => 'notice',
            Message  => "Switched to User ($Self->{UserLogin} -=> $UserData{UserLogin})",
        );

        # Delete old session, see bug#14322 (https://bugs.otrs.org/show_bug.cgi?id=14322);
        $SessionObject->RemoveSessionID(
            SessionID => $LayoutObject->{SessionID}
        );

        # redirect with new session id
        return $LayoutObjectSession->Redirect( OP => '' );
    }

    # ------------------------------------------------------------ #
    # change
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'Change' ) {
        my $UserID = $ParamObject->GetParam( Param => 'UserID' )
            || $ParamObject->GetParam( Param => 'ID' )
            || '';
        my %UserData = $UserObject->GetUserData(
            UserID        => $UserID,
            NoOutOfOffice => 1,
        );

        my $Output = $LayoutObject->Header();
        $Output .= $LayoutObject->NavigationBar();
        $Output .= $LayoutObject->Notify( Info => Translatable('Agent updated!') )
            if ( $Notification && $Notification eq 'Update' );

        $Self->_Edit(
            Action => 'Change',
            Search => $Search,
            %UserData,
        );
        $Output .= $LayoutObject->Output(
            TemplateFile => 'AdminUser',
            Data         => \%Param,
        );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }

    # ------------------------------------------------------------ #
    # change action
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ChangeAction' ) {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        my $Note = '';
        my ( %GetParam, %Errors );
        for my $Parameter (
            qw(UserID UserTitle UserLogin UserFirstname UserLastname UserEmail UserPw UserMobile ValidID Search)
            )
        {
            $GetParam{$Parameter} = $ParamObject->GetParam( Param => $Parameter ) || '';
        }

        for my $Needed (qw(UserID UserFirstname UserLastname UserLogin ValidID)) {
            if ( !$GetParam{$Needed} ) {
                $Errors{ $Needed . 'Invalid' } = 'ServerError';
            }
        }

        # check email address
        if (
            $GetParam{UserEmail}
            && !$CheckItemObject->CheckEmail( Address => $GetParam{UserEmail} )
            && grep { $_ eq $GetParam{ValidID} } @ValidIDList
            )
        {
            $Errors{UserEmailInvalid} = 'ServerError';
            $Errors{ErrorType}        = $CheckItemObject->CheckErrorType();
        }

        # check if a user with this login (username) already exits
        my $UserLoginExists = $UserObject->UserLoginExistsCheck(
            UserLogin => $GetParam{UserLogin},
            UserID    => $GetParam{UserID}
        );
        if ($UserLoginExists) {
            $Errors{UserLoginExists}    = 1;
            $Errors{'UserLoginInvalid'} = 'ServerError';
        }

        # if no errors occurred
        if ( !%Errors )
        {

            # Get old user login in order to compare the old and the new one.
            my $OldUserLogin = $UserObject->UserLookup(
                UserID => $GetParam{UserID},
            );

            # update user
            my $Update = $UserObject->UserUpdate(
                %GetParam,
                ChangeUserID => $Self->{UserID},
            );

        
            if ($Update) {

                # If UserLogin is changed or the user is set to invalid,
                #   remove asynchronously all sessions from that user.
                if ( $OldUserLogin ne $GetParam{UserLogin} || !grep { $_ eq $GetParam{ValidID} } @ValidIDList ) {
                    $Self->AsyncCall(
                        ObjectName     => 'Kernel::System::AuthSession',
                        FunctionName   => 'RemoveSessionByUser',
                        FunctionParams => {
                            UserLogin => $OldUserLogin,
                        },
                    );
                }

                # if the user would like to continue editing the agent, just redirect to the edit screen
                # otherwise return to overview
                if (
                    defined $ParamObject->GetParam( Param => 'ContinueAfterSave' )
                    && ( $ParamObject->GetParam( Param => 'ContinueAfterSave' ) eq '1' )
                    )
                {
                    my $ID = $ParamObject->GetParam( Param => 'ID' ) || '';
                    return $LayoutObject->Redirect(
                        OP => "Action=$Self->{Action};Subaction=Change;UserID=$GetParam{UserID};Notification=Update"
                    );
                }
                else {
                    return $LayoutObject->Redirect( OP => "Action=$Self->{Action};Notification=Update" );
                }
            }
            else {
                $Note = $LogObject->GetLogEntry(
                    Type => 'Error',
                    What => 'Message',
                );
            }
        }
        my $Output = $LayoutObject->Header();
        $Output .= $Note
            ? $LayoutObject->Notify(
                Priority => 'Error',
                Info     => $Note,
            )
            : '';
        $Output .= $LayoutObject->NavigationBar();
        $Self->_Edit(
            Action    => 'Change',
            Search    => $Search,
            ErrorType => $Errors{ErrorType} || '',
            %GetParam,
            %Errors,
        );
        $Output .= $LayoutObject->Output(
            TemplateFile => 'AdminUser',
            Data         => \%Param,
        );
        $Output .= $LayoutObject->Footer();
        return $Output;

    }

    # ------------------------------------------------------------ #
    # add
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'Add' ) {
        my %GetParam = ();

        $GetParam{UserLogin} = $ParamObject->GetParam( Param => 'UserLogin' );

        my $Output = $LayoutObject->Header();
        $Output .= $LayoutObject->NavigationBar();
        $Self->_Edit(
            Action => 'Add',
            Search => $Search,
            %GetParam,
        );
        $Output .= $LayoutObject->Output(
            TemplateFile => 'AdminUser',
            Data         => \%Param,
        );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }

    # ------------------------------------------------------------ #
    # add action
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'AddAction' ) {


        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        my $Note = '';
        my ( %GetParam, %Errors );
        for my $Parameter (
            qw(UserTitle UserLogin UserFirstname UserLastname UserEmail UserPw UserMobile ValidID Search)
            )
        {
            $GetParam{$Parameter} = $ParamObject->GetParam( Param => $Parameter ) || '';
        }

        for my $Needed (qw(UserFirstname UserLastname UserLogin UserEmail ValidID)) {
            if ( !$GetParam{$Needed} ) {
                $Errors{ $Needed . 'Invalid' } = 'ServerError';
            }
        }

        # check email address
        if (
            $GetParam{UserEmail}
            && !$CheckItemObject->CheckEmail( Address => $GetParam{UserEmail} )
            && grep { $_ eq $GetParam{ValidID} } @ValidIDList
            )
        {
            $Errors{UserEmailInvalid} = 'ServerError';
            $Errors{ErrorType}        = $CheckItemObject->CheckErrorType();
        }

        # check if a user with this login (username) already exits
        my $UserLoginExists = $UserObject->UserLoginExistsCheck( UserLogin => $GetParam{UserLogin} );
        if ($UserLoginExists) {
            $Errors{UserLoginExists}    = 1;
            $Errors{'UserLoginInvalid'} = 'ServerError';
        }

        # if no errors occurred
        if ( !%Errors )
        {

            # add user
            my $UserID = $UserObject->UserAdd(
                %GetParam,
                ChangeUserID => $Self->{UserID}
            );

    
            if ($UserID) {

                # redirect
                if (
                    !$ConfigObject->Get('Frontend::Module')->{AdminUserGroup}
                    && $ConfigObject->Get('Frontend::Module')->{AdminRoleUser}
                    )
                {
                    return $LayoutObject->Redirect(
                        OP => "Action=AdminRoleUser;Subaction=User;ID=$UserID",
                    );
                }
                if ( $ConfigObject->Get('Frontend::Module')->{AdminUserGroup} ) {
                    return $LayoutObject->Redirect(
                        OP => "Action=AdminUserGroup;Subaction=User;ID=$UserID",
                    );
                }
                else {
                    return $LayoutObject->Redirect(
                        OP => 'Action=AdminUser',
                    );
                }
            }
            else {
                $Note = $LogObject->GetLogEntry(
                    Type => 'Error',
                    What => 'Message',
                );
            }
        }
        my $Output = $LayoutObject->Header();
        $Output .= $Note
            ? $LayoutObject->Notify(
                Priority => 'Error',
                Info     => $Note,
            )
            : '';
        $Output .= $LayoutObject->NavigationBar();
        $Self->_Edit(
            Action    => 'Add',
            Search    => $Search,
            ErrorType => $Errors{ErrorType} || '',
            %GetParam,
            %Errors,
        );
        $Output .= $LayoutObject->Output(
            TemplateFile => 'AdminUser',
            Data         => \%Param,
        );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }

    # ------------------------------------------------------------ #
    # overview
    # ------------------------------------------------------------ #
    else {
        $Self->_Overview( Search => $Search );
        my $Output = $LayoutObject->Header();
        $Output .= $LayoutObject->NavigationBar();
        $Output .= $LayoutObject->Notify( Info => Translatable('Agent updated!') )
            if ( $Notification && $Notification eq 'Update' );

        $Output .= $LayoutObject->Output(
            TemplateFile => 'AdminUser',
            Data         => \%Param,
        );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }
}

sub _Edit {
    my ( $Self, %Param ) = @_;

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    $LayoutObject->Block(
        Name => 'Overview',
        Data => \%Param,
    );
    $LayoutObject->Block( Name => 'ActionList' );
    $LayoutObject->Block( Name => 'ActionOverview' );

    # check if the current user has the permissions to edit another users preferences
    if ( $Param{Action} eq 'Change' ) {

        my $GroupObject                      = $Kernel::OM->Get('Kernel::System::Group');
        my $EditAnotherUsersPreferencesGroup = $GroupObject->GroupLookup(
            Group => $Kernel::OM->Get('Kernel::Config')->Get('EditAnotherUsersPreferencesGroup'),
        );

        # get user groups, where the user has the rw privilege
        my %Groups = $GroupObject->PermissionUserGet(
            UserID => $Self->{UserID},
            Type   => 'rw',
        );

        # if the user is a member in this group he can access the feature
        if ( $Groups{$EditAnotherUsersPreferencesGroup} ) {
            $LayoutObject->Block(
                Name => 'ActionEditPreferences',
                Data => {
                    UserID => $Param{UserID},
                },
            );
        }
    }

    # get valid list
    my %ValidList        = $Kernel::OM->Get('Kernel::System::Valid')->ValidList();
    my %ValidListReverse = reverse %ValidList;

    $Param{ValidOption} = $LayoutObject->BuildSelection(
        Data       => \%ValidList,
        Name       => 'ValidID',
        SelectedID => $Param{ValidID} || $ValidListReverse{valid},
        Class      => 'Modernize',
    );

    $LayoutObject->Block(
        Name => 'OverviewUpdate',
        Data => \%Param,
    );

    if ( $Param{Action} eq 'Change' ) {

        # shows edit header
        $LayoutObject->Block( Name => 'HeaderEdit' );

        # shows effective permissions matrix
        $Self->_EffectivePermissions(%Param);
        $Self->_AgentDetails(%Param);
    }
    else {

        # shows add header and hints
        $LayoutObject->Block( Name => 'HeaderAdd' );
        $LayoutObject->Block( Name => 'MarkerMandatory' );
        $LayoutObject->Block( Name => 'ShowPasswordHint' );
    }

    # add the correct server error message
    if ( $Param{UserEmail} && $Param{ErrorType} ) {

        # display server error message according with the occurred email error type
        $LayoutObject->Block(
            Name => 'UserEmail' . $Param{ErrorType} . 'ServerErrorMsg',
            Data => {},
        );
    }
    else {
        $LayoutObject->Block(
            Name => "UserEmailServerErrorMsg",
            Data => {},
        );
    }

    # show appropriate messages for ServerError
    if ( defined $Param{UserLoginExists} && $Param{UserLoginExists} == 1 ) {
        $LayoutObject->Block( Name => 'ExistUserLoginServerError' );
    }
    else {
        $LayoutObject->Block( Name => 'UserLoginServerError' );
    }

    return 1;
}

sub _Overview {
    my ( $Self, %Param ) = @_;

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # when there is no data to show, a message is displayed on the table with this colspan
    my $ColSpan = 7;

    $LayoutObject->Block(
        Name => 'Overview',
        Data => \%Param,
    );

    $LayoutObject->Block( Name => 'ActionList' );
    $LayoutObject->Block(
        Name => 'ActionSearch',
        Data => \%Param,
    );
    $LayoutObject->Block( Name => 'ActionAdd' );

    # get user object
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    # ShownUsers limitation in AdminUser
    my $Limit = 400;

    my %List = $UserObject->UserSearch(
        Search => $Param{Search} . '*',
        Limit  => $Limit,
        Valid  => 0,
    );

    my %ListAllItems = $UserObject->UserSearch(
        Search => $Param{Search} . '*',
        Limit  => $Limit + 1,
        Valid  => 0,
    );

    if ( keys %ListAllItems <= $Limit ) {
        my $ListAllItems = keys %ListAllItems;
        $LayoutObject->Block(
            Name => 'OverviewHeader',
            Data => {
                ListAll => $ListAllItems,
                Limit   => $Limit,
            },
        );
    }
    else {
        my $ListAllSize    = keys %ListAllItems;
        my $SearchListSize = keys %List;

        $LayoutObject->Block(
            Name => 'OverviewHeader',
            Data => {
                SearchListSize => $SearchListSize,
                ListAll        => $ListAllSize,
                Limit          => $Limit,
            },
        );

    }

    $LayoutObject->Block(
        Name => 'OverviewResult',
        Data => \%Param,
    );

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    if ( $ConfigObject->Get('SwitchToUser') ) {
        $ColSpan = 8;
        $LayoutObject->Block(
            Name => 'OverviewResultSwitchToUser',
        );
    }

    # get valid list
    my %ValidList = $Kernel::OM->Get('Kernel::System::Valid')->ValidList();

    # if there are results to show
    if (%List) {
        for my $ListKey ( sort { $List{$a} cmp $List{$b} } keys %List ) {

            my %UserData = $UserObject->GetUserData(
                UserID        => $ListKey,
                NoOutOfOffice => 1,
            );
            $LayoutObject->Block(
                Name => 'OverviewResultRow',
                Data => {
                    Valid  => $ValidList{ $UserData{ValidID} },
                    Search => $Param{Search},
                    %UserData,
                },
            );
            if ( $ConfigObject->Get('SwitchToUser') ) {
                $LayoutObject->Block(
                    Name => 'OverviewResultRowSwitchToUser',
                    Data => {
                        Search => $Param{Search},
                        %UserData,
                    },
                );
            }
        }
    }

    else {
        $LayoutObject->Block(
            Name => 'NoDataFoundMsg',
            Data => {
                ColSpan => $ColSpan,
            },
        );
    }

    return 1;
}

sub _EffectivePermissions {
    my ( $Self, %Param ) = @_;

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # show tables
    $LayoutObject->Block(
        Name => 'EffectivePermissions',
    );

    my %Groups;
    my %Permissions;

    # go through permission types
    my @Types = @{ $Kernel::OM->Get('Kernel::Config')->Get('System::Permission') };
    for my $Type (@Types) {

        # show header
        $LayoutObject->Block(
            Name => 'HeaderGroupPermissionType',
            Data => {
                Type => $Type,
            },
        );

        # get groups of the user
        my %UserGroups = $Kernel::OM->Get('Kernel::System::Group')->PermissionUserGet(
            UserID => $Param{UserID},
            Type   => $Type,
        );

        # store data in lookup hashes
        for my $GroupID ( sort keys %UserGroups ) {
            $Groups{$GroupID} = $UserGroups{$GroupID};
            $Permissions{$GroupID}{$Type} = 1;
        }
    }

    # show message if no permissions found
    if ( !%Permissions ) {
        $LayoutObject->Block(
            Name => 'NoGroupPermissionsFoundMsg',
        );
        return;
    }

    # go through groups, sort by name
    for my $GroupID ( sort { uc( $Groups{$a} ) cmp uc( $Groups{$b} ) } keys %Groups ) {

        # show table rows
        $LayoutObject->Block(
            Name => 'GroupPermissionTableRow',
            Data => {
                ID   => $GroupID,
                Name => $Groups{$GroupID},
            },
        );

        # show permission marks
        for my $Type (@Types) {
            my $PermissionMark = $Permissions{$GroupID}{$Type} ? 'On'        : 'Off';
            my $HighlightMark  = $Type eq 'rw'                 ? 'Highlight' : '';
            $LayoutObject->Block(
                Name => 'GroupPermissionMark',
            );
            $LayoutObject->Block(
                Name => 'GroupPermissionMark' . $PermissionMark,
                Data => {
                    Highlight => $HighlightMark,
                },
            );
        }
    }
    return;
}

sub _AgentDetails {
    my ( $Self, %Param ) = @_;

     my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # show tables
    $LayoutObject->Block(
        Name => 'Agentblock',
    );

    my @AgentHistoryDeatils = $Self->AgentHistoryGet(
        UserID         => $Param{UserID}
    );

    my $Time;
    for my $Data (@AgentHistoryDeatils) {

        $Data->{Class} = '';

        my $HistoryArticleTime = $Kernel::OM->Create(
            'Kernel::System::DateTime',
            ObjectParams => {
                String => $Data->{CreateTime},
            }
        )->ToEpoch();

        my $IsNewWidget;

        # Create a new widget if article create time difference is more then 5 sec.
        if ( !$Time || abs( $Time - $HistoryArticleTime ) > 5 ) {

            $LayoutObject->Block(
                Name => 'AgentHistoryblock',
                Data => {
                    CreateTime => $Data->{CreateTime},
                },
            );

            $Time        = $HistoryArticleTime;
            $IsNewWidget = 1;

        }
        
        $LayoutObject->Block(
            Name => 'Row',
            Data => $Data,
        );

    }
    return;

}


sub AgentHistoryGet {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my @Lines;

    # check needed stuff
    for my $Needed (qw(UserID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!"
            );
            return;
        }
    }

    # # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    return if !$DBObject->Prepare(
        SQL => 'SELECT name,agent_id,owner_id,create_time,create_by,change_time,change_by from agent_history where agent_id = ? ',
        Bind => [ \$Param{UserID} ],
    );

    while ( my @Row = $DBObject->FetchrowArray() ) {
        my %Data;
        $Data{Name}          = $Row[0];
        $Data{AgentID}       = $Param{UserID};
        $Data{OwnerID}       = $Row[2];
        $Data{CreateTime}    = $Row[3];
        $Data{CreateBy}      = $Row[4];
        $Data{ChangeTime}    = $Row[5];
        $Data{ChangeBy}      = $Row[6];
        push @Lines, \%Data;
    }

    # get user object
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    # get user data
    for my $Data (@Lines) {

        my %UserInfo = $UserObject->GetUserData(
            UserID => $Data->{CreateBy},
        );

        # merge result, put %Data last so that it "wins"
        %{$Data} = ( %UserInfo, %{$Data} );
    }

    return @Lines;
    # return 1;

}


1;
