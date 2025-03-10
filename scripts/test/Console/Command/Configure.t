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

use strict;
use warnings;
use utf8;

# Set up the test driver $Self when we are running as a standalone script.
use Kernel::System::UnitTest::RegisterDriver;

use vars (qw($Self));

my @CommandFiles = $Kernel::OM->Get('Kernel::System::Main')->DirectoryRead(
    Directory => $Kernel::OM->Get('Kernel::Config')->Get('Home') . '/Kernel/System/Console/Command',
    Filter    => '*.pm',
    Recursive => 1,
);

my @Commands;

for my $CommandFile (@CommandFiles) {
    $CommandFile =~ s{^.*(Kernel/System.*)[.]pm$}{$1}xmsg;
    $CommandFile =~ s{/+}{::}xmsg;
    push @Commands, $CommandFile;
}

for my $Command (@Commands) {

    my $CommandObject = $Kernel::OM->Get($Command);

    $Self->True(
        $CommandObject,
        "$Command could be created",
    );

    $Self->Is(
        $CommandObject->{_ConfigureSuccessful},
        1,
        "$Command was correctly configured",
    );
}

$Self->DoneTesting();
