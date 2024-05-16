package Kernel::System::GenericAgent::SRApproval;

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
            Message  => "Need TicketID In SRApproval Generic Agent"
        );
    return;
    }

    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

    my %Ticket = $TicketObject->TicketGet(
        TicketID => $Param{TicketID},
        DynamicFields => 1,
    );

    if(!$Ticket{DynamicField_Level1ApprovalStatus}){
        $TicketObject->StateSet(
            TicketID    => $Param{TicketID},
            StateID     => 14,
            UserID      => 1,
        );

      
    }

}
1;
