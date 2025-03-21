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

package Kernel::GenericInterface::Debugger;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(IsString IsStringWithData IsHashRefWithData);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::GenericInterface::Debugger

=head1 DESCRIPTION

GenericInterface data debugger interface.

For every communication process, one Kernel::GenericInterface::Debugger object
should be constructed and fed with data at the various stages
of the process. It will collect the data and write it into the database,
based on the configured debug level.

=head1 PUBLIC INTERFACE

=head2 new()

create an object.

    use Kernel::GenericInterface::Debugger;

    my $DebuggerObject = Kernel::GenericInterface::Debugger->new(
        DebuggerConfig   => {
            DebugThreshold  => 'debug',
            TestMode        => 0,           # optional, in testing mode the data will not be written to the DB
            # ...
        },

        WebserviceID        => 12,
        CommunicationType   => Requester, # Requester or Provider

        RemoteIP        => 192.168.1.1, # optional
        CommunicationID => '02a381c622d5f93df868a42151db1983', # optional
    );

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    # check DebuggerConfig - we need a hash ref with at least one entry
    if ( !IsHashRefWithData( $Param{DebuggerConfig} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need DebuggerConfig!',
        );

        return;
    }

    # DebugThreshold
    $Param{DebugThreshold} = $Param{DebuggerConfig}->{DebugThreshold} || 'error';

    # check for mandatory values
    for my $Needed (qw(WebserviceID CommunicationType DebugThreshold)) {
        if ( !IsStringWithData( $Param{$Needed} ) ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!"
            );

            return;
        }
        $Self->{$Needed} = $Param{$Needed};
    }

    # check correct DebugThreshold
    if ( $Self->{DebugThreshold} !~ /^(debug|info|notice|error)/i ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'DebugThreshold is not allowed.',
        );

        return;
    }

    # check correct CommunicationType
    if ( lc $Self->{CommunicationType} !~ /^(provider|requester)/i ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'CommunicationType is not allowed.',
        );

        return;
    }

    # TestMode
    $Self->{TestMode} = $Param{DebuggerConfig}->{TestMode} || 0;

    # remote IP optional
    if ( defined $Param{RemoteIP} && !IsStringWithData( $Param{RemoteIP} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need RemoteIP address!'
        );

        return;
    }
    $Self->{RemoteIP} = $Param{RemoteIP};

    # use communication ID passed in constructor
    if ( $Param{CommunicationID} ) {
        $Self->{CommunicationID} = $Param{CommunicationID};
    }

    # create new communication ID
    else {

        # communication ID MD5 (system time + random #)
        my $CurrentTime = $Kernel::OM->Create('Kernel::System::DateTime')->ToEpoch();
        my $MD5String   = $Kernel::OM->Get('Kernel::System::Main')->MD5sum(
            String => $CurrentTime . int( rand(1000000) ),
        );
        $Self->{CommunicationID} = $MD5String;
    }

    return $Self;
}

=head2 DebugLog()

add one piece of data to the logging of this communication process.

    $DebuggerObject->DebugLog(
        DebugLevel => 'debug',
        Summary    => 'Short summary, one line',
        Data       => $Data, # optional, $Data can be a string or a scalar reference
    );

Available debug levels are: 'debug', 'info', 'notice' and 'error'.
Any messages with 'error' priority will also be written to Kernel::System::Log.

=cut

sub DebugLog {
    my ( $Self, %Param ) = @_;

    if ( !$Param{Summary} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need Summary!',
        );

        return;
    }

    # for tailoring the call stack
    my $Caller = $Param{Caller} || 0;

    # if DebugLevel is not set DebugLevel from constructor is used
    $Param{DebugLevel} = $Param{DebugLevel} || $Self->{DebugLevel};

    # check correct DebugLevel
    if ( $Param{DebugLevel} !~ /^(debug|info|notice|error)/i ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'DebugLevel is not allowed.',
        );

        return;
    }

    my %DebugLevels = (
        debug  => 1,
        info   => 2,
        notice => 3,
        error  => 4
    );

    # create log message
    my $DataString = '';
    if ( IsHashRefWithData( $Param{Data} ) ) {
        $DataString = $Kernel::OM->Get('Kernel::System::Main')->Dump( $Param{Data} );
    }
    elsif ( IsStringWithData( $Param{Data} ) ) {
        $DataString = $Param{Data};
    }
    else {
        $DataString = 'No data provided';
    }

    if ( !$Self->{TestMode} ) {

        if ( $DebugLevels{ $Param{DebugLevel} } >= $DebugLevels{ $Self->{DebugThreshold} } ) {

            # call AddLog function
            $Kernel::OM->Get('Kernel::System::GenericInterface::DebugLog')->LogAdd(
                CommunicationID   => $Self->{CommunicationID},
                CommunicationType => $Self->{CommunicationType},
                RemoteIP          => $Self->{RemoteIP},
                Summary           => $Param{Summary},
                WebserviceID      => $Self->{WebserviceID},
                DebugLevel        => $Param{DebugLevel},
                Data              => $DataString,
            );
        }
        return 1 if $Param{DebugLevel} ne 'error';
    }

    my $LogMessage = <<"EOF";
DebugLog $Param{DebugLevel}:
  Summary: $Param{Summary}
  Data   : $DataString.
EOF

    if ( $Param{DebugLevel} eq 'error' ) {

        # Do not include the sub Module: Kernel::GenericInterface::Debugger::DebugLog in the stack trace
        $LogMessage =~ s/\n//g;
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Caller   => $Caller + 1,
            Priority => 'error',
            Message  => $LogMessage,
        );

        return 1 if !$Self->{TestMode};

        $LogMessage .= "\n";
    }

    print STDERR $LogMessage;

    return 1;
}

=head2 Debug()

passes data to DebugLog with debug level 'debug'

    $DebuggerObject->Debug(
        Summary => 'Short summary, one line',
        Data    => $Data, # optional, $Data can be a string or a scalar reference
    );

=cut

sub Debug {
    my ( $Self, %Param ) = @_;

    return if !$Self->DebugLog(
        %Param,
        DebugLevel => 'debug',
    );

    return 1;
}

=head2 Info()

passes data to DebugLog with debug level 'info'

    $DebuggerObject->Info(
        Summary => 'Short summary, one line',
        Data    => $Data, # optional, $Data can be a string or a scalar reference
    );

=cut

sub Info {
    my ( $Self, %Param ) = @_;

    return if !$Self->DebugLog(
        %Param,
        DebugLevel => 'info',
    );

    return 1;
}

=head2 Notice()

passes data to DebugLog with debug level 'notice'

    $DebuggerObject->Notice(
        Summary => 'Short summary, one line',
        Data    => $Data, # optional, $Data can be a string or a scalar reference
    );

=cut

sub Notice {
    my ( $Self, %Param ) = @_;

    return if !$Self->DebugLog(
        %Param,
        DebugLevel => 'notice',
    );

    return 1;
}

=head2 Error()

passes data to DebugLog with debug level 'error'
then returns data structure to be used as return value in calling function

    $DebuggerObject->Error(
        Summary => 'Short summary, one line',
        Data    => $Data, # optional, $Data can be a string or a scalar reference
    );

=cut

sub Error {
    my ( $Self, %Param ) = @_;

    # Do not include the sub  Module: Kernel::GenericInterface::Debugger::Error in the stack trace
    return unless $Self->DebugLog(
        Caller => 1,
        %Param,
        DebugLevel => 'error',
    );

    return {
        Success      => 0,
        ErrorMessage => $Param{Summary},
    };
}

=begin Internal:

=cut

=head2 DESTROY()

destructor, this will write the log entries to the database.

=cut

sub DESTROY {
    my $Self = shift;

    #TODO: implement storing of the debug messages
    return;
}

=end Internal:

=cut

1;
