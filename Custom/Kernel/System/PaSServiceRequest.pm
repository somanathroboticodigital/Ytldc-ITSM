package Kernel::System::PaSServiceRequest;

use strict;
use warnings;
use JSON;

our @ObjectDependencies = (
    'Kernel::System::Log',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}


sub AddAccess_Card_Requests_Details{
    my ( $Self, %Param ) = @_;
    # check needed stuff
    for my $Argument (qw(TicketID )) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # add  to Risk to database
    return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => "INSERT INTO access_card_requests ( ticket_id, type_of_application, applicant, full_name_as_per_nric, nric_passport_no, designation, contact_number, email_address, company_name, vehicles_model, vehicles_colour, vehicles_registration_no, site, block, floor, data_hall, create_time, change_time) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, current_timestamp, current_timestamp)",
        Bind => [
            \$Param{TicketID}, \$Param{type_of_application}, \$Param{applicant}, \$Param{full_name_as_per_nric}, \$Param{nric_passport_no}, \$Param{designation}, \$Param{contact_number}, \$Param{email_address}, \$Param{company_name},  \$Param{vehicles_model}, \$Param{vehicles_colour}, \$Param{vehicles_registration_no},  \$Param{site},  \$Param{block},  \$Param{floor}, \$Param{data_hall}
        ],
    );
    return 1
}

sub Add_Move_In_Out_Equipment_Details{
    my ( $Self, %Param ) = @_;
    # check needed stuff
    for my $Argument (qw(TicketID )) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # add  to Risk to database
    return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => "INSERT INTO move_in_out_equipment ( ticket_id, site, type_of_application, company_name, requestor_name, nric_passport_no, contact_number, email_address, date_of_request, reason, please_specify, delivery_personnel_company_name, deliverer_name, delivery_personnel_nric_passport_no, delivery_personnel_contact_number, delivery_personnel_vehicles_no, delivery_date_time, storage_location, delivery_tools, delivery_others_details, protection_required, protection_required_specify_details, any_special_needs_during_delivery, create_time, change_time) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  current_timestamp, current_timestamp)",
        Bind => [
            \$Param{TicketID}, \$Param{site}, \$Param{type_of_application}, \$Param{company_name}, \$Param{requestor_name}, \$Param{nric_passport_no}, \$Param{contact_number}, \$Param{email_address}, \$Param{date_of_request},  \$Param{reason}, \$Param{please_specify}, \$Param{delivery_personnel_company_name},  \$Param{deliverer_name},  \$Param{delivery_personnel_nric_passport_no}, \$Param{delivery_personnel_contact_number}, \$Param{delivery_personnel_vehicles_no}, \$Param{delivery_date_time}, \$Param{storage_location}, \$Param{delivery_tools}, \$Param{delivery_others_details},  \$Param{protection_required}, \$Param{protection_required_specify_details}, \$Param{any_special_needs_during_delivery}
        ],
    );
    return 1
}


sub DeleteUserAccessToken{
    
    my ( $Self, %Param ) = @_;
    for my $Attribute (qw(UserID UserType)) {
        if ( !$Param{$Attribute} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Attribute!",
            );
            return;
        }
    }
  
    my $Success = return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => 'DELETE FROM user_access_token WHERE user_id = ? and user_type = ?',
        Bind  => [ \$Param{UserID},\$Param{UserType} ],
            
    );
 
    return $Success;
}

sub GetAccessToken{
    
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Attribute (qw(UserID UserType)) {
        if ( !$Param{$Attribute} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Attribute!",
            );
            return;
        }
    }   
    # get data from database
    return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => "SELECT access_token FROM user_access_token WHERE user_id = ? and user_type = ?",           
        Bind  => [ \$Param{UserID},\$Param{UserType} ],         
    );
    my $AccessToken;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $AccessToken = $Row[0];
    }   
        
    return $AccessToken;
    
}



sub GetAccessTokenDetails{
    
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Attribute (qw(UserID UserType)) {
        if ( !$Param{$Attribute} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Attribute!",
            );
            return;
        }
    }   
    # get data from database
    return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => "SELECT access_token,id_token  FROM user_access_token WHERE user_id = ? and user_type = ?",           
        Bind  => [ \$Param{UserID},\$Param{UserType} ],         
    );

    my %Result;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $Result{AccessToken} = $Row[0];
        $Result{IDToken} = $Row[1];
       
    }
    
    return %Result;
    
}

sub GetAccessCardData {
    my ( $Self, %Param ) = @_;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    return if !$DBObject->Prepare(
        SQL  => "SELECT type_of_application, applicant, full_name_as_per_nric, nric_passport_no, designation, contact_number, email_address, company_name, vehicles_model, vehicles_colour, vehicles_registration_no, site, block, floor, data_hall from access_card_requests where ticket_id = ?",
        Bind => [ \$Param{TicketID} ],
    );

    my %Data;
    while ( my @Data = $DBObject->FetchrowArray() ) {
        %Data = (
            "Type of Application"          => $Data[0],
            "Applicant"                    => $Data[1],
            "Full Name (as per NRIC)"      => $Data[2],
            "NRIC / Passport No"           => $Data[3],
            "Designation"                  => $Data[4],
            "Contact Number"               => $Data[5],
            "Email Address"                => $Data[6],
            "Company Name"                 => $Data[7],
            "Vehicles Model"               => $Data[8],
            "Vehicles Colour"              => $Data[9],
            "Vehicles Registration No"     => $Data[10],
            "Site"                         => $Data[11],
            "Block"                        => $Data[12],
            "Floor"                        => $Data[13],
            "Data Hall"                    => $Data[14],
        );
    }

    return %Data; 
}

sub UpdateAccess_Card_Requests_Details{
    my ( $Self, %Param ) = @_;
    # check needed stuff
    for my $Argument (qw(TicketID )) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    return if !$DBObject->Do(
        SQL => '
            UPDATE access_card_requests
            SET type_of_application = ?, applicant = ?, full_name_as_per_nric = ?, nric_passport_no = ?, designation = ?, contact_number = ?, email_address = ?, company_name = ?, vehicles_model = ?, vehicles_colour = ?, vehicles_registration_no = ?, site = ?, block = ?, floor = ?, data_hall = ?, create_time = current_timestamp, change_time = current_timestamp WHERE ticket_id = ?',
        Bind => [\$Param{type_of_application}, \$Param{applicant}, \$Param{full_name_as_per_nric}, \$Param{nric_passport_no}, \$Param{designation}, \$Param{contact_number}, \$Param{email_address}, \$Param{company_name},  \$Param{vehicles_model}, \$Param{vehicles_colour}, \$Param{vehicles_registration_no},  \$Param{site},  \$Param{block},  \$Param{floor}, \$Param{data_hall}, \$Param{TicketID}
        ],
    );

    return 1
}

sub GetMoveInOutEquipmentDetails {
    my ( $Self, %Param ) = @_;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    return if !$DBObject->Prepare(
        SQL  => "SELECT site, type_of_application, company_name, requestor_name, nric_passport_no, contact_number, email_address, date_of_request, reason, please_specify, delivery_personnel_company_name, deliverer_name, delivery_personnel_nric_passport_no, delivery_personnel_contact_number, delivery_personnel_vehicles_no, delivery_date_time, storage_location, delivery_tools, delivery_others_details, protection_required, protection_required_specify_details, any_special_needs_during_delivery, create_time, change_time from move_in_out_equipment where ticket_id = ?",
        Bind => [ \$Param{TicketID} ],
    );

    my %Data;
    while ( my @Data = $DBObject->FetchrowArray() ) {
        %Data = (
            "Site"                                     => $Data[0],
            "Type of Application"                      => $Data[1],
            "Company Name"                             => $Data[2],
            "Requestor Name"                           => $Data[3],
            "NRIC / Passport No"                      => $Data[4],
            "Contact Number"                           => $Data[5],
            "Email Address"                            => $Data[6],
            "Date of Request"                          => $Data[7],
            "Reason"                                   => $Data[8],
            "Please specify"                           => $Data[9],
            "Delivery Personnel Company Name"          => $Data[10],
            "Deliverer Name"                           => $Data[11],
            "Delivery Personnel NRIC / Passport No"    => $Data[12],
            "Delivery Personnel Contact Number"        => $Data[13],
            "Delivery Personnel Vehicles No"           => $Data[14],
            "Delivery Date Time"                       => $Data[15],
            "Storage Location"                         => $Data[16],
            "Delivery Tools"                           => $Data[17],
            "Delivery Others Details"                  => $Data[18],
            "Protection required"                      => $Data[19],
            "Protection required specify details"      => $Data[20],
            "Any special needs during delivery"        => $Data[21],
        );
    }

    return %Data; 
}

sub UpdateMoveInOutEquipmentDetails{
    my ( $Self, %Param ) = @_;
    # check needed stuff
    for my $Argument (qw(TicketID )) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Values in update >>> $Param{site},$Param{type_of_application},$Param{company_name},$Param{requestor_name},$Param{nric_passport_no},",
        );

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    return if !$DBObject->Do(
        SQL => '
            UPDATE move_in_out_equipment
            SET site = ?, type_of_application = ?, company_name = ?, requestor_name = ?, nric_passport_no = ?, contact_number = ?, email_address = ?, date_of_request = ?, reason = ?, please_specify = ?, delivery_personnel_company_name = ?, deliverer_name = ?,delivery_personnel_nric_passport_no = ?, delivery_personnel_contact_number = ?, delivery_personnel_vehicles_no = ?, delivery_date_time = ?, storage_location = ?, delivery_tools = ?, delivery_others_details = ?, protection_required = ?, protection_required_specify_details = ?, any_special_needs_during_delivery = ?, create_time = current_timestamp, change_time = current_timestamp WHERE ticket_id = ?',
        Bind => [\$Param{site}, \$Param{type_of_application}, \$Param{company_name}, \$Param{requestor_name}, \$Param{nric_passport_no}, \$Param{contact_number}, \$Param{email_address}, \$Param{date_of_request},  \$Param{reason}, \$Param{please_specify}, \$Param{delivery_personnel_company_name},  \$Param{deliverer_name},  \$Param{delivery_personnel_nric_passport_no}, \$Param{delivery_personnel_contact_number}, \$Param{delivery_personnel_vehicles_no}, \$Param{delivery_date_time}, \$Param{storage_location}, \$Param{delivery_tools}, \$Param{delivery_others_details},  \$Param{protection_required}, \$Param{protection_required_specify_details}, \$Param{any_special_needs_during_delivery}, \$Param{TicketID}
        ],
    );

    return 1
}

sub Add_equipment_Details{
    my ( $Self, %Param ) = @_;
    # check needed stuff
    for my $Argument (qw(TicketID )) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    $Kernel::OM->Get('Kernel::System::Log')->Log(
        Priority => 'error',
        Message  => "Values >>> $Param{TicketID}, >>> $Param{Desc},>>>$Param{Brand}, >>>> $Param{Quantity}, >> $Param{Weight}, >> $Param{ACDC}, >> $Param{ITLoad}",
    );

    # add  to Risk to database
    return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => "INSERT INTO eq_details_moveinout ( ticket_id, description, brand, quantity, weight, ac_dc, it_load) VALUES ( ?, ?, ?, ?, ?, ?, ?)",
        Bind => [
            \$Param{TicketID}, \$Param{Desc}, \$Param{Brand}, \$Param{Quantity}, \$Param{Weight}, \$Param{ACDC},\$Param{ITLoad}
        ],
    );
    return 1
}

sub Update_equipment_Details{
    my ( $Self, %Param ) = @_;
    # check needed stuff
    for my $Argument (qw(TicketID )) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    $Kernel::OM->Get('Kernel::System::Log')->Log(
        Priority => 'error',
        Message  => "Updated >>> ",
    );

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    return if !$DBObject->Do(
        SQL => '
            UPDATE eq_details_moveinout SET description = ?, brand = ?, quantity = ?, weight = ?, ac_dc = ?, it_load = ? WHERE ticket_id = ?',
        Bind => [\$Param{Desc}, \$Param{Brand}, \$Param{Quantity}, \$Param{Weight}, \$Param{ACDC}, \$Param{ITLoad}, \$Param{TicketID}
        ],
    );

    return 1
}

sub GetEquipmentdData {
    my ( $Self, %Param ) = @_;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    return if !$DBObject->Prepare(
        SQL  => "SELECT ticket_id, description, brand, quantity, weight, ac_dc, it_load from eq_details_moveinout where ticket_id = ?",
        Bind => [ \$Param{TicketID} ],
    );

    my %Data;
    while ( my @Data = $DBObject->FetchrowArray() ) {
        %Data = (
            "TicketID"             => $Data[0],
            "Description"          => $Data[1],
            "Brand"                => $Data[2],
            "Quantity"             => $Data[3],
            "Weight"               => $Data[4],
            "ACDC"                 => $Data[5],
            "ITLoad"               => $Data[6],
        );
    }

    return %Data; 
}




1;