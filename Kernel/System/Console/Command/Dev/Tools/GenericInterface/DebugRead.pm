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

package Kernel::System::Console::Command::Dev::Tools::GenericInterface::DebugRead;

use strict;
use warnings;
use utf8;

use parent qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::System::GenericInterface::DebugLog',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Read parts of the generic interface debug log based on your given options.');
    $Self->AddOption(
        Name        => 'communication-id',
        Description => "Restriction on the communication id.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/.*/smx,
    );
    $Self->AddOption(
        Name        => 'communication-type',
        Description => "Restriction on the communication type.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^(?:Provider|Requester)$/smx,
    );
    $Self->AddOption(
        Name        => 'created-at-or-after',
        Description => "Restriction on entries created after given timestamp.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d{4}-\d{2}-\d{2}[ ]\d{2}:\d{2}:\d{2}$/smx,
    );
    $Self->AddOption(
        Name        => 'created-at-or-before',
        Description => "Restriction on entries created before given timestamp.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d{4}-\d{2}-\d{2}[ ]\d{2}:\d{2}:\d{2}$/smx,
    );
    $Self->AddOption(
        Name        => 'remote-ip',
        Description => "Restriction on entries of a given ip address.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/.*/smx,
    );
    $Self->AddOption(
        Name        => 'webservice-id',
        Description => "Restriction on entries of a given web service id.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+$/smx,
    );
    $Self->AddOption(
        Name        => 'with-data',
        Description => "Restriction on entries of a given web service id.",
        Required    => 0,
        HasValue    => 0,
    );
    $Self->AddOption(
        Name        => 'limit',
        Description => "Specify result entries limit, default is 100.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+$/smx,
    );

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get options
    my $CommunicationID   = $Self->GetOption('communication-id');
    my $CommunicationType = $Self->GetOption('communication-type');
    my $CreatedAtOrAfter  = $Self->GetOption('created-at-or-after');
    my $CreatedAtOrBefore = $Self->GetOption('created-at-or-before');
    my $RemoteIP          = $Self->GetOption('remote-ip');
    my $WebserviceID      = $Self->GetOption('webservice-id');
    my $WithData          = $Self->GetOption('with-data');
    my $Limit             = $Self->GetOption('limit');

    # create needed objects
    my $DebugLogObject = $Kernel::OM->Get('Kernel::System::GenericInterface::DebugLog');

    # search for log entries
    $Self->Print("Searching for DebugLog entries...\n\n");
    my $LogData = $DebugLogObject->LogSearch(
        CommunicationID   => $CommunicationID,
        CommunicationType => $CommunicationType,
        CreatedAtOrAfter  => $CreatedAtOrAfter,
        CreatedAtOrBefore => $CreatedAtOrBefore,
        RemoteIP          => $RemoteIP,
        WebserviceID      => $WebserviceID,
        WithData          => $WithData,
        Limit             => $Limit,
    );

    if ( ref $LogData eq 'ARRAY' ) {

        my $Counter = 0;
        for my $Item ( @{$LogData} ) {
            for my $Key (qw( LogID CommunicationID CommunicationType WebserviceID RemoteIP Created )) {
                $Self->Print("$Key: $Item->{$Key}, ");
            }

            $Self->Print("\n");

            if ($WithData) {

                for my $DataItem ( @{ $Item->{Data} } ) {
                    $Self->Print("   - ");
                    for my $Key (qw( DebugLevel Summary Data Created)) {
                        $Self->Print("$Key: $DataItem->{$Key}, ");
                    }
                    $Self->Print("\n");
                }
            }
            $Self->Print("\n");
            $Counter++;
        }

        $Self->Print("\n Log entries found: $Counter \n");
    }
    else {
        $Self->Print("No DebugLog entries were found.\n");
    }

    return $Self->ExitCodeOk();
}

1;
