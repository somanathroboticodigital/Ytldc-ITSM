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

# get needed objects
my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

my $HomeDir            = $ConfigObject->Get('Home');
my @BackendModuleFiles = $Kernel::OM->Get('Kernel::System::Main')->DirectoryRead(
    Directory => $HomeDir . '/Kernel/System/Cache/',
    Filter    => '*.pm',
    Silent    => 1,
);

MODULEFILE:
for my $ModuleFile (@BackendModuleFiles) {

    next MODULEFILE if !$ModuleFile;

    # extract module name
    my ($Module) = $ModuleFile =~ m{ \/+ ([a-zA-Z0-9]+) \.pm $ }xms;

    next MODULEFILE if !$Module;

    $ConfigObject->Set(
        Key   => 'Cache::Module',
        Value => "Kernel::System::Cache::$Module",
    );

    # create a local cache object
    my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

    die "Could not setup $Module" if !$CacheObject;

    # flush the cache to have a clear test environment
    $CacheObject->CleanUp();

    my $SetCaches = sub {
        $Self->True(
            $CacheObject->Set(
                Type  => 'A',
                Key   => 'A',
                Value => 'A',
                TTL   => 60 * 60 * 24 * 20,
            ),
            "Set A/A",
        );

        $Self->True(
            $CacheObject->Set(
                Type  => 'B',
                Key   => 'B',
                Value => 'B',
                TTL   => 60 * 60 * 24 * 20,
            ),
            "Set B/B",
        );
    };

    $SetCaches->();

    $Self->True(
        $CacheObject->CleanUp( Type => 'C' ),
        "Inexistent cache type removed",
    );

    $Self->Is(
        $CacheObject->Get(
            Type => 'A',
            Key  => 'A'
        ),
        'A',
        "Cache A/A is present",
    );

    $Self->Is(
        $CacheObject->Get(
            Type => 'B',
            Key  => 'B'
        ),
        'B',
        "Cache B/B is present",
    );

    $SetCaches->();

    $Self->True(
        $CacheObject->CleanUp( Type => 'A' ),
        "Cache type A removed",
    );

    $Self->False(
        $CacheObject->Get(
            Type => 'A',
            Key  => 'A'
        ),
        "Cache A/A is not present",
    );

    $Self->Is(
        $CacheObject->Get(
            Type => 'B',
            Key  => 'B'
        ),
        'B',
        "Cache B/B is present",
    );

    $SetCaches->();

    $Self->True(
        $CacheObject->CleanUp( KeepTypes => ['A'] ),
        "All cache types removed except A",
    );

    $Self->Is(
        $CacheObject->Get(
            Type => 'A',
            Key  => 'A'
        ),
        'A',
        "Cache A/A is present",
    );

    $Self->False(
        $CacheObject->Get(
            Type => 'B',
            Key  => 'B'
        ),
        "Cache B/B is not present",
    );

    $SetCaches->();

    $Self->True(
        $CacheObject->CleanUp(),
        "All cache types removed",
    );

    $Self->False(
        $CacheObject->Get(
            Type => 'A',
            Key  => 'A'
        ),
        "Cache A/A is not present",
    );

    $Self->False(
        $CacheObject->Get(
            Type => 'B',
            Key  => 'B'
        ),
        "Cache B/B is not present",
    );

    # flush the cache
    $CacheObject->CleanUp();
}

$Self->DoneTesting();
