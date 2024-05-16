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

package Kernel::Modules::AMS;


use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);
use Kernel::Language qw(Translatable);

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

    my $Output;

    # get needed objects
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $SuperAdmin = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'SuperAdmin' );
    # show default search screen
    $Output = $LayoutObject->Header();
    $Output .= $LayoutObject->NavigationBar();

    # Notify if there are tickets which are not updated.
    
   
    $Param{URL} = 'http://3.7.178.110/tenants/ytldc';
    $LayoutObject->Redirect(
        ExtURL => "$Param{URL}",
    );
    
    $Output .= $LayoutObject->Output(
        TemplateFile => 'AgentTicketExploreTickets',
        Data         => \%Param,
    );
    $Output .= $LayoutObject->Footer();
    return $Output;
}

1;
