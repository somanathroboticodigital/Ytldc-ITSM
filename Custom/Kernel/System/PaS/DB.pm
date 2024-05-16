# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::PaS::DB;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::System::Cache',
    'Kernel::System::DB',
    'Kernel::System::Log',
    'Kernel::System::Valid',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # get customer company map
    $Self->{PaSMap} = $Param{PaSMap} || die "Got no PaSMap!";

    # config options
    $Self->{PaSTable} = $Self->{PaSMap}->{Params}->{Table}
        || die "Need PaS->Params->Table in Kernel/Config.pm!";
    $Self->{PaSKey} = $Self->{PaSMap}->{PaSKey}
        || die "Need PaS->PaSKey in Kernel/Config.pm!";
    $Self->{PaSValid} = $Self->{PaSMap}->{'PaSValid'};
    $Self->{SearchListLimit}      = $Self->{PaSMap}->{'PaSSearchListLimit'} || 50000;
    $Self->{SearchPrefix}         = $Self->{PaSMap}->{'PaSSearchPrefix'};
    if ( !defined( $Self->{SearchPrefix} ) ) {
        $Self->{SearchPrefix} = '';
    }
    $Self->{SearchSuffix} = $Self->{PaSMap}->{'PaSSearchSuffix'};
    if ( !defined( $Self->{SearchSuffix} ) ) {
        $Self->{SearchSuffix} = '*';
    }

    # create cache object, but only if CacheTTL is set in customer config
    if ( $Self->{PaSMap}->{CacheTTL} ) {
        $Self->{CacheObject} = $Kernel::OM->Get('Kernel::System::Cache');
        $Self->{CacheType}   = 'PaS' . $Param{Count};
        $Self->{CacheTTL}    = $Self->{PaSMap}->{CacheTTL} || 0;
    }

    # get database object
    $Self->{DBObject} = $Kernel::OM->Get('Kernel::System::DB');

    # create new db connect if DSN is given
    if ( $Self->{PaSMap}->{Params}->{DSN} ) {
        $Self->{DBObject} = Kernel::System::DB->new(
            DatabaseDSN  => $Self->{PaSMap}->{Params}->{DSN},
            DatabaseUser => $Self->{PaSMap}->{Params}->{User},
            DatabasePw   => $Self->{PaSMap}->{Params}->{Password},
            Type         => $Self->{PaSMap}->{Params}->{Type} || '',
        ) || die('Can\'t connect to database!');

        # remember that we have the DBObject not from parent call
        $Self->{NotParentDBObject} = 1;
    }

    # this setting specifies if the table has the create_time,
    # create_by, change_time and change_by fields of OTRS
    $Self->{ForeignDB} = $Self->{PaSMap}->{Params}->{ForeignDB} ? 1 : 0;

    # see if database is case sensitive
    $Self->{CaseSensitive} = $Self->{PaSMap}->{Params}->{CaseSensitive} || 0;

    return $Self;
}

sub PaSList {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    my $Valid = 1;
    if ( !$Param{Valid} && defined( $Param{Valid} ) ) {
        $Valid = 0;
    }

    my $Limit = $Param{Limit} // $Self->{SearchListLimit};

    my $CacheType;
    my $CacheKey;

    # check cache
    if ( $Self->{CacheObject} ) {

#        $CacheType = $Self->{CacheType} . '_PaSList';
#        $CacheKey = "PaSList::${Valid}::${Limit}::" . ( $Param{Search} || '' );
#
#        my $Data = $Self->{CacheObject}->Get(
#            Type => $CacheType,
#            Key  => $CacheKey,
#        );
#        return %{$Data} if ref $Data eq 'HASH';
    }

    # what is the result
    my $What = join(
        ', ',
        @{ $Self->{PaSMap}->{PaSListFields} }
    );

    # add valid option if required
    my $SQL;
    my @Bind;

    if ($Valid) {

        # get valid object
        my $ValidObject = $Kernel::OM->Get('Kernel::System::Valid');

        $SQL
            .= "$Self->{ProductsValid} IN ( ${\(join ', ', $ValidObject->ValidIDsGet())} )";
    }

    # where
    if ( $Param{Search} ) {

        my @Parts = split /\+/, $Param{Search}, 6;
        for my $Part (@Parts) {
            $Part = $Self->{SearchPrefix} . $Part . $Self->{SearchSuffix};
            $Part =~ s/\*/%/g;
            $Part =~ s/%%/%/g;

            if ( defined $SQL ) {
                $SQL .= " AND ";
            }

            my $ProductsSearchFields = $Self->{PaSMap}->{PaSSearchFields};

            if ( $ProductsSearchFields && ref $ProductsSearchFields eq 'ARRAY' ) {

                my @SQLParts;
                for my $Field ( @{$ProductsSearchFields} ) {
                    if ( $Self->{CaseSensitive} ) {
                        push @SQLParts, "$Field LIKE ?";
                        push @Bind,     \$Part;
                    }
                    else {
                        push @SQLParts, "LOWER($Field) LIKE LOWER(?)";
                        push @Bind,     \$Part;
                    }
                }
                if (@SQLParts) {
                    $SQL .= join( ' OR ', @SQLParts );
                }
            }
        }
    }

    # sql
    my $CompleteSQL = "SELECT $Self->{PaSKey}, $What FROM $Self->{PaSTable}";
    $CompleteSQL .= $SQL ? " WHERE $SQL" : '';

    # ask database
    $Self->{DBObject}->Prepare(
        SQL   => $CompleteSQL,
        Bind  => \@Bind,
        Limit => $Limit,
    );

    # fetch the result
    my %List;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {

        my $PaSID = shift @Row;
        $List{$PaSID} = join( ' ', map { defined($_) ? $_ : '' } @Row );
    }

    # cache request
    if ( $Self->{CacheObject} ) {
        $Self->{CacheObject}->Set(
            Type  => $CacheType,
            Key   => $CacheKey,
            Value => \%List,
            TTL   => $Self->{CacheTTL},
        );
    }

    return %List;
}

sub PaSGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{PaSID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need PaSID!'
        );
        return;
    }

    # check cache
    if ( $Self->{CacheObject} ) {
        my $Data = $Self->{CacheObject}->Get(
            Type => $Self->{CacheType},
            Key  => "PaSGet::$Param{PaSID}",
        );
        return %{$Data} if ref $Data eq 'HASH';
    }

    # build select
    my @Fields;
    my %FieldsMap;
    for my $Entry ( @{ $Self->{PaSMap}->{Map} } ) {
        push @Fields, $Entry->[2];
        $FieldsMap{ $Entry->[2] } = $Entry->[0];
    }
    my $SQL = 'SELECT ' . join( ', ', @Fields );

    if ( !$Self->{ForeignDB} ) {
        $SQL .= ", create_time, create_by, change_time, change_by";
    }

    # this seems to be legacy, if Name is passed it should take precedence over PaSID
    my $PaSID = $Param{Name} || $Param{PaSID};

    $SQL .= " FROM $Self->{PaSTable} WHERE ";

    if ( $Self->{CaseSensitive} ) {
        $SQL .= "$Self->{PaSKey} = ?";
    }
    else {
        $SQL .= "LOWER($Self->{PaSKey}) = LOWER( ? )";
    }

    # get initial data
    return if !$Self->{DBObject}->Prepare(
        SQL  => $SQL,
        Bind => [ \$PaSID ]
    );

    # fetch the result
    my %Data;
    ROW:
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {

        my $MapCounter = 0;

        for my $Field (@Fields) {
            $Data{ $FieldsMap{$Field} } = $Row[$MapCounter];
            $MapCounter++;
        }

        next ROW if $Self->{ForeignDB};

        for my $Key (qw(CreateTime CreateBy ChangeTime ChangeBy)) {
            $Data{$Key} = $Row[$MapCounter];
            $MapCounter++;
        }
    }

    # cache request
    if ( $Self->{CacheObject} ) {
        $Self->{CacheObject}->Set(
            Type  => $Self->{CacheType},
            Key   => "PaSGet::$Param{PaSID}",
            Value => \%Data,
            TTL   => $Self->{CacheTTL},
        );
    }

    # return data
    return (%Data);
}

sub PaSAdd {
    my ( $Self, %Param ) = @_;

    # check ro/rw
    if ( $Self->{ReadOnly} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'PaS backend is read only!'
        );
        return;
    }

    my @Fields;
    my @Placeholders;
    my @Values;

    for my $Entry ( @{ $Self->{PaSMap}->{Map} } ) {
        push @Fields,       $Entry->[2];
        push @Placeholders, '?';
        push @Values,       \$Param{ $Entry->[0] };
    }
    if ( !$Self->{ForeignDB} ) {
        push @Fields,       qw(create_time create_by change_time change_by form_id);
        push @Placeholders, qw(current_timestamp ? current_timestamp ? ?);
        push @Values, ( \$Param{UserID}, \$Param{UserID}, \$Param{FormID} );
    }

    # build insert
    my $SQL = "INSERT INTO $Self->{PaSTable} (";
    $SQL .= join( ', ', @Fields ) . " ) VALUES ( " . join( ', ', @Placeholders ) . " )";

    return if !$Self->{DBObject}->Do(
        SQL  => $SQL,
        Bind => \@Values,
    );

    # log notice
    $Kernel::OM->Get('Kernel::System::Log')->Log(
        Priority => 'info',
        Message =>
            "PaS: '$Param{PaSName}/$Param{PaSID}' created successfully ($Param{UserID})!",
    );

    $Self->_PaSCacheClear( PaSID => $Param{PaSID} );

    return $Param{PaSID};
}

sub PaSUpdate {
    my ( $Self, %Param ) = @_;

    # check ro/rw
    if ( $Self->{ReadOnly} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Customer backend is read only!'
        );
        return;
    }

    # check needed stuff
    for my $Entry ( @{ $Self->{PaSMap}->{Map} } ) {
        if ( !$Param{ $Entry->[0] } && $Entry->[4] && $Entry->[0] ne 'UserPassword' ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Entry->[0]!"
            );
            return;
        }
    }

    my @Fields;
    my @Values;

    FIELD:
    for my $Entry ( @{ $Self->{PaSMap}->{Map} } ) {
        next FIELD if $Entry->[0] =~ /^UserPassword$/i;
        push @Fields, $Entry->[2] . ' = ?';
        push @Values, \$Param{ $Entry->[0] };
    }
    if ( !$Self->{ForeignDB} ) {
        push @Fields, ( 'change_time = current_timestamp', 'change_by = ?' );
        push @Values, \$Param{UserID};
    }

    # create SQL statement
    my $SQL = "UPDATE $Self->{PaSTable} SET ";
    $SQL .= join( ', ', @Fields );

    if ( $Self->{CaseSensitive} ) {
        $SQL .= " WHERE $Self->{PaSKey} = ?";
    }
    else {
        $SQL .= " WHERE LOWER($Self->{PaSKey}) = LOWER( ? )";
    }
    push @Values, \$Param{PaSID};

    return if !$Self->{DBObject}->Do(
        SQL  => $SQL,
        Bind => \@Values,
    );

    # log notice
    $Kernel::OM->Get('Kernel::System::Log')->Log(
        Priority => 'info',
        Message =>
            "PaS: '$Param{PaSName}/$Param{PaSID}' updated successfully ($Param{UserID})!",
    );

    $Self->_PaSCacheClear( PaSID => $Param{PaSID} );
    if ( $Param{PaSID} ne $Param{PaSID} ) {
        $Self->_PaSCacheClear( PaSID => $Param{PaSID} );
    }

    return 1;
}

sub _PaSCacheClear {
    my ( $Self, %Param ) = @_;

    return if !$Self->{CacheObject};

    if ( !$Param{PaSID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need PaSID!'
        );
        return;
    }

    $Self->{CacheObject}->Delete(
        Type => $Self->{CacheType},
        Key  => "PaSGet::$Param{PaSID}",
    );

    # delete all search cache entries
    $Self->{CacheObject}->CleanUp(
        Type => $Self->{CacheType} . '_PaSList',
    );

    for my $Function (qw(PaSList)) {
        for my $Valid ( 0 .. 1 ) {
            $Self->{CacheObject}->Delete(
                Type => $Self->{CacheType},
                Key  => "${Function}::${Valid}",
            );
        }
    }

    return 1;
}

sub DESTROY {
    my $Self = shift;

    # disconnect if it's not a parent DBObject
    if ( $Self->{NotParentDBObject} ) {
        if ( $Self->{DBObject} ) {
            $Self->{DBObject}->Disconnect();
        }
    }

    return 1;
}

1;
