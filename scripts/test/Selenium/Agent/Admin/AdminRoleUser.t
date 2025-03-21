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

# OTOBO modules
use Kernel::System::UnitTest::Selenium;
my $Selenium = Kernel::System::UnitTest::Selenium->new( LogExecuteCommandActive => 1 );

$Selenium->RunTest(
    sub {

        my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

        # Create test user.
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => ['admin'],
        ) || die "Did not get test user";

        # Get test user ID.
        my $UserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup(
            UserLogin => $TestUserLogin,
        );

        # Add test role.
        my $RoleName = "role" . $Helper->GetRandomID();

        my $RoleID = $Kernel::OM->Get('Kernel::System::Group')->RoleAdd(
            Name    => $RoleName,
            ValidID => 1,
            UserID  => $UserID,
        );
        $Self->True(
            $RoleID,
            "Created Role - $RoleName",
        );

        # Login as test user.
        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # Navigate to AdminRoleUser screen.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AdminRoleUser");

        # Check overview AdminRoleUser.
        $Selenium->find_element( "#Users",       'css' );
        $Selenium->find_element( "#Roles",       'css' );
        $Selenium->find_element( "#FilterUsers", 'css' );
        $Selenium->find_element( "#FilterRoles", 'css' );

        my $FullUserID = "$TestUserLogin ($TestUserLogin $TestUserLogin)";
        $Self->True(
            index( $Selenium->get_page_source(), $FullUserID ) > -1,
            "$TestUserLogin user found on page",
        );
        $Self->True(
            index( $Selenium->get_page_source(), $RoleName ) > -1,
            "$RoleName role found on page",
        );

        # Check breadcrumb on Overview screen.
        $Self->True(
            $Selenium->find_element( '.BreadCrumb', 'css' ),
            "Breadcrumb is found on Overview screen.",
        );

        # Change test role relation for test user.
        $Selenium->find_element( $FullUserID, 'link_text' )->VerifiedClick();

        $Selenium->find_element("//input[\@value='$RoleID']")->click();
        $Selenium->WaitFor(
            JavaScript => "return \$('input[value=$RoleID]:checked:visible').length"
        );

        $Selenium->find_element("//button[\@value='Save'][\@type='submit']")->VerifiedClick();

        # Check and edit test user relation for test role.
        $Selenium->find_element( $RoleName, 'link_text' )->VerifiedClick();

        # Check breadcrumb on change screen.
        my $Count = 1;
        for my $BreadcrumbText (
            'Manage Role-Agent Relations',
            'Change Agent Relations for Role \'' . $RoleName . '\''
            )
        {
            $Self->Is(
                $Selenium->execute_script("return \$('.BreadCrumb li:eq($Count)').text().trim()"),
                $BreadcrumbText,
                "Breadcrumb text '$BreadcrumbText' is found on screen"
            );

            $Count++;
        }

        $Self->Is(
            $Selenium->find_element("//input[\@value='$UserID']")->is_selected(),
            1,
            "Role $RoleName relation for user $TestUserLogin is enabled",
        );

        # Test checked and unchecked values while filter by role is used.
        # Test filter with "WrongFilterRole" to uncheck a value.
        $Selenium->find_element( "#Filter", 'css' )->clear();
        $Selenium->find_element( "#Filter", 'css' )->send_keys("WrongFilterRole");
        $Selenium->WaitFor(
            JavaScript => "return \$('.FilterMessage.Hidden > td:visible').length"
        );

        # Test if no data is matches.
        $Self->True(
            $Selenium->find_element( ".FilterMessage.Hidden>td", 'css' )->is_displayed(),
            "'No data matches' is displayed'"
        );

        $Selenium->find_element( "#Filter", 'css' )->clear();
        $Selenium->find_element( "#Filter", 'css' )->send_keys($TestUserLogin);
        $Selenium->WaitFor(
            JavaScript => "return \$('input[value=$UserID]:checked:visible').length"
        );

        # Check role relation for agent after using filter by agent.
        $Self->Is(
            $Selenium->find_element("//input[\@value='$UserID']")->is_selected(),
            1,
            "Role $RoleName relation for user $TestUserLogin is enabled",
        );

        # Remove test relation.
        $Selenium->find_element("//input[\@value='$UserID']")->click();
        $Selenium->WaitFor(
            JavaScript => "return !\$('input[value=$RoleID]:checked:visible').length"
        );

        $Selenium->find_element("//button[\@value='Save'][\@type='submit']")->VerifiedClick();

        # Check if relation is clear.
        $Selenium->find_element( $RoleName, 'link_text' )->VerifiedClick();

        $Self->Is(
            $Selenium->find_element("//input[\@value='$RoleID']")->is_selected(),
            0,
            "User $TestUserLogin is not in relation with role $RoleName",
        );

        # Test checked and unchecked values while filter by user is used.
        # Test filter with "WrongFilterRole" to uncheck a value.
        $Selenium->find_element( "#Filter", 'css' )->clear();
        $Selenium->find_element( "#Filter", 'css' )->send_keys("WrongFilterRole");
        $Selenium->WaitFor(
            JavaScript => "return \$('.FilterMessage.Hidden > td:visible').length"
        );

        # Test if no data is matches.
        $Self->True(
            $Selenium->find_element( ".FilterMessage.Hidden>td", 'css' )->is_displayed(),
            "'No data matches' is displayed'"
        );

        $Selenium->find_element( "#Filter", 'css' )->clear();
        $Selenium->find_element( "#Filter", 'css' )->send_keys($RoleName);
        $Selenium->WaitFor(
            JavaScript => "return !\$('input[value=$RoleID]:checked:visible').length"
        );

        # Check role relation for agent after using filter by role.
        $Self->Is(
            $Selenium->find_element("//input[\@value='$RoleID']")->is_selected(),
            0,
            "User $TestUserLogin is not in relation with role $RoleName",
        );

        # Since there are no tickets that rely on our test role we can remove it from DB.
        if ($RoleID) {
            my $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
                SQL => "DELETE FROM roles WHERE id = $RoleID",
            );
            $Self->True(
                $Success,
                "RoleDelete - $RoleName",
            );
        }

        # Make sure the cache is correct.
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
            Type => 'Group'
        );
    }
);

$Self->DoneTesting();
