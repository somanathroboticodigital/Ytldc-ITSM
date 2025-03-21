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

package Kernel::Config;

=head1 NAME

Kernel::Config - settings that can be adapted by the user

=head1 SYNOPSIS

    use Kernel::System::ObjectManager;

    local $Kernel::OM = Kernel::System::ObjectManager->new();

    my $Config = $Kernel::OM->Get('Kernel::Config');
    my $Home   = $Config->Get('Home');

=head1 DESCRIPTION

Most OTOBO configuration should be done via the OTOBO web interface
and the SysConfig. Only for some configuration, such as database
credentials and customer data source changes, you should edit this
file. For changes do customer data sources you can copy the definitions
from F<Kernel/Config/Defaults.pm> and paste them into this file.
The file F<Kernel/Config.pm> will not be overwritten when updating OTOBO.

=cut

use v5.24;
use strict;
use warnings;
use utf8;

sub Load {
    my $Self = shift;

    # ---------------------------------------------------- #
    # database settings                                    #
    # ---------------------------------------------------- #

    # The database host
    $Self->{'DatabaseHost'} = '43.205.167.157';

    # The database name
    $Self->{'Database'} = "otobo";

    # The database user
    $Self->{'DatabaseUser'} = "otobo";

    # The password of database user. You also can use bin/otobo.Console.pl Maint::Database::PasswordCrypt
    # for crypted passwords
    $Self->{'DatabasePw'} = 'S20WS3C8k84cvHaJ';

    # The database DSN for MySQL ==> more: "perldoc DBD::mysql"
    $Self->{'DatabaseDSN'} = "DBI:mysql:database=$Self->{Database};host=$Self->{DatabaseHost}";

    # The database DSN for PostgreSQL ==> more: "perldoc DBD::Pg"
    # if you want to use a local socket connection
#    $Self->{DatabaseDSN} = "DBI:Pg:dbname=$Self->{Database};";
    # if you want to use a TCP/IP connection
#    $Self->{DatabaseDSN} = "DBI:Pg:dbname=$Self->{Database};host=$Self->{DatabaseHost};";

    # The database DSN for Oracle ==> more: "perldoc DBD::oracle"
#    $Self->{DatabaseDSN} = "DBI:Oracle://$Self->{DatabaseHost}:1521/$Self->{Database}";
#
#    $ENV{ORACLE_HOME}     = '/path/to/your/oracle';
#    $ENV{NLS_DATE_FORMAT} = 'YYYY-MM-DD HH24:MI:SS';
#    $ENV{NLS_LANG}        = 'AMERICAN_AMERICA.AL32UTF8';

    # ---------------------------------------------------- #
    # fs root directory, without trailing slash            #
    # ---------------------------------------------------- #
    $Self->{Home} = '/opt/otobo';

    # ---------------------------------------------------- #
    # insert your own config settings "here"               #
    # config settings taken from Kernel/Config/Defaults.pm #
    # ---------------------------------------------------- #

    # $Self->{SessionUseCookie} = 0;
    # $Self->{CheckMXRecord} = 0;

    # ---------------------------------------------------- #
    #                                                      #
    # end of your own config options!!!                    #
    #                                                      #
    # ---------------------------------------------------- #

    return 1;
}

# ---------------------------------------------------- #
# needed system stuff (don't edit this)                #
# ---------------------------------------------------- #

use Kernel::Config::Defaults; # import Translatable()
use parent qw(Kernel::Config::Defaults);

# -----------------------------------------------------#

1;
