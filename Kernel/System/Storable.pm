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

package Kernel::System::Storable;

use strict;
use warnings;

use Storable qw();

our @ObjectDependencies = (
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::Storable - Storable wrapper functions

=head1 DESCRIPTION

Functions for Storable serialization / deserialization.


=head2 new()

create a Storable object. Do not use it directly, instead use:

    my $StorableObject = $Kernel::OM->Get('Kernel::System::Storable');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 Serialize()

Dump a Perl data structure to an storable string.

    my $StoableString = $StorableObject->Serialize(
        Data => $Data,          # must be a reference,
        Sort => 1,              # optional 1 or 0, default 0
    );

=cut

sub Serialize {
    my ( $Self, %Param ) = @_;

    # check for needed data
    if ( !defined $Param{Data} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need Data!',
        );
        return;
    }

    if ( !ref $Param{Data} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Data needs to be given as a reference!',
        );
        return;
    }

    local $Storable::canonical = $Param{Sort} ? 1 : 0;

    my $Result;
    eval {
        $Result = Storable::nfreeze( $Param{Data} );
    };

    # error handling
    if ($@) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Error serializing data: $@",
        );
        return;
    }

    return $Result;
}

=head2 Deserialize()

Load a serialized storable string to a Perl data structure.

    my $PerlStructureScalar = $StorableObject->Deserialize(
        Data => $StorableString,
    );

=cut

sub Deserialize {
    my ( $Self, %Param ) = @_;

    # check for needed data
    return if !defined $Param{Data};

    # read data structure back from file dump, use block eval for safety reasons
    my $Result;
    eval {
        $Result = Storable::thaw( $Param{Data} );
    };

    # error handling
    if ($@) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Error deserializing data: $@",
        );
        return;
    }

    return $Result;
}

=head2 Clone()

Creates a deep copy a Perl data structure.

    my $StorableData = $StorableObject->Clone(
        Data => $Data,          # must be a reference
    );

=cut

sub Clone {
    my ( $Self, %Param ) = @_;

    # check for needed data
    if ( !defined $Param{Data} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need Data!',
        );
        return;
    }

    if ( !ref $Param{Data} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Data needs to be a reference!',
        );
        return;
    }

    my $Result;
    eval {
        $Result = Storable::dclone( $Param{Data} );
    };

    # error handling
    if ($@) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Error cloning data: $@",
        );
        return;
    }

    return $Result;
}

1;
