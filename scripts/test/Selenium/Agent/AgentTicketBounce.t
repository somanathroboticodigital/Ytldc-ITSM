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

        my $Helper        = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $TicketObject  = $Kernel::OM->Get('Kernel::System::Ticket');
        my $ArticleObject = $Kernel::OM->Get('Kernel::System::Ticket::Article');

        # Disable check email addresses.
        $Helper->ConfigSettingChange(
            Key   => 'CheckEmailAddresses',
            Value => 0,
        );

        # Do not check RichText.
        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Frontend::RichText',
            Value => 0
        );

        # Do not check service and type.
        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Ticket::Service',
            Value => 0
        );
        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Ticket::Type',
            Value => 0
        );

        # Create test ticket.
        my $TicketID = $TicketObject->TicketCreate(
            Title        => 'Selenium ticket',
            Queue        => 'Raw',
            Lock         => 'unlock',
            Priority     => '3 normal',
            State        => 'new',
            CustomerID   => 'SeleniumCustomer',
            CustomerUser => 'customer@example.com',
            OwnerID      => 1,
            UserID       => 1,
        );
        $Self->True(
            $TicketID,
            "TicketCreate - ID $TicketID",
        );

        my $ArticleBackendObject = $ArticleObject->BackendForChannel( ChannelName => 'Email' );

        # Create test email article.
        my $ArticleID = $ArticleBackendObject->ArticleCreate(
            TicketID             => $TicketID,
            SenderType           => 'customer',
            IsVisibleForCustomer => 1,
            Subject              => 'some short description',
            Body                 => 'the message text',
            Charset              => 'ISO-8859-15',
            MimeType             => 'text/plain',
            HistoryType          => 'EmailCustomer',
            HistoryComment       => 'Some free text!',
            UserID               => 1,
        );
        $Self->True(
            $ArticleID,
            "ArticleCreate - ID $ArticleID",
        );

        my $Success = $ArticleBackendObject->ArticleWritePlain(
            ArticleID => $ArticleID,
            Email     => <<'EMAIL'
From: otobo@localhost
Content-Type: text/plain
Mime-Version: 1.0
Subject: Test
Message-Id: <07731835-A22B-4FF3-AB4D-F1CF5A139F65>
To: test@localhost

Test Email string
EMAIL
            ,
            UserID => 1,
        );
        $Self->True(
            $Success,
            "ArticleWritePlain for article ID $ArticleID - success",
        );

        # Create test user and login.
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'users' ],
        ) || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # Navigate to ticket zoom page of created test ticket.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketZoom;TicketID=$TicketID");

        # Click to bounce ticket.
        $Selenium->find_element("//a[contains(\@href, 'Action=AgentTicketBounce') ]")->click();

        # Switch to bounce window.
        $Selenium->WaitFor( WindowCount => 2 );
        my $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );
        $Selenium->WaitFor( JavaScript => 'return typeof($) === "function" && $("body").length' );

        # Check agent ticket bounce screen.
        for my $ID (
            qw(BounceTo BounceStateID To Subject RichText submitRichText)
            )
        {
            my $Element = $Selenium->find_element( "#$ID", 'css' );
            $Element->is_enabled();
            $Element->is_displayed();
        }

        # Check JS functionality.
        # Click on checkbox - unchecked state.
        $Selenium->execute_script("\$('#InformSender').prop('checked', true)");
        $Selenium->WaitFor(
            JavaScript => "return \$('#InformSender:checked').length"
        );
        $Selenium->find_element( "#InformSender", 'css' )->click();
        $Selenium->WaitFor(
            JavaScript => "return !\$('#InformSender:checked').length"
        );

        # Check up if labels does not have class Mandatory.
        for my $Label (qw(To Subject RichText)) {
            $Self->Is(
                $Selenium->execute_script("return \$('label[for=$Label]').hasClass('Mandatory')"),
                0,
                "Label '$Label' has not class 'Mandatory'",
            );
        }

        # Click on checkbox - checked state.
        $Selenium->find_element( "#InformSender", 'css' )->click();
        $Selenium->WaitFor(
            JavaScript => "return \$('#InformSender:checked').length"
        );

        # Check up if labels have class Mandatory.
        for my $Label (qw(To Subject RichText)) {
            $Self->Is(
                $Selenium->execute_script("return \$('label[for=$Label]').hasClass('Mandatory')"),
                1,
                "Label '$Label' has class 'Mandatory'",
            );
        }

        # Set on initial unchecked state of checkbox.
        $Selenium->find_element( "#InformSender", 'css' )->click();
        $Selenium->WaitFor(
            JavaScript => "return !\$('#InformSender:checked').length"
        );

        # Bounce ticket to another test email.
        $Selenium->find_element( "#BounceTo", 'css' )->send_keys("test\@localhost.com");
        $Selenium->InputFieldValueSet(
            Element => '#BounceStateID',
            Value   => 4,
        );
        $Selenium->find_element( "#submitRichText", 'css' )->click();

        $Selenium->WaitFor( WindowCount => 1 );
        $Selenium->switch_to_window( $Handles->[0] );

        # Navigate to AgentTicketHistory of test created ticket.
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentTicketHistory;TicketID=$TicketID");

        # Verify that bounce worked as expected.
        my $BounceText = 'Bounced to "test@localhost.com".';
        $Self->True(
            index( $Selenium->get_page_source(), $BounceText ) > -1,
            "Bounce executed correctly",
        );

        # Delete created test ticket.
        $Success = $TicketObject->TicketDelete(
            TicketID => $TicketID,
            UserID   => 1,
        );

        # Ticket deletion could fail if apache still writes to ticket history. Try again in this case.
        if ( !$Success ) {
            sleep 3;
            $Success = $TicketObject->TicketDelete(
                TicketID => $TicketID,
                UserID   => 1,
            );
        }
        $Self->True(
            $Success,
            "Ticket with ticket id $TicketID is deleted"
        );

        # Make sure the cache is correct.
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp( Type => 'Ticket' );
    }
);

$Self->DoneTesting();
