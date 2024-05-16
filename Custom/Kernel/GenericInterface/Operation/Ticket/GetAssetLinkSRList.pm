# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2023 Rother OSS GmbH, https://frothdesk.de/
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

package Kernel::GenericInterface::Operation::Ticket::GetAssetLinkSRList;

use strict;
use warnings;

use MIME::Base64;

use Kernel::System::VariableCheck qw(IsArrayRefWithData IsHashRefWithData IsStringWithData);

use parent qw(
    Kernel::GenericInterface::Operation::Common
    Kernel::GenericInterface::Operation::Ticket::Common
);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::GenericInterface::Operation::Ticket::GetAssetLinkSRList - Asset Link SR List

=head1 PUBLIC INTERFACE

=head2 new()

usually, you want to create an instance of this
by using Kernel::GenericInterface::Operation->new();

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for my $Needed (qw(DebuggerObject WebserviceID)) {
        if ( !$Param{$Needed} ) {
            return {
                Success      => 0,
                ErrorMessage => "Got no $Needed!",
            };
        }

        $Self->{$Needed} = $Param{$Needed};
    }

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $Result = $Self->Init(
        WebserviceID => $Self->{WebserviceID},
    );

    if ( !$Result->{Success} ) {
        return $Self->ReturnError(
            ErrorCode    => 'Webservice.InvalidConfiguration',
            ErrorMessage => $Result->{ErrorMessage},
        );
    }

    my ( $UserID, $UserType ) = $Self->Auth(
        %Param,
    );

    return $Self->ReturnError(
        ErrorCode    => 'ValidateToken.AuthFail',
        ErrorMessage => "ValidateToken: Authorization failing!",
    ) if !$UserID;


    for my $Needed (qw(UUID)) {
        if ( !$Param{Data}->{$Needed} ) {
            return $Self->ReturnError(
                ErrorCode    => 'SRList.MissingParameter',
                ErrorMessage => "SRList: $Needed parameter is missing!",
            );
        }
    }
    my $AssetObject = $Kernel::OM->Get('Kernel::System::AssetLink');
    my @Ticket = $AssetObject->GetAssetTicketIDs( AssetID => $Param{Data}->{UUID} );

    my @ticketData;
    if(@Ticket){
        foreach my $TicketID (@Ticket) {

        my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
        my %TicketDetails = $TicketObject->TicketGet(
            TicketID      => $TicketID,
            UserID        => $UserID,
        );

            if($TicketDetails{TypeID } eq 2 or $TicketDetails{TypeID } eq 3){
                
                push @ticketData, {
                    Title             => $TicketDetails{Title},
                    ServiceRequestID  => $TicketDetails{TicketNumber},
                    Status            => $TicketDetails{State},
                    Priority          => $TicketDetails{Priority},
                    DateRequested     => $TicketDetails{Created},
                    AssignedTo        => $TicketDetails{Owner},
                    Requester         => $TicketDetails{CustomerUserID },
                    UUID              => $Param{Data}->{UUID},
                };
                
            }
        }     
    }
    
    my $ReturnData;
    if (@ticketData) {
        $ReturnData = {
            Success => 1,
            Data  => {TicketDetails => \@ticketData},
        };
    }else
    {   
        $ReturnData = {
            Success => 1,
            Data  => {TicketDetails => "Asset Not Link with Ticket"},
        };
    }
    
    # return result
    return $ReturnData;
   
}


1;
