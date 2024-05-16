# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaSZoom;


use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);
use Kernel::System::DynamicField;
use Kernel::System::DynamicField::Backend;
use Kernel::System::VariableCheck qw(:all);

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
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    # get params
    my $PaSID = $ParamObject->GetParam( Param => "PaSID" );
    
    # store needed parameters in %GetParam to make it reloadable
    my %GetParam;
    for my $ParamName (
        qw(PaSID)
        )
    {
        $GetParam{$ParamName} = $ParamObject->GetParam( Param => $ParamName );
    }

    # check needed stuff
    if ( !$PaSID ) {
        return $LayoutObject->ErrorScreen(
            Message => 'No PaSID is given!',
            Comment => 'Please contact the admin.',
        );
    }

    # get needed objects
    my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # get config of frontend module
    $Self->{Config} = $ConfigObject->Get("PaS::Frontend::$Self->{Action}");
    
    
    # get PaS data
    my $PaS = $PaSObject->PaSGet(
        PaSID => $PaSID,
        UserID   => $Self->{UserID},
    );
    


    # check error
    if ( !$PaS ) {
        return $LayoutObject->ErrorScreen(
            Message => "PaS '$PaSID' not found in database!",
            Comment => 'Please contact the admin.',
        );
    }
    # output header
    my $Output = $LayoutObject->Header(
        Value => 'Test Title',
    );
    $Output .= $LayoutObject->NavigationBar();

    # get log object
    my $LogObject = $Kernel::OM->Get('Kernel::System::Log');

    # handle HTMLView
    if ( $Self->{Subaction} eq 'HTMLView' ) {

        # get param
        my $Field = $ParamObject->GetParam( Param => "Field" );

        # needed param
        if ( !$Field ) {
            $LogObject->Log(
                Message  => "Needed Param: $Field!",
                Priority => 'error',
            );
            return;
        }
        
        # get the Field content
        my $FieldContent = $PaS->{$Field};

        # build base URL for in-line images if no session cookies are used
        my $SessionID = '';
        if ( $Self->{SessionID} && !$Self->{SessionIDCookie} ) {
            $SessionID = ';' . $Self->{SessionName} . '=' . $Self->{SessionID};
            $FieldContent =~ s{
                (Action=AgentPaSZoom;Subaction=DownloadAttachment;Filename=.+;PaSID=\d+)
            }{$1$SessionID}gmsx;
        }

        # get HTML utils object
        my $HTMLUtilsObject = $Kernel::OM->Get('Kernel::System::HTMLUtils');

        # detect all plain text links and put them into an HTML <a> tag
        $FieldContent = $HTMLUtilsObject->LinkQuote(
            String => $FieldContent,
        );

        # set target="_blank" attribute to all HTML <a> tags
        # the LinkQuote function needs to be called again
        $FieldContent = $HTMLUtilsObject->LinkQuote(
            String    => $FieldContent,
            TargetAdd => 1,
        );

        # add needed HTML headers
        $FieldContent = $HTMLUtilsObject->DocumentComplete(
            String  => $FieldContent,
            Charset => 'utf-8',
        );

        # return complete HTML as an attachment
        return $LayoutObject->Attachment(
            Type        => 'inline',
            ContentType => 'text/html',
            Content     => $FieldContent,
        );
    }
    
    # handle DownloadAttachment
   elsif ( $Self->{Subaction} eq 'DownloadAttachment' ) {

        # get data for attachment
        my $Filename = $ParamObject->GetParam( Param => 'Filename' );
        my $AttachmentData = $PaSObject->PaSAttachmentGet(
            PaSID => $PaSID,
            Filename => $Filename,
        );

        # return error if file does not exist
        if ( !$AttachmentData ) {
            $LogObject->Log(
                Message  => "No such attachment ($Filename)! May be an attack!!!",
                Priority => 'error',
            );
            return $LayoutObject->ErrorScreen();
        }

        return $LayoutObject->Attachment(
            %{$AttachmentData},
            Type => 'attachment',
        );
    

    }

    # get session object
    my $SessionObject = $Kernel::OM->Get('Kernel::System::AuthSession');

    # Store LastPaSView, for backlinks from PaS specific pages
    $SessionObject->UpdateSessionID(
        SessionID => $Self->{SessionID},
        Key       => 'LastPaSView',
        Value     => $Self->{RequestedURL},
    );

    # Store LastScreenOverview, for backlinks from AgentLinkObject
    $SessionObject->UpdateSessionID(
        SessionID => $Self->{SessionID},
        Key       => 'LastScreenOverview',
        Value     => $Self->{RequestedURL},
    );

    # Store LastScreenOverview, for backlinks from AgentLinkObject
    $SessionObject->UpdateSessionID(
        SessionID => $Self->{SessionID},
        Key       => 'LastScreenView',
        Value     => $Self->{RequestedURL},
    );

    # Store LastScreenWorkOrders, for backlinks from ITSMWorkOrderZoom
    $SessionObject->UpdateSessionID(
        SessionID => $Self->{SessionID},
        Key       => 'LastScreenWorkOrders',
        Value     => $Self->{RequestedURL},
    );

	 my $Output = $LayoutObject->Header(
        Value => $PaS->{Dynamicfield_PaSTitle},
    );
    $Output .= $LayoutObject->NavigationBar();

    # run PaS menu modules    
    if ( ref $ConfigObject->Get('PaS::Frontend::MenuModule') eq 'HASH' ) {

        # get items for menu
        my %Menus   = %{ $ConfigObject->Get('PaS::Frontend::MenuModule') };
        my $Counter = 0;

        for my $Menu ( sort keys %Menus ) {

            # load module
            if ( $Kernel::OM->Get('Kernel::System::Main')->Require( $Menus{$Menu}->{Module} ) ) {
                my $Object = $Menus{$Menu}->{Module}->new(
                    %{$Self},
                    PaSID => $PaSID,
                );

                # set classes
                if ( $Menus{$Menu}->{Target} ) {

                    if ( $Menus{$Menu}->{Target} eq 'PopUp' ) {
                        $Menus{$Menu}->{MenuClass} = 'AsPopup';
                    }
                    elsif ( $Menus{$Menu}->{Target} eq 'Back' ) {
                        $Menus{$Menu}->{MenuClass} = 'HistoryBack';
                    }
                       elsif ( $Menus{$Menu}->{Target} eq 'ConfirmationDialog' ) {
                            $Menus{$Menu}->{Class} = 'AsConfirmationDialog';
                        }

                }
			
                # run module
                $Counter = $Object->Run(
                    %Param,
                    PaS  => $PaS,
                    Counter => $Counter,
                    Config  => $Menus{$Menu},
                    MenuID  => $Menu,
                );
            }
            else {
                return $LayoutObject->FatalError();
            }
        }
        
       
    }
    
     # get user object
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    # get agents preferences
    my %UserPreferences = $UserObject->GetPreferences(
        UserID => $Self->{UserID},
    );
 	# get PaS builder data
    my %PaSBuilderUser = $UserObject->GetUserData(
        UserID => $PaS->{ChangeBy},
        Cached => 1,
    );
	
	# get create user data
    my %CreateUser = $UserObject->GetUserData(
        UserID => $PaS->{CreateBy},
        Cached => 1,
    );

	
	
    # get PaS user data
    my %PaSUser = $UserObject->GetUserData(
        UserID => $PaS->{ChangeBy},
        Cached => 1,
    );

    # all postfixes needed for user information
    my @Postfixes = qw(UserLogin UserFirstname UserLastname);

    # get user information for PaSBuilder, CreateBy, PaSBy
    for my $Postfix (@Postfixes) {
        $PaS->{ 'PaSBuilder' . $Postfix } = $PaSBuilderUser{$Postfix};
        $PaS->{ 'Create' . $Postfix }        = $CreateUser{$Postfix};
        $PaS->{ 'Change' . $Postfix }        = $PaSUser{$Postfix};
    }

  
   # get link object
    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');

    # get linked objects which are directly linked with this PaS object
    my $LinkListWithData = $LinkObject->LinkListWithData(
        Object => 'PaS',
        Key    => $PaSID,
        State  => 'Valid',
        UserID => $Self->{UserID},
    );
	
	 # add combined linked objects from workorder to linked objects from PaS object
    $LinkListWithData = {
        %{$LinkListWithData},
       
    };

    # get link table view mode
    my $LinkTableViewMode = $ConfigObject->Get('LinkObject::ViewMode');

    # create the link table
    my $LinkTableStrg = $LayoutObject->LinkObjectTableCreate(
        LinkListWithData => $LinkListWithData,
        ViewMode         => $LinkTableViewMode,
    );

    # output the link table
    if ($LinkTableStrg) {
        $LayoutObject->Block(
            Name => 'LinkTable' . $LinkTableViewMode,
            Data => {
                LinkTableStrg => $LinkTableStrg,
            },
        );
    }	
    # remember if user already closed message about links in iframes
    if ( !defined $Self->{DoNotShowBrowserLinkMessage} ) {
        if ( $UserPreferences{UserAgentDoNotShowBrowserLinkMessage} ) {
            $Self->{DoNotShowBrowserLinkMessage} = 1;
        }
        else {
            $Self->{DoNotShowBrowserLinkMessage} = 0;
        }
    }

    # show message about links in iframes, if user didn't close it already
    if ( !$Self->{DoNotShowBrowserLinkMessage} ) {
        $LayoutObject->Block(
            Name => 'BrowserLinkMessage',
        );
    }

    # get security restriction setting for iframes
    # security="restricted" may break SSO - disable this feature if requested
    my $MSSecurityRestricted;
    if ( $ConfigObject->Get('DisableMSIFrameSecurityRestricted') ) {
        $MSSecurityRestricted = '';
    }
    else {
        $MSSecurityRestricted = 'security="restricted"';
    }



    # get the dynamic fields for this screen
    my $DynamicField = $DynamicFieldObject->DynamicFieldListGet(
	Valid      => 1,
	ObjectType  => [ 'PaS' ],
	FieldFilter => $ConfigObject->Get("PaS::Frontend::$Self->{Action}")->{DynamicField} || {},
    );


    # cycle trough the activated Dynamic Fields
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{$DynamicField} ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $Value = $DynamicFieldBackendObject->ValueGet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $PaSID,
        );

        # get print string for this dynamic field
        my $ValueStrg = $DynamicFieldBackendObject->DisplayValueRender(
            DynamicFieldConfig => $DynamicFieldConfig,
            Value              => $Value,
            ValueMaxChars      => 100,
            LayoutObject       => $LayoutObject,
        );

        # for empty values
        if ( !$ValueStrg->{Value} ) {
            $ValueStrg->{Value} = '-';
        }

        my $Label = $DynamicFieldConfig->{Label};

        $LayoutObject->Block(
            Name => 'DynamicField',
            Data => {
                Label => $Label,
            },
        );

        if ( $ValueStrg->{Link} ) {

            # output link element
            $LayoutObject->Block(
                Name => 'DynamicFieldLink',
                Data => {
                    %{$PaS},
                    Value                       => $ValueStrg->{Value},
                    Title                       => $ValueStrg->{Title},
                    Link                        => $ValueStrg->{Link},
                    $DynamicFieldConfig->{Name} => $ValueStrg->{Title}
                },
            );
        }
        else {

            # output non link element
            $LayoutObject->Block(
                Name => 'DynamicFieldPlain',
                Data => {
                    Value => $ValueStrg->{Value},
                    Title => $ValueStrg->{Title},
                },
            );
        }

        # example of dynamic fields order customization
        $LayoutObject->Block(
            Name => 'DynamicField' . $DynamicFieldConfig->{Name},
            Data => {
                Label => $Label,
                Value => $ValueStrg->{Value},
                Title => $ValueStrg->{Title},
            },
        );
    }

	open(my $Fh, '>', '/opt/otrs/var/AgentPasZoom.pm.log');
	use Data::Dumper;
	print $Fh Dumper $PaS;
	close($Fh);

	$PaS->{Create2Time} = 'Test Data';
	

    # start template output
    $LayoutObject->Block(
        TemplateFile => 'AgentPaSZoom',
         Name => 'Meta',
        Data         => {
            %{$PaS},
        },
    );

  # output meta block
    $LayoutObject->Block(
        Name => 'Meta',
        Data => {
            %{$PaS},
        },
    );
	 # get attachments
    my @Attachments = $PaSObject->PaSAttachmentList(
        PaSID => $PaSID,
    );
	
    # show attachments
    ATTACHMENT:
    for my $Filename (@Attachments) {

        # get info about file
        my $AttachmentData = $PaSObject->PaSAttachmentGet(
            PaSID => $PaSID,
            Filename => $Filename,
        );

        # check for attachment information
        next ATTACHMENT if !$AttachmentData;

        # do not show inline attachments in attachments list (they have a content id)
        next ATTACHMENT if $AttachmentData->{Preferences}->{ContentID};
       
        # show block
        $LayoutObject->Block(
            Name => 'AttachmentRow',
            Data => {
                %{$PaS},
                %{$AttachmentData},
            },
        );
    }
     $Output .= $LayoutObject->Output(
        TemplateFile => 'AgentPaSZoom',
        Data         => {
            %{$PaS},
          
        },
    );
    # add footer
    $Output .= $LayoutObject->Footer();

    return $Output;
}

1;
