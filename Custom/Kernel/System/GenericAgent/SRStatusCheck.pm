package Kernel::System::GenericAgent::SRStatusCheck;

use strict;
use warnings;

use List::Util qw(first);
use Data::Dumper;
use REST::Client;

our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::System::Ticket',
    'Kernel::System::Time',
);

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};

    bless( $Self, $Type );
    $Self->{Debug} = $Param{Debug} || 0;

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    local $Kernel::OM = Kernel::System::ObjectManager->new();

    if(!$Param{TicketID}){
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need TicketID In SRStatusCheck Generic Agent"
        );
    return;
    }

    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
    my $DynamicFieldObject  = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $BackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $UserObject = $Kernel::OM->Get('Kernel::System::User');

    my %Ticket = $TicketObject->TicketGet(
        TicketID => $Param{TicketID},
        DynamicFields => 1,
    );

    if($Ticket{State} eq "Approved" and !$Ticket{DynamicField_Level1ApprovalStatus}){

        my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
            Name => 'Level1ApprovalStatus',
        );
       
        my $TimeObject = $Kernel::OM->Get('Kernel::System::Time');
        my $Success = $BackendObject->ValueSet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $Param{TicketID},
            Value              => $Ticket{State},
            UserID             => 1,
        );
    }

    if($Ticket{State} eq "Rejected" and !$Ticket{DynamicField_Level1ApprovalStatus}){
        my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
            Name => 'Level1ApprovalStatus',
        );
       
        my $TimeObject = $Kernel::OM->Get('Kernel::System::Time');
        my $Success = $BackendObject->ValueSet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $Param{TicketID},
            Value              => $Ticket{State},
            UserID             => 1,
        );
    }
    if($Ticket{State} eq "Waiting for Approval" and $Ticket{DynamicField_Level1ApprovalStatus} eq "Adjustment Required"){
        my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
            Name => 'Level1ApprovalStatus',
        );
       
        my $TimeObject = $Kernel::OM->Get('Kernel::System::Time');
        my $Success = $BackendObject->ValueSet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $Param{TicketID},
            Value              => "",
            UserID             => 1,
        );
    }
}
1;
