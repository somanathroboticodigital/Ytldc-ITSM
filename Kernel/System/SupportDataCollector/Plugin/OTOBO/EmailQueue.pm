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

package Kernel::System::SupportDataCollector::Plugin::OTOBO::EmailQueue;

use strict;
use warnings;

use parent qw(Kernel::System::SupportDataCollector::PluginBase);

use Kernel::Language qw(Translatable);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::MailQueue',
);

sub GetDisplayPath {
    return Translatable('OTOBO') . '/' . Translatable('Email Sending Queue');
}

sub Run {
    my $Self = shift;

    my $MailQueue = $Kernel::OM->Get('Kernel::System::MailQueue')->List();

    my $MailAmount = scalar @{$MailQueue};

    $Self->AddResultInformation(
        Label => Translatable('Emails queued for sending'),
        Value => $MailAmount,
    );

    return $Self->GetResults();
}

1;
