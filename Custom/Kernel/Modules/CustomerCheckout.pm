
#copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::CustomerCheckout;
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

    # get form id
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
    my $SLAObject = $Kernel::OM->Get('Kernel::System::SLA');
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
    # my $TechOpsWebFormsObj = $Kernel::OM->Get('Kernel::System::TechOpsWebForms');
    my @ParamNames = $ParamObject->GetParamNames();
    my $zoomdata;
    # get upload cache object
    my $UploadCacheObject = $Kernel::OM->Get('Kernel::System::Web::UploadCache');

    my $Config = $Kernel::OM->Get('Kernel::Config')->Get("Ticket::Frontend::$Self->{Action}");

    # get Dynamic fields from ParamObject
    my %DynamicFieldValues;

    # get the dynamic fields for this screen
    my $DynamicField = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
        Valid       => 1,
        ObjectType  => [ 'Ticket', 'Article' ],
        FieldFilter => $Config->{DynamicField} || {},
    );

    my $BackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
        # get form id
        $Self->{FormID} = $ParamObject->GetParam( Param => 'FormID' );

        # create form id
        if ( !$Self->{FormID} ) {
            $Self->{FormID} = $UploadCacheObject->FormIDCreate();
        }
        # Remember the reason why saving was not attempted.
        my %ValidationError;
        # get log object
        my $LogObject = $Kernel::OM->Get('Kernel::System::Log');

        # store needed parameters in %GetParam to make it reloadable
        my %GetParam;
        for my $name ( @ParamNames ){
            $GetParam{$name} = $ParamObject->GetParam( Param => $name );
        }

        #Get param
        my $PaSID = $ParamObject->GetParam( Param => 'PaSID' );
        my %Data = $PaSObject->PaSsGet( PaSID => $PaSID );


        # reduce the dynamic fields to only the ones that are designed for customer interface
        my @CustomerDynamicFields;
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{$DynamicField} ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            my $IsCustomerInterfaceCapable = $BackendObject->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsCustomerInterfaceCapable',
             );
            next DYNAMICFIELD if !$IsCustomerInterfaceCapable;

            push @CustomerDynamicFields, $DynamicFieldConfig;
        }
        $DynamicField = \@CustomerDynamicFields;

        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{$DynamicField} ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            # extract the dynamic field value form the web request
            $DynamicFieldValues{ $DynamicFieldConfig->{Name} } =
            $BackendObject->EditFieldValueGet(
                DynamicFieldConfig => $DynamicFieldConfig,
                ParamObject        => $ParamObject,
                LayoutObject       => $LayoutObject,
            );
        }
        ###################

        if ( !$Self->{Subaction} ) {


        } elsif ( $Self->{Subaction} eq 'Remove' ) {

                my ( $Self, %Param ) = @_;


            # delete PaS reference from DB
            return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
                SQL  => 'DELETE FROM user_product_cart WHERE pas_id = ?',
                Bind => [ \$PaSID ],
            );

            # return to Checkout page
            return $LayoutObject->Redirect(
                OP => 'Action=CustomerCheckout',
            );

        }elsif ( $Self->{Subaction} eq 'AJAXUpdate' ) {

                my @TemplateAJAX = ();
                my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
                my $strPrefix                   = '';
                my $strNewPaSNumber     = '';
                $strPrefix = 'SR';
                $strNewPaSNumber = $strPrefix . $TicketObject->TicketCreateNumber();

                @TemplateAJAX = (
                    {
                            Name => 'SelectedPaSRefNo',
                            Data => $strNewPaSNumber,
                    },
                    {
                            Name => 'PaSRefNo',
                            Data => $strNewPaSNumber,
                    },
                );


                # build json
                my $JSON = $LayoutObject->BuildSelectionJSON(
                    [
                            @TemplateAJAX
                    ],
                );

                # return json
                return $LayoutObject->Attachment(
                        ContentType => 'text/plain; charset=' . $LayoutObject->{Charset},
                        Content  => $JSON,
                        Type            => 'inline',
                        NoCache  => 1,
                );
        }
        elsif ( $Self->{Subaction} eq 'Save' )  {
                
            my ( $Self, %Param ) = @_;
                 
            # challenge token check for write action
            $LayoutObject->ChallengeTokenCheck();

            my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
            my $Config       = $Kernel::OM->Get('Kernel::Config')->Get("Ticket::Frontend::$Self->{Action}");

            # challenge token check for write action
            #        $LayoutObject->ChallengeTokenCheck( Type => 'Checkout' );
            $LayoutObject->ChallengeTokenCheck();


            # check if an attachment must be deleted
            ATTACHMENT:
            for my $Number ( 1 .. 32 ) {

                # check if the delete button was pressed for this attachment
                my $Delete = $ParamObject->GetParam( Param => "AttachmentDelete$Number" );

                # check next attachment if it was not pressed
                next ATTACHMENT if !$Delete;

                # remember that we need to show the page again
                $ValidationError{Attachment} = 1;

                # remove the attachment from the upload cache
                $UploadCacheObject->FormIDRemoveFile(
                        FormID => $Self->{FormID},
                        FileID => $Number,
                );
            }


            # check if there was an attachment upload
            if ( $GetParam{AttachmentUpload} ) {

                # remember that we need to show the page again
                $ValidationError{Attachment} = 1;

                # get the uploaded attachment
                my %UploadStuff = $ParamObject->GetUploadAll(
                        Param  => 'FileUpload',
                        Source => 'string',
                );

                # add attachment to the upload cache
                $UploadCacheObject->FormIDAddFile(
                        FormID => $Self->{FormID},
                        %UploadStuff,
                );
            }

            $GetParam{Instructions} = $ParamObject->GetParam( Param => 'Instructions' );
            $GetParam{TechOpsTitle} = $ParamObject->GetParam( Param => 'TechOpsTitle' );

            if ( !%ValidationError ){

                my $checkouttext = "Requested By: $GetParam{RequestedFor} <br><br> **Special Instructions** <br> $GetParam{Instructions}<br>";
                # get all products/services for customer
                return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
                    SQL => 'SELECT distinct pas_id '
                            . 'FROM user_product_cart '
                            . 'WHERE user_id = ? ',
                    Bind  => [ \$Self->{UserID} ],
                );

                my %DataPaS;
                my @PaSID;
                while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
                    push @PaSID, $Row[0];
                }
                for my $key (@PaSID ) {
                    my %Data = $PaSObject->PaSsGet( PaSID => $key );
                    my %Attachments = $PaSObject->PaSAttachmentList( PaSID => $key);
                    # get PaS data
                    my @checdata = keys %Data;
                    if($GetParam{TechOpsTitle}){
                        if($GetParam{TechOpsTitle} ne $Data{DynamicField_PasTitle}){
                            next;
                        }
                    }

                    my $PaS = $PaSObject->PaSGet(
                        PaSID => $key,
                        UserID   => $Self->{UserID},
                    );

                    my $SLAID = $SLAObject->SLALookup(
                        Name => $PaS->{SLAID},
                    );
                      

                    my $requesttype;
                    if ( $Data{DynamicField_PaSSubCategory} eq 'New Account Creation' ) {
                            $requesttype = "NewStarter";
                    } elsif ( $Data{DynamicField_PaSCategory} eq 'Telephony' )  {
                            $requesttype = "CommsOrder";
                    }
                                 
                    else {
                            $requesttype = "";
                    }


                    for my $key (keys %Attachments) {
                            $Data{Filename} = $key;
                    }

                    # get all products/services for customer
                    return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
                            SQL => 'SELECT order_details '
                                    . 'FROM user_product_cart '
                                    . 'WHERE pas_id = ? and user_id= ?',
                            Bind  => [ \$key, \$Self->{UserID} ],
                    );

                    my $text;
                    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
                            $text = $Row[0];
                    }

                    # patch 1.0.1
                    my $StaffExitData = $text;
                        
                    my $new_text=`/bin/python3.6 /opt/otrs/scripts/parseVendorStaffdata.py "$text"`;
                    my $body = $new_text .  $checkouttext;
                            # get Customer information
                    my %myID = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerUserDataGet(
                        User        => $Self->{UserLogin},
                    );

                    $body =~ s#.*<p>Product Questions: </p>##g;
                    $body =~ s#<p>subtotal :  </p   >$##g;


                    my $EmployeeName =$1 if( $text =~ /Employee Name.*?\:\s*(.*?)[&|<]+/i);


                    # concat manager shortname
                    my $hash;
                    my ($Category, $SubCat, $Rtype);
                    ($hash) = $myID{UserComment} =~ /CN=(.*?),/;


                    # generate ticket number with Incident type prefix
                    my $strNewTicketNumber  = $TicketObject->TicketCreateNumber();
                    $strNewTicketNumber = 'SR'. $strNewTicketNumber;

                    my $Title;
                    if($Data{DynamicField_PasTitle} =~ /^Vendor Staff offboarding$/ig){
                        my $EmployeeName =$1 if( $text =~ /Employee Name.*?\:\s*(.*?)[&|<]+/i);
                        $Title = "Employee Offboarding" . " Request For " .  $EmployeeName;
                        $Category  = 'User Provisioning';
                        $SubCat    = 'Vendor Staff Offboarding';
                    }        
                    else{
                        $Title = $Data{DynamicField_PasTitle} - $strNewTicketNumber;
                     }


                    # improvements/bug fix SR2019052170001285
                    my $AgentUserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup(
                        UserLogin => $Self->{UserLogin},
                    );
                    if ( ! $AgentUserID ) {
                        $AgentUserID = $ConfigObject->Get('CustomerPanelUserID');
                    }
                    my $TicketID;
                    my $NotTriggerDF;

                    # create new ticket, do db insert
                    if($Data{DynamicField_PasTitle} =~ /^Vendor Staff Onboarding$/){

                        
                    }
                    else{
                        $TicketID = $TicketObject->TicketCreate(
                            TN           => $strNewTicketNumber,
                            QueueID      => 5,
                            TypeID       => 3,
                            Title        => $Title,
                            PriorityID   => 3,
                            Lock         => 'unlock',
                            StateID      => 1,
                            SLAID        => $SLAID,
                            CustomerID   => $Self->{UserCustomerID},
                            CustomerUser => $Self->{UserLogin},
                            OwnerID      => $ConfigObject->Get('CustomerPanelUserID'),
                            UserID       => $AgentUserID,
                        );
                    }
                

                    # Set Name, EmpID, Email, Department, LWD of employee in Ticket DF
                    # append staff data into DF
                    if($Data{DynamicField_PasTitle} =~ /^Vendor Staff Onboarding$/){
                    # $Self->UpdateStaffOnBoardingDF(
                    #                 Data     => $StaffExitData,
                    #                 TicketID => $TicketID,
                    #                 Instruction => $checkouttext,                
                    #         );

                    }
                    else{

                            # $Self->UpdateStaffOffBoardingDF(
                            #         Data     => $StaffExitData,
                            #         TicketID => $TicketID,
                            #         Instruction => $checkouttext,
                            # );

                    } 

       
                    # set ticket dynamic fields
                    # cycle trough the activated Dynamic Fields for this screen
                    DYNAMICFIELD:
                    for my $DynamicFieldConfig ( @{$DynamicField} ) {
                        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
                        next DYNAMICFIELD if $DynamicFieldConfig->{ObjectType} ne 'Ticket';

                        if ( $DynamicFieldConfig->{Name} eq 'Manager' ) {
                                $DynamicFieldValues{$DynamicFieldConfig->{Name}} = $hash;
                        }

                        if ( $DynamicFieldConfig->{Name} eq 'Chargeable' ) {
                                #$DynamicFieldValues{$DynamicFieldConfig->{Name}} = 1;
                        }

                        # Staff off-boarding
                        if ( $DynamicFieldConfig->{Name} eq 'Category' ) {
                                $DynamicFieldValues{$DynamicFieldConfig->{Name}} = $Category;
                        }
                        if ( $DynamicFieldConfig->{Name} eq 'SubCategory' ) {

                                $DynamicFieldValues{$DynamicFieldConfig->{Name}} = $SubCat;
                        }

                        if ( $DynamicFieldConfig->{Name} eq 'CustomerRequestType' ) {
                                $DynamicFieldValues{$DynamicFieldConfig->{Name}} = $requesttype;
                        }
                      
                        if ( $DynamicFieldConfig->{Name} eq 'CallSource' ) {
                                $DynamicFieldValues{$DynamicFieldConfig->{Name}} = "Self Service";
                        }

                        if ( $DynamicFieldConfig->{Name} eq 'CheckoutPaSID' ) {
                                $DynamicFieldValues{$DynamicFieldConfig->{Name}} = $key;
                        }

                        # set the value
                        my $Success = $BackendObject->ValueSet(
                            DynamicFieldConfig => $DynamicFieldConfig,
                            ObjectID           => $TicketID,
                            Value              => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
                            UserID             => $ConfigObject->Get('CustomerPanelUserID'),
                        );

                        $Kernel::OM->Get('Kernel::System::Log')->Log(
                            Priority => 'error',
                            Message  => "Name - $DynamicFieldConfig->{Name} -- value - $DynamicFieldValues{ $DynamicFieldConfig->{Name} }",
                        );
                         
                         #Set Request Type to empty
                         my $RequestTypeCfg = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldGet(
                             Name => 'subCat2',
                          );
                         my $Success1 = $BackendObject->ValueSet(
                            DynamicFieldConfig => $RequestTypeCfg,
                            ObjectID           => $TicketID,
                            Value              => '',
                            UserID             => $ConfigObject->Get('CustomerPanelUserID'),
                        );
                    }

                    my $MimeType = 'text/plain';
                    if ( $LayoutObject->{BrowserRichText} ) {
                        $MimeType = 'text/html';

                        # verify html document
                        $GetParam{Body} = $LayoutObject->RichTextDocumentComplete(
                            String => $GetParam{Body},
                        );
                    }

                    # create article
                    my $FullName = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerName(
                        UserLogin => $Self->{UserLogin},
                    );

                    my $ArticleID;
                    my $From      = "\"$FullName\" <$Self->{UserEmail}>";

                    if($Data{DynamicField_PasTitle} =~ /^Vendor Signup$/){
                       my %ZoomPageData=();
                        while($StaffExitData =~ m/<p>(.*?):(.*?)<\/p>/msg ) {
                            my $Key = $1;
                            my $Val = $2;
                            $Key =~ s/(^\s+|\s+$)//g; 
                            $Key =~ s/\s/_/g; 
                            $Val =~ s/(^\s+|\s+$)//g;
                            $ZoomPageData{$Key} = $Val;
                        } 
                        open(my $Fh,'>','/tmp/CustomerCheckout_VendorAdd.pm.log');
                        use Data::Dumper;
                        print $Fh Dumper \%ZoomPageData;
                        close($Fh);
                        $ArticleID = $TicketObject->ArticleCreate(
                            TicketID         => $TicketID,
                            ArticleType      => $Config->{ArticleType},
                            SenderType       => $Config->{SenderType},
                            From             => $From,
                            To               => "System",
                            Subject          => "Vendor Signup Started",
                            Body             => "$body<p>Please Create vendor users for HR and Support Team Email.</p>",
                            MimeType         => $MimeType,
                            Queue            => 'Service Desk',
                            Charset          => $LayoutObject->{UserCharset},
                            UserID           => $ConfigObject->Get('CustomerPanelUserID'),
                            HistoryType      => $Config->{HistoryType},
                            HistoryComment   => $Config->{HistoryComment} || '%%',
                            AutoResponseType => ( $ConfigObject->Get('AutoResponseForWebTickets') )
                            ? 'auto reply'
                            : '',
                            OrigHeader => {
                                From    => $From,
                                To      => $Self->{UserLogin},
                                Subject => $GetParam{Subject},
                                Body    => "Plain",
                            },
                        );
                        #Customer Company Create
                        #Call Vendor Creation Object and register vendor in customer company
                        #Insert in DB All vendor details
                    }
                                         
                    else{
                        my $ArticleObject        = $Kernel::OM->Get('Kernel::System::Ticket::Article');
                        my $ArticleBackendObject = $ArticleObject->BackendForChannel( ChannelName => 'Phone' );

                        $ArticleID = $ArticleBackendObject->ArticleCreate(
                            TicketID         => $TicketID,
                            IsVisibleForCustomer => 1,
                            # ArticleType      => $Config->{ArticleType},
                            SenderType       => $Config->{SenderType},
                            From             => $From,
                            To               => "System",
                            Subject          => "Staff Offboarding Started",
                            Body             => $body,
                            MimeType         => $MimeType,
                            Charset          => $LayoutObject->{UserCharset},
                            UserID           => $ConfigObject->Get('CustomerPanelUserID'),
                            HistoryType      => $Config->{HistoryType},
                            HistoryComment   => $Config->{HistoryComment} || '%%',
                            AutoResponseType => ( $ConfigObject->Get('AutoResponseForWebTickets') )
                            ? 'auto reply'
                            : '',
                            OrigHeader => {
                                From    => $From,
                                To      => $Self->{UserLogin},
                                Subject => $GetParam{Subject},
                                Body    => "Plain",
                            },
                        );
                    }




                    if ( !$ArticleID ) {
                        my $Output = $LayoutObject->CustomerHeader( Title => 'Error' );
                        $Output .= $LayoutObject->CustomerError();
                        $Output .= $LayoutObject->CustomerFooter();
                        return $Output;
                    } 
                    else {
                        # if customer is not allowed to set priority, set it to default
                        if ( !$Config->{Priority} ) {
                            $GetParam{PriorityID} = '';
                            $GetParam{Priority}   = $Config->{PriorityDefault};
                        }

                        # get pre loaded attachment
                        my @AttachmentData = $UploadCacheObject->FormIDGetAllFilesData(
                            FormID => $Self->{FormID},
                        );

                        # get submitted attachment
                        my %UploadStuff = $ParamObject->GetUploadAll(
                                Param  => 'FileUpload',
                                                Source => 'string',
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
                            $TicketObject->ArticleWriteAttachment(
                                %{$Attachment},
                                ArticleID => $ArticleID,
                                UserID    => $ConfigObject->Get('CustomerPanelUserID'),
                            );
                        }
                        #
                        #        # remove pre submitted attachments
                        #        $UploadCacheObject->FormIDRemove( FormID => $Self->{FormID} );

                    }
                    #KPI Data TIcke Store code start
                    my %KPIFormData =();
                    while($StaffExitData =~ m/<p>(.*?):(.*?)<\/p>/msg ) {
                        my $KPIFormData_Key = $1;
                        my $KPIFormData_value = $2;
                        $KPIFormData_Key =~ s/(^\s+|\s+$)//g; 
                        $KPIFormData_value =~ s/(^\s+|\s+$)//g;
                        $KPIFormData{$KPIFormData_Key} = $KPIFormData_value;
                    } 
                    
                    # if ($key eq '310') {
                    #     my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
                    #     $DBObject->Do(
                    #         SQL=>"UPDATE it_pmo SET Ticket_id = ? where Created_by = ? and Month = ? and Year = ? and Pas_id = ? ",
                    #         Bind => [ \$TicketID,\$Self->{UserID},\$KPIFormData{'Month'},\$KPIFormData{'Year'},\$key],
                    #     );
                    # }elsif ($key eq '308') {
                    #     my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
                    #     $DBObject->Do(
                    #         SQL=>"UPDATE testing_automation SET Ticket_id = ? where Created_by = ? and Month = ? and Year = ? and Pas_id = ? ",
                    #         Bind => [ \$TicketID,\$Self->{UserID},\$KPIFormData{'Month'},\$KPIFormData{'Year'},\$key],
                    #     );
                    # }elsif ($key eq '307') {
                    #     my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
                    #     $DBObject->Do(
                    #         SQL=>"UPDATE portal_development SET Ticket_id = ? where Created_by = ? and Month = ? and Year = ? and Pas_id = ? ",
                    #         Bind => [ \$TicketID,\$Self->{UserID},\$KPIFormData{'Month'},\$KPIFormData{'Year'},\$key],
                    #     );
                    # }elsif ($key eq '316' || $key eq '317' || $key eq '318' || $key eq '319' || $key eq '320' || $key eq '321') {
                    #     my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
                    #     $DBObject->Do(
                    #         SQL=>"UPDATE kpi_itioe SET Ticket_id = ? where Create_by = ? and Month = ? and Year = ? and Pas_id = ? ",
                    #         Bind => [ \$TicketID,\$Self->{UserID},\$KPIFormData{'Month'},\$KPIFormData{'Year'},\$key],
                    #     );
                    # }elsif ($key eq '315') {
                    #     my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
                    #     $DBObject->Do(
                    #         SQL=>"UPDATE bssoss_billing SET Ticket_id = ? where Create_by = ? and Month = ? and Year = ? and Pas_id = ? ",
                    #         Bind => [ \$TicketID,\$Self->{UserID},\$KPIFormData{'Month'},\$KPIFormData{'Year'},\$key],
                    #     );
                    # }elsif ($key eq '330') {
                    #     my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
                    #     $DBObject->Do(
                    #         SQL=>"UPDATE bssoss_payment SET Ticket_id = ? where Create_by = ? and Day = ? and Posting_end_time = ? and Pas_id = ? ",
                    #         Bind => [ \$TicketID,\$Self->{UserID},\$KPIFormData{'Day'},\$KPIFormData{'Posting End Time'},\$key],
                    #     );
                    # }elsif ($key eq '331') {
                    #     my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
                    #     $DBObject->Do(
                    #         SQL=>"UPDATE bssoss_dunning SET Ticket_id = ? where Create_by = ? and Day = ? and Posting_end_time = ? and Pas_id = ? ",
                    #         Bind => [ \$TicketID,\$Self->{UserID},\$KPIFormData{'Day'},\$KPIFormData{'Posting End Time'},\$key],
                    #     );
                    # }elsif ($key eq '314') {
                    #     my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
                    #     $DBObject->Do(
                    #         SQL=>"UPDATE kpi_handling_sr SET Ticket_id = ? where Create_by = ? and Month = ? and Year = ? and Pas_id = ? ",
                    #         Bind => [ \$TicketID,\$Self->{UserID},\$KPIFormData{'Month'},\$KPIFormData{'Year'},\$key],
                    #     );
                    # }elsif ($key eq '306' || $key eq '311' || $key eq '312' || $key eq '313') {
                    #     my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
                    #     $DBObject->Do(
                    #         SQL=>"UPDATE bssoss_high_availability SET Ticket_id = ? where Create_by = ? and Month = ? and Year = ? and Pas_id = ? ",
                    #         Bind => [ \$TicketID,\$Self->{UserID},\$KPIFormData{'Month'},\$KPIFormData{'Year'},\$key],
                    #     );
                    # }
                #KPI Data TIcke Store code end
                }


                # delete PaS reference from DB
                return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
                    SQL  => 'DELETE FROM user_product_cart WHERE user_id = ?',
                    Bind => [ \$Self->{UserID} ],
                );


                # Update user_product_cart set empty value for user_id and set checkout_info with Ticket Number
  
                $LayoutObject->Block(
                    Name => 'CheckoutConfirm',
                    Data => \%Data,
                );

            }

        } ## END ELSE ##
        if ( $ValidationError{Attachment} ) {
            my      %ValidationError = ();
        }
        # get all products/services for customer
        return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
                SQL => 'SELECT distinct pas_id '
                        . 'FROM user_product_cart '
                        . 'WHERE user_id = ? ',
                Bind  => [ \$Self->{UserID} ],
        );

        my %DataPaS;
        my @PaSID;
        my $PasTitleData;
        while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
                push @PaSID, $Row[0];
        }

        for my $key (@PaSID ) {

            my %Data = $PaSObject->PaSsGet( PaSID => $key );
            $PasTitleData = $Data{DynamicField_PasTitle};
                   
            my %Attachments = $PaSObject->PaSAttachmentList( PaSID => $key);

            for my $key (keys %Attachments) {
                $Data{Filename} = $key;
            }
            # get all products/services for customer
            return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
                    SQL => 'SELECT quantity, subtotal '
                            . 'FROM user_product_cart '
                            . 'WHERE pas_id = ? and user_id= ?',
                    Bind  => [ \$key, \$Self->{UserID} ],
            );

            while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
                    $Data{quantity} = $Row[0];
                    $Data{subtotal} = $Row[1];
            }

            $LayoutObject->Block(
                    Name => 'ShoppingCart',
                    Data => \%Data,
            );

        }

        # get all products/services for customer
        return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
                SQL => 'SELECT sum(subtotal) as Total '
                        . 'FROM user_product_cart '
                        . 'WHERE user_id = ? ',
                Bind  => [ \$Self->{UserID} ],
        );

        while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
                $Data{Total} = $Row[0];
        }

        $LayoutObject->Block(
                Name => 'Total',
                Data => \%Data,
        );


        my $Output = $LayoutObject->CustomerHeader(
            Title   => $Self->{Subaction},
        );
        $Param{FormID} = $Self->{FormID};
        $Param{HeadingPaSTitle} = $Data{DynamicField_PasTitle} || $PasTitleData;
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Getting Data pankaj -> $Data{DynamicField_PasTitle} - $PasTitleData" ,
        );

        # show the attachment upload button
        $LayoutObject->Block(
            Name => 'AttachmentUpload',
            Data => {%Param},
        );
        my @Attachments = $UploadCacheObject->FormIDGetAllFilesMeta(
            FormID => $Self->{FormID},
        );

        # show attachments
        my %UniqAttachment = (); # OTRSN-523
        ATTACHMENT:
        for my $Attachment (@Attachments) {

            # check if previous upload file come again
            # OTRSN-523

            if ( exists $UniqAttachment{"$Attachment->{Filename}"} ) {
                next ATTACHMENT;
            }

            # set attachment in key # OTRSN-523
            $UniqAttachment{"$Attachment->{Filename}"} = 1;

            # do not show inline images as attachments
            # (they have a content id)
            if ( $Attachment->{ContentID} && $LayoutObject->{BrowserRichText} ) {
                    next ATTACHMENT;
            }

            $LayoutObject->Block(
                    Name => 'Attachment',
                    Data => $Attachment,
            );
        }

        #get engagement type
        return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
            SQL => 'SELECT order_details '
                    . 'FROM user_product_cart '
                    . 'WHERE pas_id = 302 and user_id= ?',
            Bind  => [ \$Self->{UserID} ],
        );
         my $employeedata;
        while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
            $employeedata = $Row[0];
        }

        my $Engagement_Type;
        while($employeedata =~ m/<p>(.*?):(.*?)<\/p>/msg ) {
        my $Col = '';
        my $Key = $1;
        my $Val = $2;
        $Val =~ s/(^\s+|\s+$)//g;

        # Fall back table tuples
        if ( $Key =~ m/Engagement Type/i ) {
            $Engagement_Type = $Val;
        }
        }
        open(my $Fh,'>','/tmp/customercheckout_param.pm.log');
        print $Fh $Engagement_Type;
        close($Fh);
        #end get engagement type
        if($Engagement_Type eq 'onshore contractor' and $PaSID == 302){
            $Param{Instructions} = "YTLC Email ID - Please update YES/NO\n"
                                    ."YTLC Laptop - Please update YES/NO\n"
                                    ."YTLC Access Card - Please update YES/NO\n";
                                    
        }
        elsif($Data{DynamicField_PasTitle} eq 'Door Access Request'){
            $Param{Instructions} = "Access Card request issuance for General Area: Main Door, Common Door for NW and SW Office as part of Employee Onboarding process";
        }
        elsif($Data{DynamicField_PasTitle} eq 'Shared Space Resource Form'){
            $Param{Instructions} = "Access Card request issuance for General Area: Main Door, Common Door for Shared Space Resource";
        }   
        else{
            $Param{Instructions} = $ParamObject->GetParam( Param => 'Instructions' );
        }

           
        $Param{HeadPaSTitle} = $Data{DynamicField_PasTitle} || $PasTitleData;
        # build NavigationBar
        $Output .= $LayoutObject->CustomerNavigationBar();
        $Output .= $LayoutObject->Output(
            TemplateFile => 'CustomerCheckout',
            Data         => \%Param,
            %ValidationError,
            FormID           => $Self->{FormID},
        );

        # get page footer
        $Output .= $LayoutObject->CustomerFooter();

        # return page
        return $Output;
}


1;

