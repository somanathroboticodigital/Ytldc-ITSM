# --
# Kernel/System/Products.pm - core module
# Copyright (C) (year) (name of author) (email of author)
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Question;

use strict;
use warnings;

use base qw(Kernel::System::EventHandler);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Main',
    'Kernel::System::Cache',
	'Kernel::System::CustomerUser',
	'Kernel::System::DB',
	'Kernel::System::DynamicField',
	'Kernel::System::DynamicField::Backend',
	'Kernel::System::Encode',
	'Kernel::System::GeneralCatalog',
	'Kernel::System::HTMLUtils',
	'Kernel::System::LinkObject',
	'Kernel::System::Log',
	'Kernel::System::Main',
	'Kernel::System::User',
	'Kernel::System::VirtualFS',
);

sub new {
		my ( $Type, %Param ) = @_;

	# allocate new hash for object
	my $Self = {};
	bless( $Self, $Type );

	# set the debug flag
	$Self->{Debug} = $Param{Debug} || 0;

	# init of event handler
	$Self->EventHandlerInit(
		Config => 'Question::EventModule',
	);

	
	# get database type
	$Self->{DBType} = $Kernel::OM->Get('Kernel::System::DB')->{'DB::Type'} || '';
	$Self->{DBType} = lc $Self->{DBType};

	return $Self;
}

sub QuestionAdd{
	
	my ( $Self, %Param ) = @_;

	# check needed stuff
	if ( !$Param{UserID} ) {
		$Kernel::OM->Get('Kernel::System::Log')->Log(
			Priority => 'error',
			Message  => 'Need UserID!',
		);
		return;
	}


	
	# add  to question to database
	return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
		 SQL => 'INSERT INTO question ( tn, create_time, change_time, create_by, change_by, pas_id)
            VALUES ( ?, current_timestamp, current_timestamp, ?, ?, ?)',
		Bind => [
			\$Param{QuestionNumber}, \$Param{UserID}, \$Param{UserID}, \$Param{PaSID}
		],
	);


	# get change id
	my $QuestionID = $Self->QuestionIDLookup(
		TicketNumber => $Param{QuestionNumber},
	);

	return if !$QuestionID;

	
	# update change with remaining parameters
	# the already handles params have been deleted from %Param
	my $UpdateSuccess = $Self->QuestionUpdate(
		%Param,
		QuestionID => $QuestionID,
	);

	# check update error
	if ( !$UpdateSuccess ) {
		
	}

	return $QuestionID;
}

sub QuestionUpdate{
	
	my ( $Self, %Param ) = @_;
  

	# get old data to be given to post event handler
	my $QuestionData = $Self->QuestionGet(
		QuestionID => $Param{QuestionID},
		UserID   => $Param{UserID},
	);

	# set the change dynamic fields
	KEY:
	for my $Key ( sort keys %Param ) {

		next KEY if $Key !~ m{ \A DynamicField_(.*) \z }xms;

		# save the real name of the dynamic field (without prefix)
		my $DynamicFieldName = $1;

		# get the dynamic field config
		my $DynamicFieldConfig = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldGet(
			Name => $DynamicFieldName,
		);

		# write value to dynamic field
		my $Success = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->ValueSet(
			DynamicFieldConfig => $DynamicFieldConfig,
			ObjectID		   => $Param{QuestionID},
			Value			  => $Param{$Key},
			UserID			 => $Param{UserID},
		);
	}
# map update attributes to column names
	my %Attribute = (
		UserID		=> 'create_by',
		
	);

	# build SQL to update Product
	my $SQL = 'UPDATE question SET ';
	my @Bind;

	ATTRIBUTE:
	for my $Attribute ( sort keys %Attribute ) {

		# preserve the old value, when the column isn't in function parameters
		next ATTRIBUTE if !exists $Param{$Attribute};

		# param checking has already been done, so this is safe
		$SQL .= "$Attribute{$Attribute} = ?, ";
		push @Bind, \$Param{$Attribute};
	}

	$SQL .= 'change_time = current_timestamp, change_by = ? ';
	push @Bind, \$Param{UserID};
	$SQL .= 'WHERE id = ?';
	push @Bind, \$Param{QuestionID};

	# update Product
	return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
		SQL  => $SQL,
		Bind => \@Bind,
	);
return 1;
	
}

sub QuestionGet{
	
	
	my ( $Self, %Param ) = @_;

	# check needed stuff
	for my $Attribute (qw(QuestionID UserID)) {
		if ( !$Param{$Attribute} ) {
			$Kernel::OM->Get('Kernel::System::Log')->Log(
				Priority => 'error',
				Message  => "Need $Attribute!",
			);
			return;
		}
	}

	my %QuestionData;


		# get data from database
		return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
			SQL => ' SELECT id,tn, create_by, change_by,create_time,change_time, pas_id 
            FROM question
            WHERE id = ?
            ORDER BY create_time, id', 
			Bind  => [ \$Param{QuestionID} ],
			Limit => 1,
		);

		# fetch the result
		while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
			$QuestionData{QuestionID}		   = $Row[0];
			$QuestionData{QuestionNumber}	   = $Row[1];
			$QuestionData{CreatedBy}	  	   = $Row[2];
			$QuestionData{ChangeBy}	  		   = $Row[3];
			$QuestionData{CreateTime}	  	   = $Row[4];
			$QuestionData{ChangeTime}	  	   = $Row[5];
            $QuestionData{PaSID}               = $Row[6];
			
		}

		# check error
		if ( !%QuestionData ) {
			if ( !$Param{LogNo} ) {
				$Kernel::OM->Get('Kernel::System::Log')->Log(
					Priority => 'error',
					Message  => "Change with ID $Param{QuestionID} does not exist.",
				);
			}
			return;
		}

		
		# get all dynamic fields for the object type ITSMChange
		my $DynamicFieldList = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
			ObjectType => 'Question',
		);

		DYNAMICFIELD:
		for my $DynamicFieldConfig ( @{$DynamicFieldList} ) {

			# validate each dynamic field
			next DYNAMICFIELD if !$DynamicFieldConfig;
		#	next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
			next DYNAMICFIELD if !$DynamicFieldConfig->{Name};
		#	next DYNAMICFIELD if !IsHashRefWithData( $DynamicFieldConfig->{Config} );

			# get the current value for each dynamic field
			my $Value = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->ValueGet(
				DynamicFieldConfig => $DynamicFieldConfig,
				ObjectID		   => $Param{QuestionID},
			);

			# set the dynamic field name and value into the change data hash
			$QuestionData{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = $Value // '';
		}

	# add result to change data
	%QuestionData = ( %QuestionData );

	
	return \%QuestionData;
	
}

sub QuestionIDLookup {
    my ( $Self, %Param ) = @_;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # db query
    return if !$DBObject->Prepare(
        SQL   => 'SELECT id FROM question WHERE tn = ?',
        Bind  => [ \$Param{TicketNumber} ],
        Limit => 1,
    );

    my $ID;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        $ID = $Row[0];
    }

    return $ID;
}

sub QuestionSearch{
	
	
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!',
        );
        return;
    }

    # verify that all passed array parameters contain an arrayref
    ARGUMENT:
    for my $Argument (
        qw(
        OrderBy
        )
        )
    {
        if ( !defined $Param{$Argument} ) {
            $Param{$Argument} ||= [];

            next ARGUMENT;
        }

        if ( ref $Param{$Argument} ne 'ARRAY' ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "$Argument must be an array reference!",
            );
            return;
        }
    }

    # define a local database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # define order table
    my %OrderByTable = (
        QuestionID        => 's.id',
    );

    # check if OrderBy contains only unique valid values
    my %OrderBySeen;
    for my $OrderBy ( @{ $Param{OrderBy} } ) {

        if ( !$OrderBy || !$OrderByTable{$OrderBy} || $OrderBySeen{$OrderBy} ) {

            # found an error
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "OrderBy contains invalid value '$OrderBy' "
                    . 'or the value is used more than once!',
            );
            return;
        }

        # remember the value to check if it appears more than once
        $OrderBySeen{$OrderBy} = 1;
    }

    # check if OrderByDirection array contains only 'Up' or 'Down'
    DIRECTION:
    for my $Direction ( @{ $Param{OrderByDirection} } ) {

        # only 'Up' or 'Down' allowed
        next DIRECTION if $Direction eq 'Up';
        next DIRECTION if $Direction eq 'Down';

        # found an error
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "OrderByDirection can only contain 'Up' or 'Down'!",
        );
        return;
    }

    # set default values
    if ( !defined $Param{UsingWildcards} ) {
        $Param{UsingWildcards} = 1;
    }

    # set the default behaviour for the return type
    my $Result = $Param{Result} || 'ARRAY';

    my @SQLWhere;          # assemble the conditions used in the WHERE clause
    my @SQLHaving;        # assemble the conditions used in the HAVING clause
    my @InnerJoinTables;    # keep track of the tables that need to be inner joined
    my @OuterJoinTables;    # keep track of the tables that need to be outer joined

    # check all configured products dynamic fields, build lookup hash by name
    my %QuestionDynamicFieldName2Config;
    my $QuestionDynamicFields = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
        ObjectType => 'Question',
    );
    for my $DynamicField ( @{$QuestionDynamicFields} ) {
        $QuestionDynamicFieldName2Config{ $DynamicField->{Name} } = $DynamicField;
    }


    # add string params to the WHERE clause
    my %StringParams;

    # add string params to sql-where-array
    STRINGPARAM:
    for my $StringParam ( sort keys %StringParams ) {

        # check string params for useful values, the string '0' is allowed
        next STRINGPARAM if !exists $Param{$StringParam};
        next STRINGPARAM if !defined $Param{$StringParam};
        next STRINGPARAM if $Param{$StringParam} eq '';

        # quote
        $Param{$StringParam} = $DBObject->Quote( $Param{$StringParam} );

        # check if a CLOB field is used in oracle
        # Fix/Workaround for ORA-00932: inconsistent datatypes: expected - got CLOB
        my $ForceLikeSearchForSpecialFields;
        if (
            $Self->{DBType} eq 'oracle'
            && ( $StringParam eq 'Description' || $StringParam eq 'Justification' )
            )
        {
            $ForceLikeSearchForSpecialFields = 1;
        }

        # wildcards are used (or LIKE search is forced for some special fields on oracle)
        if ( $Param{UsingWildcards} || $ForceLikeSearchForSpecialFields ) {

            # get like escape string needed for some databases (e.g. oracle)
            my $LikeEscapeString = $DBObject->GetDatabaseFunction('LikeEscapeString');

            # Quote
            $Param{$StringParam} = $DBObject->Quote( $Param{$StringParam}, 'Like' );

            # replace * with %
            $Param{$StringParam} =~ s{ \*+ }{%}xmsg;

            # do not use string params which contain only %
            next STRINGPARAM if $Param{$StringParam} =~ m{ \A %* \z }xms;

            push @SQLWhere,
                "LOWER($StringParams{$StringParam}) LIKE LOWER('$Param{$StringParam}') $LikeEscapeString";
        }

        # no wildcards are used
        else {
            push @SQLWhere,
                "LOWER($StringParams{$StringParam}) = LOWER('$Param{$StringParam}')";
        }
    }

    # build sql for dynamic fields
    my $SQLDynamicFieldInnerJoins = ''; # join-statements
    my $SQLDynamicFieldWhere      = ''; # where-clause
    my $DynamicFieldJoinCounter   = 1;

    DYNAMICFIELD:
    for my $DynamicField ( @{$QuestionDynamicFields} ) {

        my $SearchParam = $Param{ "DynamicField_" . $DynamicField->{Name} };

        next DYNAMICFIELD if ( !$SearchParam );
        next DYNAMICFIELD if ( ref $SearchParam ne 'HASH' );

        my $NeedJoin;

        for my $Operator ( sort keys %{$SearchParam} ) {

            my @SearchParams = ( ref $SearchParam->{$Operator} eq 'ARRAY' )
                ? @{ $SearchParam->{$Operator} }
                : ( $SearchParam->{$Operator} );

            my $SQLDynamicFieldWhereSub = '';
            if ($SQLDynamicFieldWhere) {
                $SQLDynamicFieldWhereSub = ' AND (';
            }
            else {
                $SQLDynamicFieldWhereSub = ' (';
            }

            my $Counter = 0;
            TEXT:
            for my $Text (@SearchParams) {
                next TEXT if ( !defined $Text || $Text eq '' );

                $Text =~ s/\*/%/gi;

                # check search attribute, we do not need to search for *
                next TEXT if $Text =~ /^\%{1,3}$/;

                # validate data type
                my $ValidateSuccess = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->ValueValidate(
                    DynamicFieldConfig => $DynamicField,
                    Value             => $Text,
                    UserID           => $Param{UserID} || 1,
                );
                if ( !$ValidateSuccess ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message =>
                            "Search not executed due to invalid value '"
                            . $Text
                            . "' on field '"
                            . $DynamicField->{Name}
                            . "'!",
                    );
                    return;
                }

                if ($Counter) {
                    $SQLDynamicFieldWhereSub .= ' OR ';
                }
                $SQLDynamicFieldWhereSub
                    .= $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->SearchSQLGet(
                    DynamicFieldConfig => $DynamicField,
                    TableAlias       => "dfv$DynamicFieldJoinCounter",
                    Operator           => $Operator,
                    SearchTerm       => $Text,
                    );

                $Counter++;
            }
            $SQLDynamicFieldWhereSub .= ') ';
            if ($Counter) {
                $SQLDynamicFieldWhere .= $SQLDynamicFieldWhereSub;
                $NeedJoin = 1;
            }
        }

        if ($NeedJoin) {

            if ( $DynamicField->{ObjectType} eq 'Question' ) {

                # join the table for this dynamic field
                $SQLDynamicFieldInnerJoins
                    .= "INNER JOIN dynamic_field_value dfv$DynamicFieldJoinCounter
                    ON (p.id = dfv$DynamicFieldJoinCounter.object_id
                        AND dfv$DynamicFieldJoinCounter.field_id = " .
                    $DBObject->Quote( $DynamicField->{ID}, 'Integer' ) . ") ";
            }

            elsif ( $DynamicField->{ObjectType} eq 'ITSMWorkOrder' ) {

                # always join the workorder table for inner joins with the products table
                # it does not matter if already contained in @InnerJoinTables
                # as double entries are filtered out later
                push @InnerJoinTables, 'wo2';

                $SQLDynamicFieldInnerJoins
                    .= "INNER JOIN dynamic_field_value dfv$DynamicFieldJoinCounter
                    ON (wo2.id = dfv$DynamicFieldJoinCounter.object_id
                        AND dfv$DynamicFieldJoinCounter.field_id = " .
                    $DBObject->Quote( $DynamicField->{ID}, 'Integer' ) . ") ";
            }

            $DynamicFieldJoinCounter++;
        }
    }

    # set array params
    my %ArrayParams;

    # add array params to sql-where-array
    ARRAYPARAM:
    for my $ArrayParam ( sort keys %ArrayParams ) {

        # ignore empty lists
        next ARRAYPARAM if !@{ $Param{$ArrayParam} };

        # quote
        for my $OneParam ( @{ $Param{$ArrayParam} } ) {
            $OneParam = $DBObject->Quote( $OneParam, 'Integer' );
        }

        # create string
        my $InString = join ', ', @{ $Param{$ArrayParam} };

        push @SQLWhere, "$ArrayParams{$ArrayParam} IN ($InString)";
    }

    # delete the OrderBy parameter when the result type is 'COUNT'
    if ( $Result eq 'COUNT' ) {
        $Param{OrderBy} = [];
    }

    # assemble the ORDER BY clause
    my @SQLOrderBy;
    my @SQLAliases; # order by aliases, be on the save side with MySQL
    my $Count = 0;
    for my $OrderBy ( @{ $Param{OrderBy} } ) {

        # set the default order direction
        my $Direction = 'DESC';

        # add the given order direction
        if ( $Param{OrderByDirection}->[$Count] ) {
            if ( $Param{OrderByDirection}->[$Count] eq 'Up' ) {
                $Direction = 'ASC';
            }
            elsif ( $Param{OrderByDirection}->[$Count] eq 'Down' ) {
                $Direction = 'DESC';
            }
        }


        push @SQLOrderBy, "$OrderByTable{$OrderBy} $Direction";
    }
    continue {
        $Count++;
    }

    # if there is a possibility that the ordering is not determined
    # we add an descending ordering by id
    if ( !grep { $_ eq 'QuestionID' } ( @{ $Param{OrderBy} } ) ) {
        push @SQLOrderBy, "$OrderByTable{QuestionID} DESC";
    }

    # assemble the SQL query
    my $SQL = 'SELECT ' . join( ', ', ( 's.id', @SQLAliases ) ) . ' FROM question s ';

    # modify SQL when the result type is 'COUNT', and when there are no joins
    if ( $Result eq 'COUNT' && !@InnerJoinTables && !@OuterJoinTables ) {
        $SQL        = 'SELECT COUNT(s.id) FROM question s ';
        @SQLOrderBy = ();
    }

    # add the joins
    my %LongTableName;
    my %TableSeen;

    INNER_JOIN_TABLE:
    for my $Table (@InnerJoinTables) {

        # do not join a table twice
        next INNER_JOIN_TABLE if $TableSeen{$Table};

        $TableSeen{$Table} = 1;

        if ( !$LongTableName{$Table} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Encountered invalid inner join table '$Table'!",
            );
            return;
        }

        $SQL .= "INNER JOIN $LongTableName{$Table} $Table ON $Table.id = s.id ";
    }

    # add the dynamic field inner join statements
    $SQL .= $SQLDynamicFieldInnerJoins;

    OUTER_JOIN_TABLE:
    for my $Table (@OuterJoinTables) {

        # do not join a table twice, when a table has been inner joined, no outer join is necessary
        next OUTER_JOIN_TABLE if $TableSeen{$Table};

        # remember that this table is joined already
        $TableSeen{$Table} = 1;

        # check error
        if ( !$LongTableName{$Table} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Encountered invalid outer join table '$Table'!",
            );
            return;
        }

        $SQL .= "LEFT OUTER JOIN $LongTableName{$Table} $Table ON $Table.id = s.id ";
    }

    # add the WHERE clause
    if (@SQLWhere) {
        $SQL .= 'WHERE ';
        $SQL .= join ' AND ', map {"( $_ )"} @SQLWhere;
        $SQL .= ' ';
        if ($SQLDynamicFieldWhere) {
            $SQL .= ' AND ' . $SQLDynamicFieldWhere;
        }
    }
    else {
        if ($SQLDynamicFieldWhere) {
            $SQL .= ' WHERE ' . $SQLDynamicFieldWhere;
        }
    }

    # we need to group whenever there is a join
    if (
        scalar @InnerJoinTables
        || $SQLDynamicFieldWhere
        || scalar @OuterJoinTables
        )
    {
        $SQL .= 'GROUP BY s.id ';

        # add the orderby columns also to the group by clause, as this is correct SQL
        # and some DBs like PostgreSQL are more strict than others
        # this is the bugfix for bug# 5825 http://bugs.otrs.org/show_bug.cgi?id=5825
        if (@SQLOrderBy) {

            ORDERBY:
            for my $OrderBy (@SQLOrderBy) {

                # get the column from a string that looks like: p.products_number ASC
                if ( $OrderBy =~ m{ \A (\S+) }xms ) {

                    # get the column part of the string
                    my $Column = $1;

                    # do not include the p.id column again, as this is already done before
                    next ORDERBY if $Column eq 's.id';

                    # do not include aliases of aggregate functions (min/max)
                    next ORDERBY if $Column =~ m{ \A alias_ }xms;

                    # add the column to the group by clause
                    $SQL .= ", $Column ";
                }
            }
        }
    }

    # add the HAVING clause
    if (@SQLHaving) {
        $SQL .= 'HAVING ';
        $SQL .= join ' AND ', map {"( $_ )"} @SQLHaving;
        $SQL .= ' ';
    }

    # add the ORDER BY clause
    if (@SQLOrderBy) {
        $SQL .= 'ORDER BY ';
        $SQL .= join ', ', @SQLOrderBy;
        $SQL .= ' ';
    }

    # ignore the parameter 'Limit' when result type is 'COUNT'
    if ( $Result eq 'COUNT' ) {
        delete $Param{Limit};
    }

    # ask database
    return if !$DBObject->Prepare(
        SQL   => $SQL,
        Limit => $Param{Limit},
    );

    # fetch the result
    my @IDs;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        push @IDs, $Row[0];
    }

    if (
        $Result eq 'COUNT'
        && !@InnerJoinTables
        && !$SQLDynamicFieldWhere
        && !@OuterJoinTables
        )
    {

        # return the COUNT(p.id) attribute
        return $IDs[0] || 0;
    }
    elsif ( $Result eq 'COUNT' ) {

        # return the count as the number of IDs
        return scalar @IDs;
    }
    else {
        return \@IDs;
    }
	
}
sub QuestionDelete{
	
	my ( $Self, %Param ) = @_;
  

	# get old data to be given to post event handler
	my $QuestionData = $Self->QuestionGet(
		QuestionID => $Param{QuestionID},
		UserID   => $Param{UserID},
	);

    my $Success = return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
			SQL => ' DELETE FROM question WHERE id = ?',
            Bind  => [ \$Param{QuestionID} ],
			
		);
 
    return $Success;
}
1;