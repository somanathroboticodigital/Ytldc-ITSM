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

my $CommandObject = $Kernel::OM->Get('Kernel::System::Console::Command::Admin::Role::UserLink');

# get helper object
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

my $RandomName = $Helper->GetRandomID();
my $UserRand   = 'user' . $RandomName;
my $RoleRand   = 'role' . $RandomName;

# try to execute command without any options
my $ExitCode = $CommandObject->Execute();
$Self->Is(
    $ExitCode,
    1,
    "No options",
);

# provide minimum options (invalid user)
$ExitCode = $CommandObject->Execute( '--user-name', $UserRand, '--role-name', $RoleRand );
$Self->Is(
    $ExitCode,
    1,
    "Minimum options (but user doesn't exist)",
);

# disable email checks to create new user
$Kernel::OM->Get('Kernel::Config')->Set(
    Key   => 'CheckEmailAddresses',
    Value => 0,
);

# add users
my $UserID = $Kernel::OM->Get('Kernel::System::User')->UserAdd(
    UserFirstname => 'Firstname Test1',
    UserLastname  => 'Lastname Test1',
    UserLogin     => $UserRand,
    UserEmail     => $UserRand . '@example.com',
    ValidID       => 1,
    ChangeUserID  => 1,
);

$Self->True(
    $UserID,
    "Test user is created - $UserRand",
);

# add role
my $RoleID = $Kernel::OM->Get('Kernel::System::Group')->RoleAdd(
    Name    => $RoleRand,
    ValidID => 1,
    UserID  => 1,
);

$Self->True(
    $RoleID,
    "Test role is created - $RoleRand",
);

# provide minimum options (invalid role)
$ExitCode = $CommandObject->Execute( '--user-name', $UserRand, '--role-name', $RandomName );
$Self->Is(
    $ExitCode,
    1,
    "Minimum options (but role doesn't exist)",
);

# provide minimum options (OK)
$ExitCode = $CommandObject->Execute( '--user-name', $UserRand, '--role-name', $RoleRand );
$Self->Is(
    $ExitCode,
    0,
    "Minimum options (parameters OK: linked user $UserRand to role $RoleRand)",
);

# cleanup is done by RestoreDatabase

$Self->DoneTesting();
