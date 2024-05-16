# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::CustomerPaSZoom;
## nofilter(TidyAll::Plugin::OTRS::Perl::DBObject)

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

use Kernel::System::VariableCheck qw(:all);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    $Self->{FormID} = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'FormID' );

    # create form id
    if ( !$Self->{FormID} ) {
        $Self->{FormID} = $Kernel::OM->Get('Kernel::System::Web::UploadCache')->FormIDCreate();
    }

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');
    my $LinkObject = $Kernel::OM->Get('Kernel::System::LinkObject');
    my $SessionObject = $Kernel::OM->Get('Kernel::System::AuthSession');
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

    my $DynamicFieldObject  = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $BackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    my $PaSServiceRequestObject = $Kernel::OM->Get('Kernel::System::PaSServiceRequest');

    my $Config = $Kernel::OM->Get('Kernel::Config')->Get("Ticket::Frontend::$Self->{Action}");
    $Param{FormID} = $Self->{FormID};

    my @ParamNames = $ParamObject->GetParamNames();
    # store needed parameters in %GetParam to make it reloadable
    my %GetParam;
    for my $name ( @ParamNames ){
        $GetParam{$name} = $ParamObject->GetParam( Param => $name );
    }
    $Param{ServiceRequestType} = $GetParam{ServiceRequestType};

    my $PaSIDS = $PaSObject->PaSSearch(
        Result => 'ARRAY',
        UserID   => $Self->{UserID},
        DynamicField_PaSCategory =>{
            Equals => $GetParam{ServiceRequestType},
        },
        SortBy  => 'DynamicField_PaSOrder', 
        # OrderBy => 'Up', 
    );

    if ($Self->{Subaction} eq 'AddToCart') {
        # my ( $Self, %Param ) = @_;
        my %equipmentdata;
        if ($GetParam{ServiceRequestType} eq 'Move In/Out equipment'){   # body...
           my @descarray = $ParamObject->GetArray( Param => 'desc');
           my @brandarray = $ParamObject->GetArray( Param => 'brand');
           my @quantityarray = $ParamObject->GetArray( Param => 'quantity');
           my @weightarray = $ParamObject->GetArray( Param => 'weight');
           my @acdcarray = $ParamObject->GetArray( Param => 'ac_dc');
           my @itarray = $ParamObject->GetArray( Param => 'it_load');

            for my $i (0 .. $#descarray) {
                $equipmentdata{"row".($i+1)} = {
                    Desc     => $descarray[$i],
                    Brand    => $brandarray[$i],
                    Quantity => $quantityarray[$i],
                    weight   => $weightarray[$i],
                    ACDC     => $acdcarray[$i],
                    IT       => $itarray[$i],
                };
            }
        }
        
        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        # # check existing
        # my $exists = $PaSObject->UserPaSCheckExisting(
        #     PaSID => $GetParam{PaSID},
        #     UserID => $Self->{UserID},
        # );

        # if ( $exists eq 1 ) {
        #     # update
        #     return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
        #         SQL => 'Update user_product_cart '
        #             . 'Set quantity = ?, subtotal = ? '
        #             . 'WHERE user_id = ? AND pas_id = ? ',
        #         Bind  => [ \$GetParam{quantity}, \$GetParam{subtotal}, \$Self->{UserID}, \$GetParam{PaSID} ],
        #     );
        # }
        # else {
        #     # create the product
        #     my $PaSID = $PaSObject->UserPaSAdd(
        #         UserID      => $Self->{UserID},
        #         %GetParam,
        #     );
        # }

        my $QueueObject  = $Kernel::OM->Get('Kernel::System::Queue');

        # get destination queue
        my $Dest = $ParamObject->GetParam( Param => 'Dest' ) || '';
        my ( $NewQueueID, $To ) = split( /\|\|/, $Dest );
        if ( !$To ) {
            $NewQueueID = $ParamObject->GetParam( Param => 'NewQueueID' ) || '';
            $To         = 'System';
        }

        # fallback, if no destination is given
        if ( !$NewQueueID ) {
            my $Queue = $ParamObject->GetParam( Param => 'Queue' )
                || $Config->{'QueueDefault'}
                || '';
            if ($Queue) {
                my $QueueID = $QueueObject->QueueLookup( Queue => $Queue );
                $NewQueueID = $QueueID;
                $To         = $Queue;
            }
        }


                # create new ticket, do db insert
        my $TicketID = $TicketObject->TicketCreate(
            Queue        => $Config->{'QueueDefault'},
            TypeID       => 3,
            Title        => $GetParam{Subject},
            Priority     => $Config->{'PriorityDefault'},
            Lock         => 'unlock',
            State        => $Config->{StateDefault},
            CustomerID   => $Self->{UserCustomerID},
            CustomerUser => $Self->{UserLogin},
            OwnerID      => $ConfigObject->Get('CustomerPanelUserID'),
            UserID       => $ConfigObject->Get('CustomerPanelUserID'),
        );


       

        # set ticket dynamic fields
        # cycle trough the activated Dynamic Fields for this screen
        # DYNAMICFIELD:
        # for my $DynamicFieldConfig ( @{$DynamicField} ) {
        #     next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
        #     next DYNAMICFIELD if $DynamicFieldConfig->{ObjectType} ne 'Ticket';
        #     next DYNAMICFIELD if !$Visibility{"DynamicField_$DynamicFieldConfig->{Name}"};

        #     # set the value
        #     my $Success = $BackendObject->ValueSet(
        #         DynamicFieldConfig => $DynamicFieldConfig,
        #         ObjectID           => $TicketID,
        #         Value              => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
        #         UserID             => $ConfigObject->Get('CustomerPanelUserID'),
        #     );
        # }

        # # if no article has to be created clean up and return
        # if ( !$VisibilityStd{Article} ) {

        #     # remove pre submitted attachments
        #     $UploadCacheObject->FormIDRemove( FormID => $Self->{FormID} );

        #     # delete hidden fields cache
        #     $Kernel::OM->Get('Kernel::System::Cache')->Delete(
        #         Type => 'HiddenFields',
        #         Key  => $Self->{FormID},
        #     );

        #     # redirect
        #     return $LayoutObject->Redirect(
        #         OP => "Action=$NextScreen;TicketID=$TicketID",
        #     );
        # }

        my $MimeType = 'text/plain';
        if ( $LayoutObject->{BrowserRichText} ) {
            $MimeType = 'text/html';

            # verify html document
            $GetParam{Body} = $LayoutObject->RichTextDocumentComplete(
                String => $GetParam{Body},
            );
        }

        my $PlainBody = $GetParam{Body};

        if ( $LayoutObject->{BrowserRichText} ) {
            $PlainBody = $LayoutObject->RichText2Ascii( String => $GetParam{Body} );
        }

        # create article
        my $FullName = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerName(
            UserLogin => $Self->{UserLogin},
        );

        my $CustomBody = "";
        $Param{TicketID} = $TicketID;

        my %FormData = (TicketID => $TicketID);

        foreach my $PaSID (@$PaSIDS) {
            # get linked objects which are directly linked with this PaS object
            my $LinkListWithData = $LinkObject->LinkListWithData(
                Object => 'PaS',
                Key    => $PaSID,
                State  => 'Valid',
                UserID => $Self->{UserID},
            );

            my %Data = $PaSObject->PaSsGet( PaSID => $PaSID );

            $CustomBody .= "<h3>".$Data{PaSTitle} . " </h3>";

            

            for my $Object ( sort keys %{ $LinkListWithData } ) {

                for my $LinkType ( sort keys %{ $LinkListWithData->{$Object} } ) {

                    # extract link type List
                    my $LinkTypeList = $LinkListWithData->{$Object}->{$LinkType};

                    for my $Direction ( sort keys %{$LinkTypeList} ) {

                        # extract direction list
                        my $DirectionList = $LinkListWithData->{$Object}->{$LinkType}->{$Direction};
                        my @sorted = sort { $DirectionList->{$a}{DynamicField_Order} <=> $DirectionList->{$b}{DynamicField_Order} } keys %$DirectionList;

                        for my $ObjectKey ( sort { $DirectionList->{$a}{DynamicField_Order} <=> $DirectionList->{$b}{DynamicField_Order} } keys %{$DirectionList} ) {

                            if($DirectionList->{$ObjectKey}->{DynamicField_QuestionType} eq 'Multiselect'){
                                my @field_array_val = $ParamObject->GetArray( Param => $DirectionList->{$ObjectKey}->{DynamicField_Question});
                                my $joined_values = join ',', @field_array_val ;
                                $CustomBody .= "<p>".$DirectionList->{$ObjectKey}->{DynamicField_Question}." : ". $joined_values . " </p>";

                                my $input_string = $DirectionList->{$ObjectKey}->{DynamicField_Question};

                                $input_string =~ s/[^\w\s]//g;

                                # Convert all letters to lowercase
                                $input_string =~ tr/A-Z/a-z/;

                                # Replace spaces with underscore
                                $input_string =~ s/\s+/_/g;
                                $FormData{$input_string} = $joined_values;
                            }else{
                                $CustomBody .= "<p>".$DirectionList->{$ObjectKey}->{DynamicField_Question}." : ".$GetParam{$DirectionList->{$ObjectKey}->{DynamicField_Question}} . " </p>";

                                my $input_string = $DirectionList->{$ObjectKey}->{DynamicField_Question};
                                    
                                # Remove special characters
                                $input_string =~ s/[^\w\s]//g;

                                # Convert all letters to lowercase
                                $input_string =~ tr/A-Z/a-z/;

                                # Replace spaces with underscore
                                $input_string =~ s/\s+/_/g;

                                $FormData{$input_string} = $GetParam{$DirectionList->{$ObjectKey}->{DynamicField_Question}};
                            }                        
                        }
                    }
                }
            }
        }

        my $body = $CustomBody .  "Requested By: $GetParam{RequestedFor} <br><br> **Special Instructions** <br> $GetParam{Body}<br>";

        my $ArticleObject        = $Kernel::OM->Get('Kernel::System::Ticket::Article');
        my $ArticleBackendObject = $ArticleObject->BackendForChannel( ChannelName => 'Internal' );

        my $From      = "\"$FullName\" <$Self->{UserEmail}>";
        my $ArticleID = $ArticleBackendObject->ArticleCreate(
            TicketID             => $TicketID,
            IsVisibleForCustomer => 1,
            SenderType           => $Config->{SenderType},
            From                 => $From,
            To                   => $To,
            Subject              => $GetParam{Subject},
            Body                 => $body,
            MimeType             => $MimeType,
            Charset              => $LayoutObject->{UserCharset},
            UserID               => $ConfigObject->Get('CustomerPanelUserID'),
            HistoryType          => $Config->{HistoryType},
            HistoryComment       => $Config->{HistoryComment} || '%%',
            AutoResponseType     => ( $ConfigObject->Get('AutoResponseForWebTickets') )
            ? 'auto reply'
            : '',
            OrigHeader => {
                From    => $From,
                To      => $Self->{UserLogin},
                Subject => $GetParam{Subject},
                Body    => $PlainBody,
            },
            Queue => $QueueObject->QueueLookup( QueueID => $NewQueueID ),
        );

        # foreach my $key (keys %FormData) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "table colum <> $GetParam{ServiceRequestType} "
            );
        # }

        if($ArticleID){
            if($GetParam{ServiceRequestType} eq 'Access card requests'){
               $PaSServiceRequestObject->AddAccess_Card_Requests_Details( %FormData ); 
            }elsif($GetParam{ServiceRequestType} eq 'Move In/Out equipment'){
                $PaSServiceRequestObject->Add_Move_In_Out_Equipment_Details( %FormData );
                for my $row (keys %equipmentdata) {
                    $Param{Desc} = $equipmentdata{$row}->{Desc};
                    $Param{Brand} = $equipmentdata{$row}->{Brand};
                    $Param{Quantity} = $equipmentdata{$row}->{Quantity};
                    $Param{Weight} = $equipmentdata{$row}->{weight};
                    $Param{ACDC} = $equipmentdata{$row}->{ACDC};
                    $Param{ITLoad} = $equipmentdata{$row}->{IT};
                    
                    if ($Param{Desc}) {
                    $PaSServiceRequestObject->Add_equipment_Details( %Param );
                    }
                }
            }

            my $ServiceRequestCategoryConfig = $DynamicFieldObject->DynamicFieldGet(
                Name => 'ServiceRequestCategory',
            );

            my $Success = $BackendObject->ValueSet(
                DynamicFieldConfig => $ServiceRequestCategoryConfig,
                ObjectID           => $TicketID,
                Value              => $GetParam{ServiceRequestType},
                UserID             => $ConfigObject->Get('CustomerPanelUserID'),
            );

            my $Level1ApprovalConfig = $DynamicFieldObject->DynamicFieldGet(
                Name => 'Level1Approval',
            );

            my $Success = $BackendObject->ValueSet(
                DynamicFieldConfig => $Level1ApprovalConfig,
                ObjectID           => $TicketID,
                Value              => $ConfigObject->Get('Manager')->{YTLDC}->{YTLDC_Manager},
                UserID             => $ConfigObject->Get('CustomerPanelUserID'),
            );
            
        }

        if ( !$ArticleID ) {
            my $Output = $LayoutObject->CustomerHeader(
                Title => Translatable('Error'),
            );
            $Output .= $LayoutObject->CustomerError();
            $Output .= $LayoutObject->CustomerFooter();

            return $Output;
        }

        # set article dynamic fields
        # # cycle trough the activated Dynamic Fields for this screen
        # DYNAMICFIELD:
        # for my $DynamicFieldConfig ( @{$DynamicField} ) {
        #     next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
        #     next DYNAMICFIELD if $DynamicFieldConfig->{ObjectType} ne 'Article';
        #     next DYNAMICFIELD if !$Visibility{"DynamicField_$DynamicFieldConfig->{Name}"};

        #     # set the value
        #     my $Success = $BackendObject->ValueSet(
        #         DynamicFieldConfig => $DynamicFieldConfig,
        #         ObjectID           => $ArticleID,
        #         Value              => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
        #         UserID             => $ConfigObject->Get('CustomerPanelUserID'),
        #     );
        # }

        # Permissions check were done earlier
        # if ( $GetParam{FromChatID} ) {
        #     my $ChatObject = $Kernel::OM->Get('Kernel::System::Chat');
        #     my %Chat       = $ChatObject->ChatGet(
        #         ChatID => $GetParam{FromChatID},
        #     );
        #     my @ChatMessageList = $ChatObject->ChatMessageList(
        #         ChatID => $GetParam{FromChatID},
        #     );
        #     my $ChatArticleID;

        #     if (@ChatMessageList) {
        #         for my $Message (@ChatMessageList) {
        #             $Message->{MessageText} = $LayoutObject->Ascii2Html(
        #                 Text        => $Message->{MessageText},
        #                 LinkFeature => 1,
        #             );
        #         }

        #         my $ArticleChatBackend = $ArticleObject->BackendForChannel( ChannelName => 'Chat' );

        #         $ChatArticleID = $ArticleChatBackend->ArticleCreate(
        #             TicketID             => $TicketID,
        #             SenderType           => $Config->{SenderType},
        #             ChatMessageList      => \@ChatMessageList,
        #             IsVisibleForCustomer => 1,
        #             UserID               => $ConfigObject->Get('CustomerPanelUserID'),
        #             HistoryType          => $Config->{HistoryType},
        #             HistoryComment       => $Config->{HistoryComment} || '%%',
        #         );
        #     }
        #     if ($ChatArticleID) {
        #         $ChatObject->ChatDelete(
        #             ChatID => $GetParam{FromChatID},
        #         );
        #     }
        # }

        # get pre loaded attachment

        my $UploadCacheObject = $Kernel::OM->Get('Kernel::System::Web::UploadCache');

        # get all attachments meta data
        my @Attachments = $UploadCacheObject->FormIDGetAllFilesMeta(
            FormID => $Self->{FormID},
        );

        # show attachments
        ATTACHMENT:
        for my $Attachment ( @Attachments ) {
            if (
                $Attachment->{ContentID}
                && $LayoutObject->{BrowserRichText}
                && ( $Attachment->{ContentType} =~ /image/i )
                && ( $Attachment->{Disposition} eq 'inline' )
                )
            {
                next ATTACHMENT;
            }

            push @{ $Param{AttachmentList} }, $Attachment;
        }

        my $UploadCacheObject = $Kernel::OM->Get('Kernel::System::Web::UploadCache');
        my @AttachmentData = $UploadCacheObject->FormIDGetAllFilesData(
            FormID => $Self->{FormID},
        );

        
        # get submitted attachment
        my %UploadStuff = $ParamObject->GetUploadAll(
            Param => 'file_upload',
        );
        if (%UploadStuff) {
            push @AttachmentData, \%UploadStuff;
        }

        # write attachments
        ATTACHMENT:
        for my $Attachment (@AttachmentData) {

            # skip, deleted not used inline images
            my $ContentID = $Attachment->{ContentID};
            if (
                $ContentID
                && ( $Attachment->{ContentType} =~ /image/i )
                && ( $Attachment->{Disposition} eq 'inline' )
                )
            {
                my $ContentIDHTMLQuote = $LayoutObject->Ascii2Html(
                    Text => $ContentID,
                );

                # workaround for link encode of rich text editor, see bug#5053
                my $ContentIDLinkEncode = $LayoutObject->LinkEncode($ContentID);
                $GetParam{Body} =~ s/(ContentID=)$ContentIDLinkEncode/$1$ContentID/g;

                # ignore attachment if not linked in body
                next ATTACHMENT if $GetParam{Body} !~ /(\Q$ContentIDHTMLQuote\E|\Q$ContentID\E)/i;
            }

            # write existing file to backend
            $ArticleBackendObject->ArticleWriteAttachment(
                %{$Attachment},
                ArticleID => $ArticleID,
                UserID    => $ConfigObject->Get('CustomerPanelUserID'),
            );
        }

        # remove pre submitted attachments
        $UploadCacheObject->FormIDRemove( FormID => $Self->{FormID} );

        # delete hidden fields cache
        $Kernel::OM->Get('Kernel::System::Cache')->Delete(
            Type => 'HiddenFields',
            Key  => $Self->{FormID},
        );

        # return $LayoutObject->Redirect(
        #     OP => "Action=CustomerCheckout;PaSID=$GetParam{PaSID}"
        # );

    }
    else {
        foreach my $PaSID (@$PaSIDS) {
            # get linked objects which are directly linked with this PaS object
            my $LinkListWithData = $LinkObject->LinkListWithData(
                Object => 'PaS',
                Key    => $PaSID,
                State  => 'Valid',
                UserID => $Self->{UserID},
            );

            my %Data = $PaSObject->PaSsGet( PaSID => $PaSID );

             $LayoutObject->Block(
                Name => 'PaSDetails',
                Data => \%Data,
            );

            # convert the link list
            my %LinkList;
            my %arrQuestion;
            my %answers;
            for my $Object ( sort keys %{ $LinkListWithData } ) {

                for my $LinkType ( sort keys %{ $LinkListWithData->{$Object} } ) {

                    # extract link type List
                    my $LinkTypeList = $LinkListWithData->{$Object}->{$LinkType};

                    for my $Direction ( sort keys %{$LinkTypeList} ) {

                        # extract direction list
                        my $DirectionList = $LinkListWithData->{$Object}->{$LinkType}->{$Direction};
                        my @sorted = sort { $DirectionList->{$a}{DynamicField_Order} <=> $DirectionList->{$b}{DynamicField_Order} } keys %$DirectionList;

                        for my $ObjectKey ( sort { $DirectionList->{$a}{DynamicField_Order} <=> $DirectionList->{$b}{DynamicField_Order} } keys %{$DirectionList} ) {


                            $arrQuestion{$ObjectKey}{'QuestionType'} = $DirectionList->{$ObjectKey}->{DynamicField_QuestionType};
                            $arrQuestion{$ObjectKey}{'Question'}     = $DirectionList->{$ObjectKey}->{DynamicField_Question};
                            $arrQuestion{$ObjectKey}{'QuestionNumber'}   = $DirectionList->{$ObjectKey}->{QuestionNumber};
                            $arrQuestion{$ObjectKey}{'Mandatory'} = $DirectionList->{$ObjectKey}->{DynamicField_Mandatory};
                            $arrQuestion{$ObjectKey}{'Order'} = $DirectionList->{$ObjectKey}->{DynamicField_Order};
                            $arrQuestion{$ObjectKey}{'Default'} = $DirectionList->{$ObjectKey}->{DynamicField_Default};
                            $arrQuestion{$ObjectKey}{'DefaultText'} = $DirectionList->{$ObjectKey}->{DynamicField_DefaultText};
                    

                            my @values = split(',', $DirectionList->{$ObjectKey}->{DynamicField_Answers});
                            $arrQuestion{$ObjectKey}{'Answer'}       = \@values;

                            $LayoutObject->Block(
                                Name => 'Assets',
                                Data => $arrQuestion{$ObjectKey},
                            );
                            
                            $LinkList{$Object}->{$ObjectKey}->{$LinkType} = $Direction;
                        }
                    }
                }
            }
        }

        if($GetParam{ServiceRequestType} eq 'Move In/Out equipment'){
            $LayoutObject->Block(
                Name => 'EquipmentDetails',
                Data => { },
            );
        }

        $LayoutObject->Block(
            Name => 'Remains',
            
        );
    }
    
    my $PaSID = $ParamObject->GetParam( Param => 'PaSID' );

    

    

   
    # get PaS data
    my $PaS = $PaSObject->PaSGet(
        PaSID => $PaSID,
        UserID   => $Self->{UserID},
    );

    # open(TT, '>', '/opt/otrs/tmp/getparam.log');
    # use Data::Dumper;


    my %Data = $PaSObject->PaSsGet( PaSID => $PaSID );
    my %Attachments = $PaSObject->PaSAttachmentList( PaSID => $PaSID);

    # print TT Dumper \%Data;
    # close(TT);

    for my $key (keys %Attachments) {
        $Data{Filename} = $key;
    }

    # store SLA
    $Data{SLAID} = $PaS->{SLAID};


     # add rich text editor
    if ( $LayoutObject->{BrowserRichText} ) {

        # use height/width defined for this screen
        $Param{RichTextHeight} = $Config->{RichTextHeight} || 0;
        $Param{RichTextWidth}  = $Config->{RichTextWidth}  || 0;

        # set up customer rich text editor
        $LayoutObject->CustomerSetRichTextParameters(
            Data => \%Param,
        );
    }




    my $Output = $LayoutObject->CustomerHeader(
        Title   => $Self->{Subaction},
    );

    # build NavigationBar
    $Output .= $LayoutObject->CustomerNavigationBar();
    $Output .= $LayoutObject->Output(
        TemplateFile => 'CustomerPaSZoom',
        Data         => \%Param,
    );

    # get page footer
    $Output .= $LayoutObject->CustomerFooter();

    # return page
    return $Output;
}

1;