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

package Kernel::System::Console::Command::Maint::Registration::UpdateSend;

use strict;
use warnings;

use parent qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::System::DateTime',
    'Kernel::Config',
    'Kernel::System::Registration',
    'Kernel::System::SystemData',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Send an OTOBO system registration update to OTOBO Team.');

    $Self->AddOption(
        Name        => 'force',
        Description => "Force to execute even if next update time has not been reached yet.",
        Required    => 0,
        HasValue    => 0,
        ValueRegex  => qr/.*/smx,
    );

    $Self->AddOption(
        Name        => 'debug',
        Description => "Output debug information while running.",
        Required    => 0,
        HasValue    => 0,
        ValueRegex  => qr/.*/smx,
    );

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Sending system registration update...</yellow>\n");

    # check if cloud services are disabled
    my $CloudServicesDisabled = $Kernel::OM->Get('Kernel::Config')->Get('CloudServices::Disabled') || 0;

    if ($CloudServicesDisabled) {
        $Self->Print("<green>Done.</green>\n");
        return $Self->ExitCodeOk();
    }

    my $RegistrationObject = $Kernel::OM->Get('Kernel::System::Registration');

    my %RegistrationData = $RegistrationObject->RegistrationDataGet();

    if ( !$RegistrationData{State} || $RegistrationData{State} ne 'registered' ) {
        $Self->Print("System is not registered, skipping...\n");
        $Self->Print("<green>Done.</green>\n");
        return $Self->ExitCodeOk();
    }

    my $NextUpdateSystemTime;

    # if there is a defined NextUpdeTime convert it system time
    if ( $RegistrationData{NextUpdateTime} ) {
        $NextUpdateSystemTime = $Kernel::OM->Create(
            'Kernel::System::DateTime',
            ObjectParams => {
                String => $RegistrationData{NextUpdateTime},
            },
        );
    }

    my $SystemTime = $Kernel::OM->Create('Kernel::System::DateTime');

    my $Force = $Self->GetOption('force') || 0;

    # do not update registration info before the next update (unless is forced)
    if ( !$Force && $NextUpdateSystemTime && $SystemTime < $NextUpdateSystemTime ) {
        $Self->Print("No need to send the registration update at this moment, skipping...\n");
        $Self->Print("<green>Done.</green>\n");
        return $Self->ExitCodeOk();
    }

    # send the registration update
    my %Result = $Kernel::OM->Get('Kernel::System::Registration')->RegistrationUpdateSend(
        Debug => $Self->GetOption('debug') || 0,
    );

    # if everything is OK return successfully
    if ( $Result{Success} ) {
        $Self->Print("<green>Done.</green>\n");
        return $Self->ExitCodeOk();
    }

    # if there was a error get the registration information once again
    my %UpdatedRegistrationData = $RegistrationObject->RegistrationDataGet();

    my $NextUpdateTime = $UpdatedRegistrationData{NextUpdateTime} // '';
    $RegistrationData{NextUpdateTime} //= '';

    # if the next update time was not set or is the same as the original, there should be a
    # communications issue with the portal, retry in two hours
    if ( !$NextUpdateTime || $RegistrationData{NextUpdateTime} eq $NextUpdateTime ) {

        # calculate next update time set it in two hours
        $NextUpdateTime = $SystemTime->Clone();
        $NextUpdateTime->Add( Seconds => 60 * 60 * 2 );
        $NextUpdateTime = $NextUpdateTime->ToString();

        # update or set the NextUpdateTime value
        if ( defined $UpdatedRegistrationData{NextUpdateTime} ) {

            $Kernel::OM->Get('Kernel::System::SystemData')->SystemDataUpdate(
                Key    => 'Registration::NextUpdateTime',
                Value  => $NextUpdateTime,
                UserID => 1,
            );
        }
        else {

            $Kernel::OM->Get('Kernel::System::SystemData')->SystemDataAdd(
                Key    => 'Registration::NextUpdateTime',
                Value  => $NextUpdateTime,
                UserID => 1,
            );
        }
    }

    $Self->PrintError("System registration update was not sent successfully.");
    $Self->PrintError("$Result{Reason}");
    return $Self->ExitCodeError();
}

1;
