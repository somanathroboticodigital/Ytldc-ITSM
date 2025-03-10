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

package Kernel::GenericInterface::Operation::Ticket::TicketCreate;

use strict;
use warnings;

use parent qw(
    Kernel::GenericInterface::Operation::Common
    Kernel::GenericInterface::Operation::Ticket::Common
);

# core modules

# CPAN modules

# OTOBO modules
use Kernel::System::VariableCheck qw(IsArrayRefWithData IsHashRefWithData IsString IsStringWithData);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::GenericInterface::Operation::Ticket::TicketCreate - GenericInterface Ticket TicketCreate Operation backend

=head1 PUBLIC INTERFACE

=head2 new()

usually, you want to create an instance of this
by using C<Kernel::GenericInterface::Operation->new();>.

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = bless {}, $Type;

    # check needed objects
    for my $Needed (qw( DebuggerObject WebserviceID )) {
        if ( !$Param{$Needed} ) {
            return {
                Success      => 0,
                ErrorMessage => "Got no $Needed!",
            };
        }

        $Self->{$Needed} = $Param{$Needed};
    }

    $Self->{Config}    = $Kernel::OM->Get('Kernel::Config')->Get('GenericInterface::Operation::TicketCreate');
    $Self->{Operation} = $Param{Operation};

    return $Self;
}

=head2 Run()

perform TicketCreate Operation. This will return the created ticket number.

    my $Result = $OperationObject->Run(
        Data => {
            UserLogin         => 'some agent login',                            # UserLogin or CustomerUserLogin or SessionID is
                                                                                #   required
            CustomerUserLogin => 'some customer login',
            SessionID         => 123,

            Password  => 'some password',                                       # if UserLogin or CustomerUserLogin is sent then
                                                                                #   Password is required

            Ticket => {
                Title      => 'some ticket title',

                QueueID       => 123,                                           # QueueID or Queue is required
                Queue         => 'some queue name',

                LockID        => 123,                                           # optional
                Lock          => 'some lock name',                              # optional
                TypeID        => 123,                                           # optional
                Type          => 'some type name',                              # optional
                ServiceID     => 123,                                           # optional
                Service       => 'some service name',                           # optional
                SLAID         => 123,                                           # optional
                SLA           => 'some SLA name',                               # optional

                StateID       => 123,                                           # StateID or State is required
                State         => 'some state name',

                PriorityID    => 123,                                           # PriorityID or Priority is required
                Priority      => 'some priority name',

                OwnerID       => 123,                                           # optional
                Owner         => 'some user login',                             # optional
                ResponsibleID => 123,                                           # optional
                Responsible   => 'some user login',                             # optional
                CustomerUser  => 'some customer user login',

                PendingTime {       # optional
                    Year   => 2011,
                    Month  => 12
                    Day    => 03,
                    Hour   => 23,
                    Minute => 05,
                },
                # or
                # PendingTime {
                #     Diff => 10080, # Pending time in minutes
                #},
            },
            Article => {
                CommunicationChannel            => 'Email',                    # CommunicationChannel or CommunicationChannelID must be provided.
                CommunicationChannelID          => 1,
                IsVisibleForCustomer            => 1,                          # optional
                SenderTypeID                    => 123,                        # optional
                SenderType                      => 'some sender type name',    # optional
                AutoResponseType                => 'some auto response type',  # optional
                From                            => 'some from string',         # optional
                Subject                         => 'some subject',
                Body                            => 'some body',
                ContentType                     => 'some content type',        # ContentType or MimeType and Charset is required
                MimeType                        => 'some mime type',
                Charset                         => 'some charset',
                HistoryType                     => 'some history type',        # optional
                HistoryComment                  => 'Some  history comment',    # optional
                TimeUnit                        => 123,                        # optional
                NoAgentNotify                   => 1,                          # optional
                ForceNotificationToUserID       => [1, 2, 3]                   # optional
                ExcludeNotificationToUserID     => [1, 2, 3]                   # optional
                ExcludeMuteNotificationToUserID => [1, 2, 3]                   # optional
            },

            DynamicField => [                                                  # optional
                {
                    Name   => 'some name',
                    Value  => $Value,                                          # value type depends on the dynamic field
                },
                # ...
            ],
            # or
            # DynamicField => {
            #    Name   => 'some name',
            #    Value  => $Value,
            #},

            Attachment => [
                {
                    Content     => 'content'                                 # base64 encoded
                    ContentType => 'some content type'
                    Filename    => 'some fine name'
                },
                # ...
            ],
            #or
            #Attachment => {
            #    Content     => 'content'
            #    ContentType => 'some content type'
            #    Filename    => 'some fine name'
            #},
        },
    );

    $Result = {
        Success         => 1,                       # 0 or 1
        ErrorMessage    => '',                      # in case of error
        Data            => {                        # result data payload after Operation
            TicketID    => 123,                     # Ticket  ID number in OTOBO (help desk system)
            TicketNumber => 2324454323322           # Ticket Number in OTOBO (Help desk system)
            ArticleID   => 43,                      # Article ID number in OTOBO (help desk system)
            Error => {                              # should not return errors
                    ErrorCode    => 'Ticket.Create.ErrorCode'
                    ErrorMessage => 'Error Description'
            },

            # If IncludeTicketData is enabled
            Ticket => [
                {
                    TicketNumber       => '20101027000001',
                    Title              => 'some title',
                    TicketID           => 123,
                    State              => 'some state',
                    StateID            => 123,
                    StateType          => 'some state type',
                    Priority           => 'some priority',
                    PriorityID         => 123,
                    Lock               => 'lock',
                    LockID             => 123,
                    Queue              => 'some queue',
                    QueueID            => 123,
                    CustomerID         => 'customer_id_123',
                    CustomerUserID     => 'customer_user_id_123',
                    Owner              => 'some_owner_login',
                    OwnerID            => 123,
                    Type               => 'some ticket type',
                    TypeID             => 123,
                    SLA                => 'some sla',
                    SLAID              => 123,
                    Service            => 'some service',
                    ServiceID          => 123,
                    Responsible        => 'some_responsible_login',
                    ResponsibleID      => 123,
                    Age                => 3456,
                    Created            => '2010-10-27 20:15:00'
                    CreateBy           => 123,
                    Changed            => '2010-10-27 20:15:15',
                    ChangeBy           => 123,
                    ArchiveFlag        => 'y',

                    DynamicField => [
                        {
                            Name  => 'some name',
                            Value => 'some value',
                        },
                    ],

                    # (time stamps of expected escalations)
                    EscalationResponseTime           (unix time stamp of response time escalation)
                    EscalationUpdateTime             (unix time stamp of update time escalation)
                    EscalationSolutionTime           (unix time stamp of solution time escalation)

                    # (general escalation info of nearest escalation type)
                    EscalationDestinationIn          (escalation in e. g. 1h 4m)
                    EscalationDestinationTime        (date of escalation in unix time, e. g. 72193292)
                    EscalationDestinationDate        (date of escalation, e. g. "2009-02-14 18:00:00")
                    EscalationTimeWorkingTime        (seconds of working/service time till escalation, e. g. "1800")
                    EscalationTime                   (seconds total till escalation of nearest escalation time type - response, update or solution time, e. g. "3600")

                    # (detailed escalation info about first response, update and solution time)
                    FirstResponseTimeEscalation      (if true, ticket is escalated)
                    FirstResponseTimeNotification    (if true, notify - x% of escalation has reached)
                    FirstResponseTimeDestinationTime (date of escalation in unix time, e. g. 72193292)
                    FirstResponseTimeDestinationDate (date of escalation, e. g. "2009-02-14 18:00:00")
                    FirstResponseTimeWorkingTime     (seconds of working/service time till escalation, e. g. "1800")
                    FirstResponseTime                (seconds total till escalation, e. g. "3600")

                    UpdateTimeEscalation             (if true, ticket is escalated)
                    UpdateTimeNotification           (if true, notify - x% of escalation has reached)
                    UpdateTimeDestinationTime        (date of escalation in unix time, e. g. 72193292)
                    UpdateTimeDestinationDate        (date of escalation, e. g. "2009-02-14 18:00:00")
                    UpdateTimeWorkingTime            (seconds of working/service time till escalation, e. g. "1800")
                    UpdateTime                       (seconds total till escalation, e. g. "3600")

                    SolutionTimeEscalation           (if true, ticket is escalated)
                    SolutionTimeNotification         (if true, notify - x% of escalation has reached)
                    SolutionTimeDestinationTime      (date of escalation in unix time, e. g. 72193292)
                    SolutionTimeDestinationDate      (date of escalation, e. g. "2009-02-14 18:00:00")
                    SolutionTimeWorkingTime          (seconds of working/service time till escalation, e. g. "1800")
                    SolutionTime                     (seconds total till escalation, e. g. "3600")

                    Article => [
                        {
                            ArticleID
                            From
                            To
                            Cc
                            Subject
                            Body
                            ReplyTo
                            MessageID
                            InReplyTo
                            References
                            SenderType
                            SenderTypeID
                            CommunicationChannelID
                            IsVisibleForCustomer
                            ContentType
                            Charset
                            MimeType
                            IncomingTime

                            DynamicField => [
                                {
                                    Name  => 'some name',
                                    Value => 'some value',
                                },
                            ],

                            Attachment => [
                                {
                                    Content            => "xxxx",     # actual attachment contents, base64 enconded
                                    ContentAlternative => "",
                                    ContentID          => "",
                                    ContentType        => "application/pdf",
                                    Filename           => "StdAttachment-Test1.pdf",
                                    Filesize           => "4.6 KBytes",
                                    FilesizeRaw        => 4722,
                                },
                            ],
                        },
                    ],
                },
            ],
        },
    };

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    my $Result = $Self->Init(
        WebserviceID => $Self->{WebserviceID},
    );

    if ( !$Result->{Success} ) {
        $Self->ReturnError(
            ErrorCode    => 'Webservice.InvalidConfiguration',
            ErrorMessage => $Result->{ErrorMessage},
        );
    }

    # check needed stuff
    if (
        !$Param{Data}->{UserLogin}
        && !$Param{Data}->{CustomerUserLogin}
        && !$Param{Data}->{SessionID}
        && !$Param{Data}->{access_token}
        )
    {
        return $Self->ReturnError(
            ErrorCode    => 'TicketCreate.MissingParameter',
            ErrorMessage => "TicketCreate: UserLogin, CustomerUserLogin, access_token or SessionID is required!",
        );
    }

    if ( $Param{Data}->{UserLogin} || $Param{Data}->{CustomerUserLogin} ) {

        if ( !$Param{Data}->{Password} )
        {
            return $Self->ReturnError(
                ErrorCode    => 'TicketCreate.MissingParameter',
                ErrorMessage => "TicketCreate: Password or SessionID is required!",
            );
        }
    }

    # authenticate user
    my ( $UserID, $UserType ) = $Self->Auth(
        %Param,
    );

    if ( !$UserID ) {
        return $Self->ReturnError(
            ErrorCode    => 'TicketCreate.AuthFail',
            ErrorMessage => "TicketCreate: User could not be authenticated!",
        );
    }

    my $PermissionUserID = $UserID;
    if ( $UserType eq 'Customer' ) {
        $UserID = $Kernel::OM->Get('Kernel::Config')->Get('CustomerPanelUserID');
    }

    # check needed hashes
    for my $Needed (qw(Ticket Article)) {
        if ( !IsHashRefWithData( $Param{Data}->{$Needed} ) ) {
            return $Self->ReturnError(
                ErrorCode    => 'TicketCreate.MissingParameter',
                ErrorMessage => "TicketCreate: $Needed parameter is missing or not valid!",
            );
        }
    }


    # check optional array/hashes
    for my $Optional (qw(DynamicField Attachment AssetDetails)) {
        if (
            defined $Param{Data}->{$Optional}
            && !IsHashRefWithData( $Param{Data}->{$Optional} )
            && !IsArrayRefWithData( $Param{Data}->{$Optional} )
            && !IsArrayRefWithData( $Param{Data}->{$Optional} )
            )
        {
            return $Self->ReturnError(
                ErrorCode    => 'TicketCreate.MissingParameter',
                ErrorMessage => "TicketCreate: $Optional parameter is missing or not valid!",
            );
        }
    }
    

    # isolate ticket parameter
    my $Ticket = $Param{Data}->{Ticket};
    # my $AssetDetails = $Param{Data}->{AssetDetails};

    # remove leading and trailing spaces
    for my $Attribute ( sort keys %{$Ticket} ) {
        if ( ref $Attribute ne 'HASH' && ref $Attribute ne 'ARRAY' ) {

            #remove leading spaces
            $Ticket->{$Attribute} =~ s{\A\s+}{};

            #remove trailing spaces
            $Ticket->{$Attribute} =~ s{\s+\z}{};
        }
    }
    if ( IsHashRefWithData( $Ticket->{PendingTime} ) ) {
        for my $Attribute ( sort keys %{ $Ticket->{PendingTime} } ) {
            if ( ref $Attribute ne 'HASH' && ref $Attribute ne 'ARRAY' ) {

                #remove leading spaces
                $Ticket->{PendingTime}->{$Attribute} =~ s{\A\s+}{};

                #remove trailing spaces
                $Ticket->{PendingTime}->{$Attribute} =~ s{\s+\z}{};
            }
        }
    }

    # check Ticket attribute values
    my $TicketCheck = $Self->_CheckTicket( Ticket => $Ticket );

    if ( !$TicketCheck->{Success} ) {
        return $Self->ReturnError( %{$TicketCheck} );
    }

    # check create permissions
    my $Permission = $Self->CheckCreatePermissions(
        Ticket   => $Ticket,
        UserID   => $PermissionUserID,
        UserType => $UserType,
    );

    if ( !$Permission ) {
        return $Self->ReturnError(
            ErrorCode    => 'TicketCreate.AccessDenied',
            ErrorMessage => "TicketCreate: Can not create tickets in given Queue or QueueID!",
        );
    }

    # isolate Article parameter
    my $Article = $Param{Data}->{Article};
    $Article->{UserType} = $UserType;

    # remove leading and trailing spaces
    for my $Attribute ( sort keys %{$Article} ) {
        if ( ref $Attribute ne 'HASH' && ref $Attribute ne 'ARRAY' ) {

            #remove leading spaces
            $Article->{$Attribute} =~ s{\A\s+}{};

            #remove trailing spaces
            $Article->{$Attribute} =~ s{\s+\z}{};
        }
    }
    if ( IsHashRefWithData( $Article->{OrigHeader} ) ) {
        for my $Attribute ( sort keys %{ $Article->{OrigHeader} } ) {
            if ( ref $Attribute ne 'HASH' && ref $Attribute ne 'ARRAY' ) {

                #remove leading spaces
                $Article->{OrigHeader}->{$Attribute} =~ s{\A\s+}{};

                #remove trailing spaces
                $Article->{OrigHeader}->{$Attribute} =~ s{\s+\z}{};
            }
        }
    }

    # Check attributes that can be set by sysconfig.
    if ( !$Article->{AutoResponseType} ) {
        $Article->{AutoResponseType} = $Self->{Config}->{AutoResponseType} || '';
    }

    # TODO: GenericInterface::Operation::TicketCreate###CommunicationChannel
    if ( !$Article->{CommunicationChannelID} && !$Article->{CommunicationChannel} ) {
        $Article->{CommunicationChannel} = 'Internal';
    }
    if ( !defined $Article->{IsVisibleForCustomer} ) {
        $Article->{IsVisibleForCustomer} = $Self->{Config}->{IsVisibleForCustomer} // 1;
    }
    if ( !$Article->{SenderTypeID} && !$Article->{SenderType} ) {
        $Article->{SenderType} = $UserType eq 'User' ? 'agent' : 'customer';
    }
    if ( !$Article->{HistoryType} ) {
        $Article->{HistoryType} = $Self->{Config}->{HistoryType} || '';
    }
    if ( !$Article->{HistoryComment} ) {
        $Article->{HistoryComment} = $Self->{Config}->{HistoryComment} || '';
    }

    # check Article attribute values
    my $ArticleCheck = $Self->_CheckArticle( Article => $Article );

    if ( !$ArticleCheck->{Success} ) {
        if ( !$ArticleCheck->{ErrorCode} ) {
            return {
                Success => 0,
                %{$ArticleCheck},
            };
        }
        return $Self->ReturnError( %{$ArticleCheck} );
    }

    my $DynamicField;
    my @DynamicFieldList;

    if ( defined $Param{Data}->{DynamicField} ) {

        # isolate DynamicField parameter
        $DynamicField = $Param{Data}->{DynamicField};

        # homogenate input to array
        if ( ref $DynamicField eq 'HASH' ) {
            push @DynamicFieldList, $DynamicField;
        }
        else {
            @DynamicFieldList = @{$DynamicField};
        }

        # check DynamicField internal structure
        for my $DynamicFieldItem (@DynamicFieldList) {
            if ( !IsHashRefWithData($DynamicFieldItem) ) {
                return {
                    ErrorCode    => 'TicketCreate.InvalidParameter',
                    ErrorMessage =>
                        "TicketCreate: Ticket->DynamicField parameter is invalid!",
                };
            }

            # remove leading and trailing spaces
            for my $Attribute ( sort keys %{$DynamicFieldItem} ) {
                if ( ref $Attribute ne 'HASH' && ref $Attribute ne 'ARRAY' ) {

                    #remove leading spaces
                    $DynamicFieldItem->{$Attribute} =~ s{\A\s+}{};

                    #remove trailing spaces
                    $DynamicFieldItem->{$Attribute} =~ s{\s+\z}{};
                }
            }

            # check DynamicField attribute values
            my $DynamicFieldCheck = $Self->_CheckDynamicField( DynamicField => $DynamicFieldItem );

            if ( !$DynamicFieldCheck->{Success} ) {
                return $Self->ReturnError( %{$DynamicFieldCheck} );
            }
        }
    }

    my $Attachment;
    my @AttachmentList;

    if ( defined $Param{Data}->{Attachment} ) {

        # isolate Attachment parameter
        $Attachment = $Param{Data}->{Attachment};

        # homogenate input to array
        if ( ref $Attachment eq 'HASH' ) {
            push @AttachmentList, $Attachment;
        }
        else {
            @AttachmentList = @{$Attachment};
        }

        # check Attachment internal structure
        for my $AttachmentItem (@AttachmentList) {
            if ( !IsHashRefWithData($AttachmentItem) ) {
                return {
                    ErrorCode    => 'TicketCreate.InvalidParameter',
                    ErrorMessage =>
                        "TicketCreate: Ticket->Attachment parameter is invalid!",
                };
            }

            # remove leading and trailing spaces
            for my $Attribute ( sort keys %{$AttachmentItem} ) {
                if ( ref $Attribute ne 'HASH' && ref $Attribute ne 'ARRAY' ) {

                    #remove leading spaces
                    $AttachmentItem->{$Attribute} =~ s{\A\s+}{};

                    #remove trailing spaces
                    $AttachmentItem->{$Attribute} =~ s{\s+\z}{};
                }
            }

            # check Attachment attribute values
            my $AttachmentCheck = $Self->_CheckAttachment( Attachment => $AttachmentItem );

            if ( !$AttachmentCheck->{Success} ) {
                return $Self->ReturnError( %{$AttachmentCheck} );
            }
        }
    }

    my $AssetDetails;
    my @AssetDetailsList;

    if ( defined $Param{Data}->{AssetDetails} ) {

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Data >>> $Param{Data}->{AssetDetails}",
        );

        # isolate Attachment parameter
        $AssetDetails = $Param{Data}->{AssetDetails};

        # homogenate input to array
        if ( ref $AssetDetails eq 'HASH' ) {
            push @AssetDetailsList, $AssetDetails;
        }
        else {
            @AssetDetailsList = @{$AssetDetails};
        }

        # check Attachment internal structure
        for my $AssetItem (@AssetDetailsList) {
            if ( !IsHashRefWithData($AssetItem) ) {
                return {
                    ErrorCode    => 'TicketCreate.InvalidParameter',
                    ErrorMessage =>
                        "TicketCreate: Ticket->Asset parameter is invalid!",
                };
            }

            # remove leading and trailing spaces
            for my $Attribute ( sort keys %{$AssetItem} ) {
                if ( ref $Attribute ne 'HASH' && ref $Attribute ne 'ARRAY' ) {

                    #remove leading spaces
                    $AssetItem->{$Attribute} =~ s{\A\s+}{};

                    #remove trailing spaces
                    $AssetItem->{$Attribute} =~ s{\s+\z}{};
                }
            }

            # # check Attachment attribute values
            # my $AttachmentCheck = $Self->_CheckAttachment( Attachment => $AttachmentItem );

            # if ( !$AttachmentCheck->{Success} ) {
            #     return $Self->ReturnError( %{$AttachmentCheck} );
            # }
        }
    }

    return $Self->_TicketCreate(
        Ticket           => $Ticket,
        Article          => $Article,
        DynamicFieldList => \@DynamicFieldList,
        AttachmentList   => \@AttachmentList,
        AssetDetailsList => \@AssetDetailsList,
        UserID           => $UserID,
    );
}

=begin Internal:

=head2 _CheckTicket()

checks if the given ticket parameters are valid.

    my $TicketCheck = $OperationObject->_CheckTicket(
        Ticket => $Ticket,                          # all ticket parameters
    );

    returns:

    $TicketCheck = {
        Success => 1,                               # if everything is OK
    }

    $TicketCheck = {
        ErrorCode    => 'Function.Error',           # if error
        ErrorMessage => 'Error description',
    }

=cut

sub _CheckTicket {
    my ( $Self, %Param ) = @_;

    my $Ticket = $Param{Ticket};

    # check ticket internally
    for my $Needed (qw(Title CustomerUser)) {
        if ( !$Ticket->{$Needed} ) {
            return {
                ErrorCode    => 'TicketCreate.MissingParameter',
                ErrorMessage => "TicketCreate: Ticket->$Needed parameter is missing!",
            };
        }
    }

    # check Ticket->CustomerUser
    if ( !$Self->ValidateCustomer( %{$Ticket} ) ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage =>
                "TicketCreate: Ticket->CustomerUser parameter is invalid!",
        };
    }

    # check Ticket->Queue
    if ( !$Ticket->{QueueID} && !$Ticket->{Queue} ) {
        return {
            ErrorCode    => 'TicketCreate.MissingParameter',
            ErrorMessage => "TicketCreate: Ticket->QueueID or Ticket->Queue parameter is required!",
        };
    }
    if ( !$Self->ValidateQueue( %{$Ticket} ) ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage => "TicketCreate: Ticket->QueueID or Ticket->Queue parameter is invalid!",
        };
    }

    # check Ticket->Lock
    if ( $Ticket->{LockID} || $Ticket->{Lock} ) {
        if ( !$Self->ValidateLock( %{$Ticket} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage => "TicketCreate: Ticket->LockID or Ticket->Lock parameter is"
                    . " invalid!",
            };
        }
    }

    # check Ticket->Type
    # Ticket type could be required or not depending on sysconfig option
    if (
        !$Ticket->{TypeID}
        && !$Ticket->{Type}
        && $Kernel::OM->Get('Kernel::Config')->Get('Ticket::Type')
        )
    {
        return {
            ErrorCode    => 'TicketCreate.MissingParameter',
            ErrorMessage => "TicketCreate: Ticket->TypeID or Ticket->Type parameter is required"
                . " by sysconfig option!",
        };
    }
    if ( $Ticket->{TypeID} || $Ticket->{Type} ) {
        if ( !$Self->ValidateType( %{$Ticket} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage =>
                    "TicketCreate: Ticket->TypeID or Ticket->Type parameter is invalid!",
            };
        }
    }

    # check Ticket->Service
    if ( $Ticket->{ServiceID} || $Ticket->{Service} ) {
        if ( !$Self->ValidateService( %{$Ticket} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage =>
                    "TicketCreate: Ticket->ServiceID or Ticket->Service parameter is invalid!",
            };
        }
    }

    # check Ticket->SLA
    if ( $Ticket->{SLAID} || $Ticket->{SLA} ) {
        if ( !$Self->ValidateSLA( %{$Ticket} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage =>
                    "TicketCreate: Ticket->SLAID or Ticket->SLA parameter is invalid!",
            };
        }
    }

    # check Ticket->State
    if ( !$Ticket->{StateID} && !$Ticket->{State} ) {
        return {
            ErrorCode    => 'TicketCreate.MissingParameter',
            ErrorMessage => "TicketCreate: Ticket->StateID or Ticket->State parameter is required!",
        };
    }
    if ( !$Self->ValidateState( %{$Ticket} ) ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage => "TicketCreate: Ticket->StateID or Ticket->State parameter is invalid!",
        };
    }

    # check Ticket->Priority
    if ( !$Ticket->{PriorityID} && !$Ticket->{Priority} ) {
        return {
            ErrorCode    => 'TicketCreate.MissingParameter',
            ErrorMessage => "TicketCreate: Ticket->PriorityID or Ticket->Priority parameter is"
                . " required!",
        };
    }
    if ( !$Self->ValidatePriority( %{$Ticket} ) ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage => "TicketCreate: Ticket->PriorityID or Ticket->Priority parameter is"
                . " invalid!",
        };
    }

    # check Ticket->Owner
    if ( $Ticket->{OwnerID} || $Ticket->{Owner} ) {
        if ( !$Self->ValidateOwner( %{$Ticket} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage =>
                    "TicketCreate: Ticket->OwnerID or Ticket->Owner parameter is invalid!",
            };
        }
    }

    # check Ticket->Responsible
    if ( $Ticket->{ResponsibleID} || $Ticket->{Responsible} ) {
        if ( !$Self->ValidateResponsible( %{$Ticket} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage => "TicketCreate: Ticket->ResponsibleID or Ticket->Responsible"
                    . " parameter is invalid!",
            };
        }
    }

    # check Ticket->PendingTime
    if ( $Ticket->{PendingTime} ) {
        if ( !$Self->ValidatePendingTime( %{$Ticket} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage => "TicketCreate: Ticket->PendingTime parameter is invalid!",
            };
        }
    }

    # if everything is OK then return Success
    return {
        Success => 1,
    };
}

=head2 _CheckArticle()

checks if the given article parameter is valid.

    my $ArticleCheck = $OperationObject->_CheckArticle(
        Article => $Article,                        # all article parameters
    );

    returns:

    $ArticleCheck = {
        Success => 1,                               # if everething is OK
    }

    $ArticleCheck = {
        ErrorCode    => 'Function.Error',           # if error
        ErrorMessage => 'Error description',
    }

=cut

sub _CheckArticle {
    my ( $Self, %Param ) = @_;

    my $Article = $Param{Article};

    # check ticket internally
    for my $Needed (qw(Subject Body AutoResponseType)) {
        if ( !$Article->{$Needed} ) {
            return {
                ErrorCode    => 'TicketCreate.MissingParameter',
                ErrorMessage => "TicketCreate: Article->$Needed parameter is missing!",
            };
        }
    }

    # check Article->AutoResponseType
    if ( !$Article->{AutoResponseType} ) {

        # return internal server error
        return {
            ErrorMessage => "TicketCreate: Article->AutoResponseType parameter is required!"
        };
    }

    if ( !$Self->ValidateAutoResponseType( %{$Article} ) ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage => "TicketCreate: Article->AutoResponseType parameter is invalid!",
        };
    }

    # check Article->CommunicationChannel
    if ( !$Article->{CommunicationChannel} && !$Article->{CommunicationChannelID} ) {

        # return internal server error
        return {
            ErrorMessage => "TicketCreate: Article->CommunicationChannelID or Article->CommunicationChannel parameter"
                . " is required and Sysconfig CommunicationChannelID setting could not be read!"
        };
    }
    if ( !$Self->ValidateArticleCommunicationChannel( %{$Article} ) ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage => "TicketCreate: Article->CommunicationChannel or Article->CommunicationChannelID parameter"
                . " is invalid or not supported!",
        };
    }

    # check Article->SenderType
    if ( !$Article->{SenderTypeID} && !$Article->{SenderType} ) {

        # return internal server error
        return {
            ErrorMessage => "TicketCreate: Article->SenderTypeID or Article->SenderType parameter"
                . " is required and Sysconfig SenderTypeID setting could not be read!"
        };
    }
    if ( !$Self->ValidateSenderType( %{$Article} ) ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage => "TicketCreate: Article->SenderTypeID or Ticket->SenderType parameter"
                . " is invalid!",
        };
    }

    # check Article->From
    if ( $Article->{From} ) {
        if ( !$Self->ValidateFrom( %{$Article} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage => "TicketCreate: Article->From parameter is invalid!",
            };
        }
    }

    # check Article->ContentType vs Article->MimeType and Article->Charset
    if ( !$Article->{ContentType} && !$Article->{MimeType} && !$Article->{Charset} ) {
        return {
            ErrorCode    => 'TicketCreate.MissingParameter',
            ErrorMessage => "TicketCreate: Article->ContentType or Ticket->MimeType and"
                . " Article->Charset parameters are required!",
        };
    }

    if ( $Article->{MimeType} && !$Article->{Charset} ) {
        return {
            ErrorCode    => 'TicketCreate.MissingParameter',
            ErrorMessage => "TicketCreate: Article->Charset is required!",
        };
    }

    if ( $Article->{Charset} && !$Article->{MimeType} ) {
        return {
            ErrorCode    => 'TicketCreate.MissingParameter',
            ErrorMessage => "TicketCreate: Article->MimeType is required!",
        };
    }

    # check Article->MimeType
    if ( $Article->{MimeType} ) {

        $Article->{MimeType} = lc $Article->{MimeType};

        if ( !$Self->ValidateMimeType( $Article->%* ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage => "TicketCreate: Article->MimeType is invalid!",
            };
        }
    }

    # check Article->MimeType
    if ( $Article->{Charset} ) {

        $Article->{Charset} = lc $Article->{Charset};

        if ( !$Self->ValidateCharset( $Article->%* ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage => "TicketCreate: Article->Charset is invalid!",
            };
        }
    }

    # check Article->ContentType
    if ( $Article->{ContentType} ) {

        # The MIME header field Content-Type is only in some parts case insensitive,
        # but lowercasing the whole string simplifies the handling in OTOBO.
        $Article->{ContentType} = lc $Article->{ContentType};

        if ( !$Self->ValidateContentType( ContentType => $Article->{ContentType} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage => "TicketCreate: Article->ContentType is invalid!",
            };
        }
    }

    # check Article->HistoryType
    if ( !$Article->{HistoryType} ) {

        # return internal server error
        return {
            ErrorMessage => "TicketCreate: Article-> HistoryType is required and Sysconfig"
                . " HistoryType setting could not be read!"
        };
    }
    if ( !$Self->ValidateHistoryType( %{$Article} ) ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage => "TicketCreate: Article->HistoryType parameter is invalid!",
        };
    }

    # check Article->HistoryComment
    if ( !$Article->{HistoryComment} ) {

        # return internal server error
        return {
            ErrorMessage => "TicketCreate: Article->HistoryComment is required and Sysconfig"
                . " HistoryComment setting could not be read!"
        };
    }

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # check Article->TimeUnit
    # TimeUnit could be required or not depending on sysconfig option
    if (
        ( !defined $Article->{TimeUnit} || !IsStringWithData( $Article->{TimeUnit} ) )
        && $ConfigObject->{'Ticket::Frontend::AccountTime'}
        && $ConfigObject->{'Ticket::Frontend::NeedAccountedTime'}
        )
    {
        return {
            ErrorCode    => 'TicketCreate.MissingParameter',
            ErrorMessage => "TicketCreate: Article->TimeUnit is required by sysconfig option!",
        };
    }
    if ( $Article->{TimeUnit} ) {
        if ( !$Self->ValidateTimeUnit( %{$Article} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage => "TicketCreate: Article->TimeUnit parameter is invalid!",
            };
        }
    }

    # check Article->NoAgentNotify
    if ( $Article->{NoAgentNotify} && $Article->{NoAgentNotify} ne '1' ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage => "TicketCreate: Article->NoAgent parameter is invalid!",
        };
    }

    # check Article array parameters
    for my $Attribute (
        qw( ForceNotificationToUserID ExcludeNotificationToUserID ExcludeMuteNotificationToUserID )
        )
    {
        if ( defined $Article->{$Attribute} ) {

            # check structure
            if ( IsHashRefWithData( $Article->{$Attribute} ) ) {
                return {
                    ErrorCode    => 'TicketCreate.InvalidParameter',
                    ErrorMessage => "TicketCreate: Article->$Attribute parameter is invalid!",
                };
            }
            else {
                if ( !IsArrayRefWithData( $Article->{$Attribute} ) ) {
                    $Article->{$Attribute} = [ $Article->{$Attribute} ];
                }
                for my $UserID ( @{ $Article->{$Attribute} } ) {
                    if ( !$Self->ValidateUserID( UserID => $UserID ) ) {
                        return {
                            ErrorCode    => 'TicketCreate.InvalidParameter',
                            ErrorMessage => "TicketCreate: Article->$Attribute UserID=$UserID"
                                . " parameter is invalid!",
                        };
                    }
                }
            }
        }
    }

    # if everything is OK then return Success
    return {
        Success => 1,
    };
}

=head2 _CheckDynamicField()

checks if the given dynamic field parameter is valid.

    my $DynamicFieldCheck = $OperationObject->_CheckDynamicField(
        DynamicField => $DynamicField,              # all dynamic field parameters
    );

    returns:

    $DynamicFieldCheck = {
        Success => 1,                               # if everething is OK
    }

    $DynamicFieldCheck = {
        ErrorCode    => 'Function.Error',           # if error
        ErrorMessage => 'Error description',
    }

=cut

sub _CheckDynamicField {
    my ( $Self, %Param ) = @_;

    my $DynamicField = $Param{DynamicField};

    # check DynamicField item internally
    for my $Needed (qw(Name Value)) {
        if (
            !defined $DynamicField->{$Needed}
            || ( !IsString( $DynamicField->{$Needed} ) && ref $DynamicField->{$Needed} ne 'ARRAY' )
            )
        {
            return {
                ErrorCode    => 'TicketCreate.MissingParameter',
                ErrorMessage => "TicketCreate: DynamicField->$Needed  parameter is missing!",
            };
        }
    }

    # check DynamicField->Name
    if ( !$Self->ValidateDynamicFieldName( %{$DynamicField} ) ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage => "TicketCreate: DynamicField->Name parameter is invalid!",
        };
    }

    # check DynamicField->Value
    if ( !$Self->ValidateDynamicFieldValue( %{$DynamicField} ) ) {
        return {
            ErrorCode    => 'TicketCreate.InvalidParameter',
            ErrorMessage => "TicketCreate: DynamicField->Value parameter is invalid!",
        };
    }

    # if everything is OK then return Success
    return {
        Success => 1,
    };
}

=head2 _CheckAttachment()

checks if the given attachment parameter is valid.

    my $AttachmentCheck = $OperationObject->_CheckAttachment(
        Attachment => $Attachment,                  # all attachment parameters
    );

    returns:

    $AttachmentCheck = {
        Success => 1,                               # if everething is OK
    }

    $AttachmentCheck = {
        ErrorCode    => 'Function.Error',           # if error
        ErrorMessage => 'Error description',
    }

=cut

sub _CheckAttachment {
    my ( $Self, %Param ) = @_;

    my $Attachment = $Param{Attachment};

    # check attachment item internally
    for my $Needed (qw(Content ContentType Filename)) {
        if ( !IsStringWithData( $Attachment->{$Needed} ) ) {
            return {
                ErrorCode    => 'TicketCreate.MissingParameter',
                ErrorMessage => "TicketCreate: Attachment->$Needed  parameter is missing!",
            };
        }
    }

    # check Attachment->ContentType
    if ( $Attachment->{ContentType} ) {

        # The MIME header field Content-Type is only in some parts case insensitive,
        # but lowercasing the whole string simplifies the handling in OTOBO.
        $Attachment->{ContentType} = lc $Attachment->{ContentType};

        if ( !$Self->ValidateContentType( ContentType => $Attachment->{ContentType} ) ) {
            return {
                ErrorCode    => 'TicketCreate.InvalidParameter',
                ErrorMessage => "TicketCreate: Attachment->ContentType is invalid!",
            };
        }
    }

    # if everything is OK then return Success
    return {
        Success => 1,
    };
}

=head2 _TicketCreate()

creates a ticket with its article and sets dynamic fields and attachments if specified.

    my $Response = $OperationObject->_TicketCreate(
        Ticket         => $Ticket,       # all ticket parameters
        Article        => $Article,      # all attachment parameters
        DynamicField   => $DynamicField, # all dynamic field parameters
        AttachmentList => $Attachment,   # all attachment parameters
        UserID         => 123,
    );

    returns:

    $Response = {
        Success => 1,                               # if everything was OK
        Data => {
            TicketID     => 123,
            TicketNumber => 'TN3422332',
            ArticleID    => 123,
        }
    }

    $Response = {
        Success      => 0,                         # if unexpected error
        ErrorMessage => "$Param{ErrorCode}: $Param{ErrorMessage}",
    }

=cut

sub _TicketCreate {
    my ( $Self, %Param ) = @_;

    my $Ticket           = $Param{Ticket};
    my $Article          = $Param{Article};
    my $DynamicFieldList = $Param{DynamicFieldList};
    my $AttachmentList   = $Param{AttachmentList};
    my $CustomerUser     = $Ticket->{CustomerUser} || '';
    my $AssetDetailsList     = $Param{AssetDetailsList};

    # Get customer information, that will be used to create the ticket.
    # If TicketCreate CustomerUser parameter is defined,
    #   check if there is CustomerUser in DB with such address,
    # If address, defined in $Ticket->{CustomerUser},
    #    is not valid, ValidateCustomer() will not allowed to run TicketCreate.
    # See more information in bug#14288.
    my $CustomerUserObject = $Kernel::OM->Get('Kernel::System::CustomerUser');
    my %CustomerUserData   = $CustomerUserObject->CustomerUserDataGet(
        User => $Ticket->{CustomerUser},
    );

    if ( !IsHashRefWithData( \%CustomerUserData ) ) {
        my %CustomerSearch = $CustomerUserObject->CustomerSearch(
            PostMasterSearch => $CustomerUser,
            Limit            => 1,
        );

        if ( IsHashRefWithData( \%CustomerSearch ) ) {
            my @CustomerSearchResults = sort keys %CustomerSearch;
            $CustomerUser = $CustomerSearchResults[0];

            %CustomerUserData = $CustomerUserObject->CustomerUserDataGet(
                User => $CustomerUser,
            );
        }

    }
    else {
        $CustomerUser = $CustomerUserData{UserLogin};
    }

    my $CustomerID = $CustomerUserData{UserCustomerID} || '';

    # use user defined CustomerID if defined
    if ( defined $Ticket->{CustomerID} && $Ticket->{CustomerID} ne '' ) {
        $CustomerID = $Ticket->{CustomerID};
    }

    # get database object
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    my $OwnerID;
    if ( $Ticket->{Owner} && !$Ticket->{OwnerID} ) {
        my %OwnerData = $UserObject->GetUserData(
            User => $Ticket->{Owner},
        );
        $OwnerID = $OwnerData{UserID};
    }
    elsif ( defined $Ticket->{OwnerID} ) {
        $OwnerID = $Ticket->{OwnerID};
    }

    my $ResponsibleID;
    if ( $Ticket->{Responsible} && !$Ticket->{ResponsibleID} ) {
        my %ResponsibleData = $UserObject->GetUserData(
            User => $Ticket->{Responsible},
        );
        $ResponsibleID = $ResponsibleData{UserID};
    }
    elsif ( defined $Ticket->{ResponsibleID} ) {
        $ResponsibleID = $Ticket->{ResponsibleID};
    }

    # get ticket object
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

    # create new ticket
    my $TicketID = $TicketObject->TicketCreate(
        Title        => $Ticket->{Title},
        QueueID      => $Ticket->{QueueID} || '',
        Queue        => $Ticket->{Queue}   || '',
        Lock         => 'unlock',
        TypeID       => $Ticket->{TypeID}     || '',
        Type         => $Ticket->{Type}       || '',
        ServiceID    => $Ticket->{ServiceID}  || '',
        Service      => $Ticket->{Service}    || '',
        SLAID        => $Ticket->{SLAID}      || '',
        SLA          => $Ticket->{SLA}        || '',
        StateID      => $Ticket->{StateID}    || '',
        State        => $Ticket->{State}      || '',
        PriorityID   => $Ticket->{PriorityID} || '',
        Priority     => $Ticket->{Priority}   || '',
        OwnerID      => 1,
        CustomerNo   => $CustomerID,
        CustomerUser => $CustomerUser || '',
        UserID       => $Param{UserID},
    );

    if ( !$TicketID ) {
        return {
            Success      => 0,
            ErrorMessage => 'Ticket could not be created, please contact the system administrator',
        };
    }

    # if ( $TicketID ) {
    #     if ($AssetDetails->{UUID}) {
    #         my $AssetlinkAdd =  $Self->AssetlinkAdd(
    #             TicketID        => $TicketID,
    #             AssetID         => $AssetDetails->{UUID},
    #             AssetName       => $AssetDetails->{AssetName},
    #         );

    #         my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
    #         $TicketObject->HistoryAdd(
    #             TicketID     => $TicketID,
    #             CreateUserID => $Param{UserID},
    #             HistoryType  => 'AddNote',
    #             Name         => "\%\%Added Asset link with AssetID $AssetDetails->{UUID}",
    #         );
    #     }
    # }

    # set lock if specified
    if ( $Ticket->{Lock} || $Ticket->{LockID} ) {
        $TicketObject->TicketLockSet(
            TicketID => $TicketID,
            LockID   => $Ticket->{LockID} || '',
            Lock     => $Ticket->{Lock}   || '',
            UserID   => $Param{UserID},
        );
    }

    # get State Data
    my %StateData;
    my $StateID;

    # get state object
    my $StateObject = $Kernel::OM->Get('Kernel::System::State');

    if ( $Ticket->{StateID} ) {
        $StateID = $Ticket->{StateID};
    }
    else {
        $StateID = $StateObject->StateLookup(
            State => $Ticket->{State},
        );
    }

    %StateData = $StateObject->StateGet(
        ID => $StateID,
    );

    # force unlock if state type is close
    if ( $StateData{TypeName} =~ /^close/i ) {

        # set lock
        $TicketObject->TicketLockSet(
            TicketID => $TicketID,
            Lock     => 'unlock',
            UserID   => $Param{UserID},
        );
    }

    # set pending time
    elsif ( $StateData{TypeName} =~ /^pending/i ) {

        # set pending time
        if ( defined $Ticket->{PendingTime} ) {
            $TicketObject->TicketPendingTimeSet(
                UserID   => $Param{UserID},
                TicketID => $TicketID,
                %{ $Ticket->{PendingTime} },
            );
        }
    }

    # set dynamic fields (only for object type 'ticket')
    if ( IsArrayRefWithData($DynamicFieldList) ) {

        DYNAMICFIELD:
        for my $DynamicField ( @{$DynamicFieldList} ) {
            next DYNAMICFIELD if !$Self->ValidateDynamicFieldObjectType( %{$DynamicField} );

            my $Result = $Self->SetDynamicFieldValue(
                %{$DynamicField},
                TicketID => $TicketID,
                UserID   => $Param{UserID},
            );

            if ( !$Result->{Success} ) {
                my $ErrorMessage =
                    $Result->{ErrorMessage} || "Dynamic Field $DynamicField->{Name} could not be"
                    . " set, please contact the system administrator";

                return {
                    Success      => 0,
                    ErrorMessage => $ErrorMessage,
                };
            }
        }
    }

    if ( !defined $Article->{NoAgentNotify} ) {

        # check if new owner is given (then send no agent notify)
        $Article->{NoAgentNotify} = 0;
        if ($OwnerID) {
            $Article->{NoAgentNotify} = 1;
        }
    }

    # set Article From
    my $From;
    if ( $Article->{From} ) {
        $From = $Article->{From};
    }

    # use data from customer user (if customer user is in database)
    elsif ( IsHashRefWithData( \%CustomerUserData ) ) {
        $From = '"' . $CustomerUserData{UserFullname} . '"'
            . ' <' . $CustomerUserData{UserEmail} . '>';
    }

    # otherwise use customer user as sent from the request (it should be an email)
    else {
        $From = $CustomerUser;
    }

    # set Article To
    my $To;
    if ( $Ticket->{Queue} ) {
        $To = $Ticket->{Queue};
    }
    else {
        $To = $Kernel::OM->Get('Kernel::System::Queue')->QueueLookup(
            QueueID => $Ticket->{QueueID},
        );
    }

    if ( !$Article->{CommunicationChannel} ) {

        my %CommunicationChannel = $Kernel::OM->Get('Kernel::System::CommunicationChannel')->ChannelGet(
            ChannelID => $Article->{CommunicationChannelID},
        );
        $Article->{CommunicationChannel} = $CommunicationChannel{ChannelName};
    }

    my $ArticleBackendObject = $Kernel::OM->Get('Kernel::System::Ticket::Article')->BackendForChannel(
        ChannelName => $Article->{CommunicationChannel},
    );

    my $PlainBody = $Article->{Body};

    # Convert article body to plain text, if HTML content was supplied. This is necessary since auto response code
    #   expects plain text content. Please see bug#13397 for more information.
    if ( ( $Article->{ContentType} && $Article->{ContentType} =~ /text\/html/i ) || ( $Article->{MimeType} && $Article->{MimeType} =~ /text\/html/i ) ) {
        $PlainBody = $Kernel::OM->Get('Kernel::System::HTMLUtils')->ToAscii(
            String => $Article->{Body},
        );
    }

    # Create article.
    my $ArticleID = $ArticleBackendObject->ArticleCreate(
        NoAgentNotify        => $Article->{NoAgentNotify} || 0,
        TicketID             => $TicketID,
        SenderTypeID         => $Article->{SenderTypeID} || '',
        SenderType           => $Article->{SenderType}   || '',
        IsVisibleForCustomer => $Article->{IsVisibleForCustomer},
        From                 => $From,
        To                   => $To,
        Subject              => $Article->{Subject},
        Body                 => $Article->{Body},
        MimeType             => $Article->{MimeType}    || '',
        Charset              => $Article->{Charset}     || '',
        ContentType          => $Article->{ContentType} || '',
        UserID               => $Param{UserID},
        HistoryType          => $Article->{HistoryType},
        HistoryComment       => $Article->{HistoryComment} || '%%',
        AutoResponseType     => $Article->{AutoResponseType},
        OrigHeader           => {
            From    => $From,
            To      => $To,
            Subject => $Article->{Subject},
            Body    => $PlainBody,
        },
    );

    if ( !$ArticleID ) {
        return {
            Success      => 0,
            ErrorMessage => 'Article could not be created, please contact the system administrator',
        };
    }

    # set owner (if owner or owner id is given)
    if ($OwnerID) {
        $TicketObject->TicketOwnerSet(
            TicketID  => $TicketID,
            NewUserID => $OwnerID,
            UserID    => $Param{UserID},
        );

        # set lock if no lock was defined
        if ( !$Ticket->{Lock} && !$Ticket->{LockID} ) {
            $TicketObject->TicketLockSet(
                TicketID => $TicketID,
                Lock     => 'lock',
                UserID   => $Param{UserID},
            );
        }
    }

    # else set owner to current agent but do not lock it
    else {
        $TicketObject->TicketOwnerSet(
            TicketID           => $TicketID,
            NewUserID          => $Param{UserID},
            SendNoNotification => 1,
            UserID             => $Param{UserID},
        );
    }

    # set responsible
    if ($ResponsibleID) {
        $TicketObject->TicketResponsibleSet(
            TicketID  => $TicketID,
            NewUserID => $ResponsibleID,
            UserID    => $Param{UserID},
        );
    }

    # time accounting
    if ( $Article->{TimeUnit} ) {
        $TicketObject->TicketAccountTime(
            TicketID  => $TicketID,
            ArticleID => $ArticleID,
            TimeUnit  => $Article->{TimeUnit},
            UserID    => $Param{UserID},
        );
    }

    # set dynamic fields (only for object type 'article')
    if ( IsArrayRefWithData($DynamicFieldList) ) {

        DYNAMICFIELD:
        for my $DynamicField ( @{$DynamicFieldList} ) {

            my $IsArticleDynamicField = $Self->ValidateDynamicFieldObjectType(
                %{$DynamicField},
                Article => 1,
            );
            next DYNAMICFIELD if !$IsArticleDynamicField;

            my $Result = $Self->SetDynamicFieldValue(
                %{$DynamicField},
                TicketID  => $TicketID,
                ArticleID => $ArticleID,
                UserID    => $Param{UserID},
            );

            if ( !$Result->{Success} ) {
                my $ErrorMessage =
                    $Result->{ErrorMessage} || "Dynamic Field $DynamicField->{Name} could not be"
                    . " set, please contact the system administrator";

                return {
                    Success      => 0,
                    ErrorMessage => $ErrorMessage,
                };
            }
        }
    }

    # set attachments
    if ( IsArrayRefWithData($AttachmentList) ) {

        for my $Attachment ( @{$AttachmentList} ) {
            my $Result = $Self->CreateAttachment(
                TicketID   => $TicketID,
                Attachment => $Attachment,
                ArticleID  => $ArticleID,
                UserID     => $Param{UserID}
            );

            if ( !$Result->{Success} ) {
                my $ErrorMessage =
                    $Result->{ErrorMessage} || "Attachment could not be created, please contact"
                    . " the system administrator";

                return {
                    Success      => 0,
                    ErrorMessage => $ErrorMessage,
                };
            }
        }
    }

    if ( IsArrayRefWithData($AssetDetailsList) ) {


        for my $AssetData ( @{$AssetDetailsList} ) {
            my $AssetObject = $Kernel::OM->Get('Kernel::System::AssetLink');
            my $AssetlinkAdd    => $AssetObject->AssetlinkAdd(
                TicketID        => $TicketID,
                AssetID         => $AssetData->{UUID},
                AssetName       => $AssetData->{AssetName},
            );

            $TicketObject->HistoryAdd(
                TicketID     => $TicketID,
                CreateUserID => $Param{UserID},
                HistoryType  => 'AddNote',
                Name         => "\%\%Added Asset link with AssetID $AssetData->{UUID}",
            );

            # if ( !$Result->{Success} ) {
            #     my $ErrorMessage =
            #         $Result->{ErrorMessage} || "Attachment could not be created, please contact"
            #         . " the system administrator";

            #     return {
            #         Success      => 0,
            #         ErrorMessage => $ErrorMessage,
            #     };
            # }
        }
    }

    # get ticket data
    my %TicketData = $TicketObject->TicketGet(
        TicketID      => $TicketID,
        DynamicFields => 1,
        UserID        => $Param{UserID},
    );

    if ( !IsHashRefWithData( \%TicketData ) ) {
        return {
            Success      => 0,
            ErrorMessage => 'Could not get new ticket information, please contact the system'
                . ' administrator',
        };
    }

    # get web service configuration
    my $Webservice = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice')->WebserviceGet(
        ID => $Self->{WebserviceID},
    );

    my $IncludeTicketData;

    # Get operation config, if operation name was supplied.
    if ( $Self->{Operation} ) {
        my $OperationConfig = $Webservice->{Config}->{Provider}->{Operation}->{ $Self->{Operation} };
        $IncludeTicketData = $OperationConfig->{IncludeTicketData};
    }

    if ( !$IncludeTicketData ) {
        return {
            Success => 1,
            Data    => {
                TicketID     => $TicketID,
                TicketNumber => $TicketData{TicketNumber},
                ArticleID    => $ArticleID,
            },
        };
    }

    # extract all dynamic fields from main ticket hash.
    my %TicketDynamicFields;
    TICKETATTRIBUTE:
    for my $TicketAttribute ( sort keys %TicketData ) {
        if ( $TicketAttribute =~ m{\A DynamicField_(.*) \z}msx ) {
            $TicketDynamicFields{$1} = {
                Name  => $1,
                Value => $TicketData{$TicketAttribute},
            };
            delete $TicketData{$TicketAttribute};
        }
    }

    # add dynamic fields as array into 'DynamicField' hash key if any
    if (%TicketDynamicFields) {
        $TicketData{DynamicField} = [ sort { $a->{Name} cmp $b->{Name} } values %TicketDynamicFields ];
    }

    # prepare TicketData and get Article
    my %ArticleData = $ArticleBackendObject->ArticleGet(
        TicketID      => $TicketID,
        ArticleID     => $ArticleID,
        DynamicFields => 1,
    );

    # prepare Article DynamicFields
    my @ArticleDynamicFields;

    # remove all dynamic fields form main ticket hash and set them into an array.
    ARTICLEATTRIBUTE:
    for my $ArticleAttribute ( sort keys %ArticleData ) {
        if ( $ArticleAttribute =~ m{\A DynamicField_(.*) \z}msx ) {
            if ( !exists $TicketDynamicFields{$1} ) {
                push @ArticleDynamicFields, {
                    Name  => $1,
                    Value => $ArticleData{$ArticleAttribute},
                };
            }

            delete $ArticleData{$ArticleAttribute};
        }
    }

    # add dynamic fields array into 'DynamicField' hash key if any
    if (@ArticleDynamicFields) {
        $ArticleData{DynamicField} = \@ArticleDynamicFields;
    }

    # add attachment if the request includes attachments
    if ( IsArrayRefWithData($AttachmentList) ) {
        my %AttachmentIndex = $ArticleBackendObject->ArticleAttachmentIndex(
            ArticleID => $ArticleID,
        );

        my @Attachments;
        $Kernel::OM->Get('Kernel::System::Main')->Require('MIME::Base64');
        ATTACHMENT:
        for my $FileID ( sort keys %AttachmentIndex ) {
            next ATTACHMENT if !$FileID;
            my %Attachment = $ArticleBackendObject->ArticleAttachment(
                ArticleID => $ArticleID,
                FileID    => $FileID,
            );

            next ATTACHMENT if !IsHashRefWithData( \%Attachment );

            # convert content to base64, but prevent 76 chars brake, see bug#14500.
            $Attachment{Content} = MIME::Base64::encode_base64( $Attachment{Content}, '' );
            push @Attachments, {%Attachment};
        }

        # set Attachments data
        if (@Attachments) {
            $ArticleData{Attachment} = \@Attachments;
        }
    }

    $TicketData{Article} = \%ArticleData;

    return {
        Success => 1,
        Data    => {
            TicketID     => $TicketID,
            TicketNumber => $TicketData{TicketNumber},
            ArticleID    => $ArticleID,
            Ticket       => \%TicketData,
        },
    };
}

=end Internal:

=cut

1;
