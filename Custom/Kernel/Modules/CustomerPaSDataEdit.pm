# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::CustomerPaSDataEdit;

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
        }
    );


    $Param{TicketID} = $ParamObject->GetParam( Param => 'TicketID' );
# 
    if ($Self->{Subaction} eq 'UpdateData') {
        my ( $Self, %Param ) = @_;
        
        $Param{TicketID} = $ParamObject->GetParam( Param => 'TicketID' );
        my $TicketID = $ParamObject->GetParam( Param => 'TicketID' ) || '';
        my $ServiceRequestType = $ParamObject->GetParam( Param => 'ServiceRequestType' ) || '';

       my %equipmentdata;
       if ($GetParam{ServiceRequestType} eq 'Move In/Out equipment') {
           # body...
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
                
        my %Ticket = $TicketObject->TicketGet(
            TicketID => $TicketID,
            UserID   => $Self->{UserID},
        );

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

            my $body = $CustomBody .  "**Special Instructions** <br> $GetParam{Body}<br>";

            my $ArticleObject        = $Kernel::OM->Get('Kernel::System::Ticket::Article');
            my $ArticleBackendObject = $ArticleObject->BackendForChannel( ChannelName => 'Internal' );

            my $From      = "\"$FullName\" <$Self->{UserEmail}>";
            my $ArticleID = $ArticleBackendObject->ArticleCreate(
                TicketID             => $TicketID,
                IsVisibleForCustomer => 1,
                SenderType           => 'customer',
                From                 => $From,
                Subject              => 'Ticket Updated',
                Body                 => $body,
                MimeType             => $MimeType,
                Charset              => $LayoutObject->{UserCharset},
                UserID               => $ConfigObject->Get('CustomerPanelUserID'),
                HistoryType          => 'WebRequestCustomer',
                HistoryComment       => $Config->{HistoryComment} || '%%',
                AutoResponseType     => ( $ConfigObject->Get('AutoResponseForWebTickets') )
                ? 'auto reply'
                : '',
                OrigHeader => {
                    From    => $From,
                    To      => 'System',
                    Subject => $GetParam{Subject},
                    Body    => $PlainBody,
                },
            );

            if($ArticleID){
                if($GetParam{ServiceRequestType} eq 'Access card requests'){
                   $PaSServiceRequestObject->UpdateAccess_Card_Requests_Details( %FormData ); 
                   # $PaSServiceRequestObject->Update_equipment_Details( %Param ); 
                }elsif($GetParam{ServiceRequestType} eq 'Move In/Out equipment'){

                    $PaSServiceRequestObject->UpdateMoveInOutEquipmentDetails( %FormData );

                    foreach my $x (keys %FormData ) {
                        $Kernel::OM->Get('Kernel::System::Log')->Log(
                            Priority => 'error',
                            Message  => "Values >>> $x  >>>> $FormData{$x}",
                        );
                    }

                    for my $row (keys %equipmentdata) {
                        $Param{Desc} = $equipmentdata{$row}->{Desc};
                        $Param{Brand} = $equipmentdata{$row}->{Brand};
                        $Param{Quantity} = $equipmentdata{$row}->{Quantity};
                        $Param{Weight} = $equipmentdata{$row}->{weight};
                        $Param{ACDC} = $equipmentdata{$row}->{ACDC};
                        $Param{ITLoad} = $equipmentdata{$row}->{IT};
                        
                        if ($Param{Desc}) {
                            $PaSServiceRequestObject->Update_equipment_Details( %Param );
                        }
                    }
                }

                $TicketObject->StateSet(
                    TicketID => $TicketID,
                    StateID    => 14,
                    UserID   => $ConfigObject->Get('CustomerPanelUserID'),
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

        return $LayoutObject->Redirect(
            OP => "Action=CustomerDashboard;",
        );

    }
    else{

        foreach my $PaSID (@$PaSIDS) {
            # get linked objects which are directly linked with this PaS object
            my $LinkListWithData = $LinkObject->LinkListWithData(
                Object => 'PaS',
                Key    => $PaSID,
                State  => 'Valid',
                UserID => $Self->{UserID},
            );
            my %AccessData;
            # my %MoveInOutData;
            if($GetParam{ServiceRequestType} eq 'Access card requests'){
                %AccessData = $PaSServiceRequestObject->GetAccessCardData( TicketID => $Param{TicketID});
            }elsif($GetParam{ServiceRequestType} eq 'Move In/Out equipment'){
                %AccessData = $PaSServiceRequestObject->GetMoveInOutEquipmentDetails( TicketID => $Param{TicketID});
                foreach my $x (keys %AccessData) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message  => "Values >>> $x  >>>> $AccessData{$x}",
                    );
                }  
            }

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
                    
                            if($DirectionList->{$ObjectKey}->{DynamicField_QuestionType} eq 'Multiselect'){
                                my @splitdata = split(',', $AccessData{$arrQuestion{$ObjectKey}{'Question'}});
                                $arrQuestion{$ObjectKey}{'Value'} = \@splitdata;
                            }else{
                                $arrQuestion{$ObjectKey}{'Value'} = $AccessData{$arrQuestion{$ObjectKey}{'Question'}};
                            }

                            # my $input_string = $DirectionList->{$ObjectKey}->{DynamicField_Question};
                            # $Kernel::OM->Get('Kernel::System::Log')->Log(
                            #     Priority => 'error',
                            #     Message  => "Values 55>>>  >>>> $input_string",
                            # );

                            my @values = split(',', $DirectionList->{$ObjectKey}->{DynamicField_Answers});
                            $arrQuestion{$ObjectKey}{'Answer'}       = \@values;


                            $LayoutObject->Block(
                                Name => 'Assets',
                                Data => {%{$arrQuestion{$ObjectKey}},
                                %AccessData,}
                            );
                            
                            $LinkList{$Object}->{$ObjectKey}->{$LinkType} = $Direction;
                        }
                    }
                }
            }
        }

        if($GetParam{ServiceRequestType} eq 'Move In/Out equipment'){
            my %EquepmentData = $PaSServiceRequestObject->GetEquipmentdData( TicketID => $Param{TicketID} );

            $LayoutObject->Block(
                Name => 'EquipmentDetails',
                Data => \%EquepmentData,
            );
        }
    }

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
        TemplateFile => 'CustomerPaSDataEdit',
        Data         => \%Param,
    );

    # get page footer
    $Output .= $LayoutObject->CustomerFooter();

    # return page
    return $Output;
}


1;