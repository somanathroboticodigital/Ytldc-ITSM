# --
# Kernel/System/PaS.pm - core module
# Copyright (C) (year) (name of author) (email of author)
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::PaS;

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
	 'Kernel::System::Valid',
);


sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # get needed objects
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $MainObject   = $Kernel::OM->Get('Kernel::System::Main');

    # load customer PaS backend modules
    SOURCE:
    for my $Count ( '', 1 .. 10 ) {

    	# $Kernel::OM->Get('Kernel::System::Log')->Log(
		# 	Priority => 'error', 
		# 	Message  => "PAs list $Count <> PaS$Count <> "
		# );



        next SOURCE if !$ConfigObject->Get("PaS$Count");

        my $GenericModule = $ConfigObject->Get("PaS$Count")->{Module}
            || 'Kernel::System::PaS::DB';
        if ( !$MainObject->Require($GenericModule) ) {
            $MainObject->Die("Can't load backend module $GenericModule! $@");
        }
        $Self->{"PaS$Count"} = $GenericModule->new(
            Count              => $Count,
            PaSMap => $ConfigObject->Get("PaS$Count"),
        );
    }

    # init of event handler
    $Self->EventHandlerInit(
        Config => 'PaS::EventModulePost',
    );

    return $Self;
}

sub PaSAdd {
    my ( $Self, %Param ) = @_;   
    
	if ( !$Param{UserID} ) {
		
		$Kernel::OM->Get('Kernel::System::Log')->Log(
			Priority => 'error',
			Message  => 'Need UserID!',
		);
		return;
	}

	# trigger PaSAddPre-Event
	$Self->EventHandler(
		Event => 'PaSAddPre',
		Data  => {
			%Param,
		},
		UserID => $Param{UserID},
	);
		
	  # check data source
    if ( !$Param{Source} ) {
        $Param{Source} = 'PaS';
      }	
	# create a new PaS number
	my $PaSNumber = $Param{PaSNumber};
	 
    return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => 'INSERT INTO pas (pas_number, tn, create_time, change_time, create_by, change_by, sla_id, pas_title)
            VALUES ( ?, ?, current_timestamp, current_timestamp, ?, ?, ?, ?)',
        Bind => [
           \$Param{PaSNumber}, \$Param{PaSNumber},\$Param{UserID},\$Param{UserID},\$Param{SLAID},\$Param{DynamicField_PasTitle}
        ],
    );
    
  
  
  my $PaSID = $Self->PaSIDLookup(
   TicketNumber => $Param{PaSNumber},
   UserID       => $Param{UserID},
    );
  
   my $UpdateSuccess = $Self->PaSUpdate(
		%Param,
		PaSID => $PaSID,
	);
    
   my $newPaSHistoryAdd = $Self->PaSHistoryAdd(
        %Param,
		PaSID => $PaSID,
		Name => 'PaS Added',
    );
    # trigger event
    $Self->EventHandler(
        Event => 'PaSAdd',
        Data  => {
            PaSID =>$Param{PaSNumber},
            NewData    => \%Param,
        },
        UserID => $Param{UserID},
        UserID       => $Param{UserID},
    );
#      my $PaSCacheclear = $Self->{ $Param{Source} }->_PaSCacheClear(
#        %Param,
#		PaSID => $PaSID,
#	);
  
    # delete cache
	for my $Key (
		'PaSGet::ID::' . $PaSID,
		'PaSList',
		'PaSIDLookup::PaSID::' . $PaSID,
		)
	{

		$Kernel::OM->Get('Kernel::System::Cache')->Delete(
			Type => $Self->{CacheType},
			Key  => $Key,
		);
	}
    
 $Self->PaSCacheClear( PaSID => $PaSID );
    return $PaSID;
}

sub PaSHistoryAdd {
    my ( $Self, %Param ) = @_;
	if ( !$Param{UserID} ) {
		
		$Kernel::OM->Get('Kernel::System::Log')->Log(
			Priority => 'error',
			Message  => 'Need UserID!',
		);
		return;
	}
	
	$Param{Source} = 'pas';
   	
	return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => 'INSERT INTO pas_history ( name, pas_id, created, created_by, changed, changed_by)
                 VALUES ( ?, ?, current_timestamp, ?,current_timestamp, ?)',
        Bind => [
           \$Param{Name}, \$Param{PaSID},\$Param{UserID},\$Param{UserID}
        ],
    );
    
   return 1;	
}

sub PaSHistoryGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(PaSID UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );

            return;
        }
    }

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    return if !$DBObject->Prepare(
        SQL => '
             SELECT name, created, created_by
            FROM pas_history
            WHERE pas_id = ?
            ORDER BY created, id',
        Bind => [ \$Param{PaSID} ],
    );

    my @Data;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        my %Record = (
            Name      => $Row[0],
            Created   => $Row[1],
            CreatedBy => $Row[2],
        );
        push @Data, \%Record;
    }

    return \@Data;
}

sub PaSIDLookup {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{TicketNumber} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need TicketNumber!'
        );
        return;
    }

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # db query
    return if !$DBObject->Prepare(
        SQL   => 'SELECT id FROM pas WHERE tn = ?',
        Bind  => [ \$Param{TicketNumber} ],
        Limit => 1,
    );

    my $ID;
    while ( my @Row = $DBObject->FetchrowArray() ) {
        $ID = $Row[0];
    }

    return $ID;
}

sub PaSList {
    my ( $Self, %Param ) = @_;


    my %Data;
    SOURCE:
    for my $Count ( '', 1 .. 10 ) {

        next SOURCE if !$Self->{"PaS$Count"};

        # get comppany list result of backend and merge it
        my %SubData = $Self->{"PaS$Count"}->PaSList(%Param);
        %Data = ( %Data, %SubData );
    }
    $Self->_PaSCacheClear( PaSID => $Param{PaSID} );
   
    return %Data;
}

sub PaSSourceList {
    my ( $Self, %Param ) = @_;

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    my %Data;
    SOURCE:
    for my $Count ( '', 1 .. 10 ) {

        next SOURCE if !$ConfigObject->Get("PaS$Count");

        if ( defined $Param{ReadOnly} ) {
            my $BackendConfig = $ConfigObject->Get("PaS$Count");
            if ( $Param{ReadOnly} ) {
                next SOURCE if !$BackendConfig->{ReadOnly};
            }
            else {
                next SOURCE if $BackendConfig->{ReadOnly};
            }
        }

        $Data{"PaS$Count"} = $ConfigObject->Get("PaS$Count")->{Name}
            || "No Name $Count";
    }

		

    
    return %Data;
}


sub PaSList {
    my ( $Self, %Param ) = @_;

    my %Data;
    SOURCE:
    for my $Count ( '', 1 .. 10 ) {

    	

        next SOURCE if !$Self->{"PaS$Count"};

        $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Pass system file steps<> $Count ",
            );

        # get comppany list result of backend and merge it
        my %SubData = $Self->{"PaS$Count"}->PaSList(%Param);
        %Data = ( %Data, %SubData );
    }
    return %Data;
}

#sub PaSGet {
#    my ( $Self, %Param ) = @_;
#
#    # check needed stuff
#    if ( !$Param{PaSID} ) {
#        $Kernel::OM->Get('Kernel::System::Log')->Log(
#            Priority => 'error',
#            Message  => "Need PaSID!"
#        );
#        return;
#    }
#
#    # get config object
#    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
#
#
#    SOURCE:
#
#
#        next SOURCE if !$Self->{"PaS"};
#
#        my %PaS = $Self->{"PaS"}->PaSGet( %Param );
#        next SOURCE if !%PaS;
#
#		# get all dynamic fields for the object type PaS
#		my $DynamicFieldList = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
#			ObjectType => 'PaS',
#		);
#
#		DYNAMICFIELD:
#		for my $DynamicFieldConfig ( @{$DynamicFieldList} ) {
#
#			# validate each dynamic field
#			next DYNAMICFIELD if !$DynamicFieldConfig;
#			next DYNAMICFIELD if !$DynamicFieldConfig->{Name};
#
#			# get the current value for each dynamic field
#			my $Value = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->ValueGet(
#				DynamicFieldConfig => $DynamicFieldConfig,
#				ObjectID		   => $Param{PaSID},
#			);
#
#			# set the dynamic field name and value into the PaS data hash
#			$PaS{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = $Value // '';
#		}
#	
#	return \%PaS;
#
#}


sub PaSUpdate {
	my ( $Self, %Param ) = @_;

	# check needed stuff
	for my $Argument (qw(PaSID UserID )) {
		if ( !$Param{$Argument} ) {
			$Kernel::OM->Get('Kernel::System::Log')->Log(
				Priority => 'error',
				Message  => "Need $Argument!",
			);
			return;
		}
	}

	# trigger PaSUpdatePre-Event
	$Self->EventHandler(
		Event => 'PaSUpdatePre',
		Data  => {
			%Param,
		},
		UserID => $Param{UserID},
	);

	# get old data to be given to post event handler
	my $PaSData = $Self->PaSGet(
		PaSID => $Param{PaSID},
		UserID   => $Param{UserID},
	);

	# set the PaS dynamic fields
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
			ObjectID		   => $Param{PaSID},
			Value			  => $Param{$Key},
			UserID			 => $Param{UserID},
		);
	}

	# map update attributes to column names
	my %Attribute = (
		PaSID		=> 'pas_id',
		SLAID		=> 'sla_id',
	);

	# build SQL to update PaS
	my $SQL = 'UPDATE pas SET ';
	my @Bind;

	ATTRIBUTE:
	for my $Attribute ( sort keys %Attribute ) {

		# preserve the old value, when the column isn't in function parameters
		next ATTRIBUTE if !exists $Param{$Attribute};

		# param checking has already been done, so this is safe
		$SQL .= "$Attribute{$Attribute} = ?, ";
		push @Bind, \$Param{$Attribute};
	}

	$SQL .= 'change_time = current_timestamp, change_by = ?, pas_title = ? ';
	push @Bind, \$Param{UserID}, \$Param{DynamicField_PasTitle};
	$SQL .= 'WHERE id = ?';
	push @Bind, \$Param{PaSID};

	# update PaS
	return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
		SQL  => $SQL,
		Bind => \@Bind,
	);

	

	# trigger PaSUpdatePost-Event
	$Self->EventHandler(
		Event => 'PaSUpdatePost',
		Data  => {
			OldPaSData => $PaSData,
			%Param,
		},
		UserID => $Param{UserID},
	);
$Self->PaSCacheClear( PaSID => $Param{PaSID} );
    if ( $Param{PaSID} ne $Param{PaSID} ) {
        $Self->PaSCacheClear( PaSID => $Param{PaSID} );
    }
	return 1;
}

sub PaSAttachmentList {
	my ( $Self, %Param ) = @_;

	# check needed stuff
	if ( !$Param{PaSID} ) {
		$Kernel::OM->Get('Kernel::System::Log')->Log(
			Priority => 'error',
			Message  => 'Need PaSID!',
		);

		return;
	}

	# find all attachments of this PaS
	my @Attachments = $Kernel::OM->Get('Kernel::System::VirtualFS')->Find(
		Preferences => {
			PaSID => $Param{PaSID},
		},
	);

	for my $Filename (@Attachments) {

		# remove extra information from filename
		$Filename =~ s{ \A PaS / \d+ / }{}xms;
	}

	return @Attachments;
}

sub PaSAttachmentGet {
	my ( $Self, %Param ) = @_;

	# check needed stuff
	for my $Argument (qw(PaSID Filename)) {
		if ( !$Param{$Argument} ) {
			$Kernel::OM->Get('Kernel::System::Log')->Log(
				Priority => 'error',
				Message  => "Need $Argument!",
			);
			return;
		}
	}

	# add prefix
	my $Filename = 'PaS/' . $Param{PaSID} . '/' . $Param{Filename};

	# find all attachments of this PaS
	my @Attachments = $Kernel::OM->Get('Kernel::System::VirtualFS')->Find(
		Filename	=> $Filename,
		Preferences => {
			PaSID => $Param{PaSID},
		},
	);




	# return error if file does not exist
	if ( !@Attachments ) {
		$Kernel::OM->Get('Kernel::System::Log')->Log(
			Message  => "No such attachment ($Filename)! May be an attack!!!",
			Priority => 'error',
		);
		return;
	}

	# get data for attachment
	my %AttachmentData = $Kernel::OM->Get('Kernel::System::VirtualFS')->Read(
		Filename => $Filename,
		Mode	 => 'binary',
	);

	foreach my $key (keys %AttachmentData ) {
	    

	    if ($key eq 'Preferences'){
	    	foreach my $key1 (keys %{$AttachmentData{$key}}) {
		    	$Kernel::OM->Get('Kernel::System::Log')->Log(
					Message  => "Systesm firlm somanath <>$key1 <> $AttachmentData{Preferences}->{$key1}  ",
					Priority => 'error',
				);
		    }
	    }
	}

	my $AttachmentInfo = {
		%AttachmentData,
		Filename	=> $Param{Filename},
		Content	 => ${ $AttachmentData{Content} },
		ContentType => $AttachmentData{Preferences}->{ContentType},
		Type		=> 'attachment',
		Filesize	=> $AttachmentData{Preferences}->{Filesize},
	};

	return $AttachmentInfo;
}

sub PaSAttachmentDelete {
	my ( $Self, %Param ) = @_;

	# check needed stuff
	for my $Needed (qw(PaSID Filename UserID)) {
		if ( !$Param{$Needed} ) {
			$Kernel::OM->Get('Kernel::System::Log')->Log(
				Priority => 'error',
				Message  => "Need $Needed!",
			);

			return;
		}
	}

	# add prefix
	my $Filename = 'PaS/' . $Param{PaSID} . '/' . $Param{Filename};

	# delete file
	my $Success = $Kernel::OM->Get('Kernel::System::VirtualFS')->Delete(
		Filename => $Filename,
	);

	# check for error
	if ($Success) {

		# trigger AttachmentDeletePost-Event
		$Self->EventHandler(
			Event => 'PaSAttachmentDeletePost',
			Data  => {
				%Param,
			},
			UserID => $Param{UserID},
		);
	}
	else {
		$Kernel::OM->Get('Kernel::System::Log')->Log(
			Priority => 'error',
			Message  => "Cannot delete attachment $Filename!",
		);

		return;
	}

	return $Success;
}

sub PaSAttachmentAdd {
	my ( $Self, %Param ) = @_;

	# check needed stuff
	for my $Needed (qw(PaSID Filename Content ContentType UserID)) {
		if ( !$Param{$Needed} ) {
			$Kernel::OM->Get('Kernel::System::Log')->Log(
				Priority => 'error',
				Message  => "Need $Needed!",
			);

			return;
		}
	}

	$Kernel::OM->Get('Kernel::System::Log')->Log(
		Priority => 'error',
		Message  => "ContentID img <> $Param{ContentID}",
	);

	# write to virtual fs
	my $Success = $Kernel::OM->Get('Kernel::System::VirtualFS')->Write(
		Filename	=> "PaS/$Param{PaSID}/$Param{Filename}",
		Mode		=> 'binary',
		Content	 => \$Param{Content},
		Preferences => {
			ContentID   => $Param{ContentID},
			ContentType => $Param{ContentType},
			PaSID	=> $Param{PaSID},
			UserID	  => $Param{UserID},
		},
	);

	# check for error
	if ($Success) {

		# trigger AttachmentAdd-Event
		$Self->EventHandler(
			Event => 'PaSAttachmentAddPost',
			Data  => {
				%Param,
			},
			UserID => $Param{UserID},
		);
	}
	else {
		$Kernel::OM->Get('Kernel::System::Log')->Log(
			Priority => 'error',
			Message  => "Cannot add attachment for PaS $Param{PaSID}",
		);

		return;
	}

	return 1;
}


#sub PaSGet {
#    my ( $Self, %Param ) = @_;
#
#    # check needed stuff
#    if ( !$Param{PaSID} ) {
#        $Kernel::OM->Get('Kernel::System::Log')->Log(
#            Priority => 'error',
#            Message  => "Need PaSID!"
#        );
#        return;
#    }
#
#    # get config object
#    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
#
#    SOURCE:
#    for my $Count ( '', 1 .. 10 ) {
#
#        next SOURCE if !$Self->{"PaS$Count"};
#
#        my %PaS = $Self->{"PaS$Count"}->PaSGet( %Param, );
#        next SOURCE if !%PaS;
#        # get all dynamic fields for the object type PaS
#		my $DynamicFieldList = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
#			ObjectType => 'PaS',
#		);
#
#		DYNAMICFIELD:
#		for my $DynamicFieldConfig ( @{$DynamicFieldList} ) {
#
#			# validate each dynamic field
#			next DYNAMICFIELD if !$DynamicFieldConfig;
#			next DYNAMICFIELD if !$DynamicFieldConfig->{Name};
#
#
#			# get the current value for each dynamic field
#			my $Value = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->ValueGet(
#				DynamicFieldConfig => $DynamicFieldConfig,
#				ObjectID		   => $Param{PaSID},
#			);
#
#			# set the dynamic field name and value into the PaS data hash
#			$PaS{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = $Value // '';
#		}
#        # return PaS data
#        return (
#            %PaS,
#            Source => "PaS$Count",
#            Config => $ConfigObject->Get("PaS$Count"),
#        );
#    }
#
#    return;
#}

sub GetPaSText {
    my ( $Self, %Param ) = @_;

    # Get the DBObject from the central object manager
    # my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    return 'Hello PaS World!';
}

sub PaSSearch {
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
		PaSID		 => 'p.pas_id',
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

	my @SQLWhere;		   # assemble the conditions used in the WHERE clause
	my @SQLHaving;		  # assemble the conditions used in the HAVING clause
	my @InnerJoinTables;	# keep track of the tables that need to be inner joined
	my @OuterJoinTables;	# keep track of the tables that need to be outer joined

	# check all configured products dynamic fields, build lookup hash by name
	my %PaSDynamicFieldName2Config;
	my $PaSDynamicFields = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
		ObjectType => 'PaS',
	);
	for my $DynamicField ( @{$PaSDynamicFields} ) {
		$PaSDynamicFieldName2Config{ $DynamicField->{Name} } = $DynamicField;
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
	my $SQLDynamicFieldInnerJoins = 'INNER JOIN dynamic_field_value dfv0 ON (p.id = dfv0.object_id
                                                AND dfv0.field_id = 41)';	# join-statements
	my $SQLDynamicFieldWhere	  = '';	# where-clause
	my $DynamicFieldJoinCounter   = 1;

	DYNAMICFIELD:
	for my $DynamicField ( @{$PaSDynamicFields} ) {

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
					Value			  => $Text,
					UserID			 => $Param{UserID} || 1,
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
					TableAlias		 => "dfv$DynamicFieldJoinCounter",
					Operator		   => $Operator,
					SearchTerm		 => $Text,
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

			if ( $DynamicField->{ObjectType} eq 'PaS' ) {

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

	# $SQLDynamicFieldInnerJoins
	# 				.= "INNER JOIN dynamic_field_value dfv100
	# 				ON (p.id = dfv100.object_id
	# 					AND dfv100.field_id = " .
	# 				, 'Integer' ) . ") ";

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
	my @SQLAliases;	# order by aliases, be on the save side with MySQL
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
	if ( !grep { $_ eq 'PaSID' } ( @{ $Param{OrderBy} } ) ) {
		push @SQLOrderBy, "dfv0.value_text ASC";
		push @SQLOrderBy, "$OrderByTable{PaSID} DESC";
	}

	# assemble the SQL query
	my $SQL = 'SELECT ' . join( ', ', ( 'p.pas_id', @SQLAliases ) ) . ' FROM pas p ';

	# modify SQL when the result type is 'COUNT', and when there are no joins
	if ( $Result eq 'COUNT' && !@InnerJoinTables && !@OuterJoinTables ) {
		$SQL		= 'SELECT COUNT(p.pas_id) FROM products p ';
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

		$SQL .= "INNER JOIN $LongTableName{$Table} $Table ON $Table.pas_id = p.id ";
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

		$SQL .= "LEFT OUTER JOIN $LongTableName{$Table} $Table ON $Table.pas_id = p.id ";
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
		$SQL .= 'GROUP BY p.id ';

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
					next ORDERBY if $Column eq 'p.id';

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

sub PaSCacheClear {
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
        Type => $Self->{CacheType} . 'PaSList',
    );

    for my $Function (qw(PaSList)) {
        for my $Valid ( 0 .. 1 ) {
            $Self->{CacheObject}->Delete(
                Type => $Self->{CacheType},
            );
        }
    }

    return 1;
}

sub PaSGet {
	my ( $Self, %Param ) = @_;

	# check needed stuff
	for my $Attribute (qw(PaSID UserID)) {
		if ( !$Param{$Attribute} ) {
			$Kernel::OM->Get('Kernel::System::Log')->Log(
				Priority => 'error',
				Message  => "Need $Attribute!",
			);
			return;
		}
	}

my %PaSData;

		# get data from database
		return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
			SQL => 'SELECT id, pas_number, create_time, '
				. 'create_by, change_time, change_by, sla_id, pas_title '
				. 'FROM pas '
				. 'WHERE id = ? ',
			Bind  => [ \$Param{PaSID} ],
			Limit => 1,
		);

		# fetch the result
		while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
			$PaSData{PaSID}		   = $Row[0];
			$PaSData{PaSNumber}	   = $Row[1];
			$PaSData{CreateTime}   = $Row[2];
			$PaSData{CreateBy}	   = $Row[3];
			$PaSData{ChangeTime}   = $Row[4];
			$PaSData{ChangeBy}	   = $Row[5];
			$PaSData{SLAID}	  	   = $Row[6];
			$PaSData{PaSTitle}	  = $Row[7];
		
			
		}

		# check error
		if ( !%PaSData ) {
			if ( !$Param{LogNo} ) {
				$Kernel::OM->Get('Kernel::System::Log')->Log(
					Priority => 'error',
					Message  => "PaS with ID $Param{PaSID} does not exist.",
				);
			}
			return;
		}

	

		# get all dynamic fields for the object type ITSMChange
		my $DynamicFieldList = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
			ObjectType => 'PaS',
		);

		DYNAMICFIELD:
		for my $DynamicFieldConfig ( @{$DynamicFieldList} ) {

			# validate each dynamic field
			next DYNAMICFIELD if !$DynamicFieldConfig;
	#		next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
			next DYNAMICFIELD if !$DynamicFieldConfig->{Name};
	#		next DYNAMICFIELD if !IsHashRefWithData( $DynamicFieldConfig->{Config} );

			# get the current value for each dynamic field
			my $Value = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->ValueGet(
				DynamicFieldConfig => $DynamicFieldConfig,
				ObjectID		   => $Param{PaSID},
			);

			# set the dynamic field name and value into the change data hash
			$PaSData{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = $Value // '';
		}
	return \%PaSData;
}

sub PaSsGet{
	
	
    my ( $Self, %Param ) = @_;

 

    # check needed stuff
    if ( !$Param{PaSID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need  PaSID!"
        );
        return;
    }

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    SOURCE:
    for my $Count ( '', 1 .. 10 ) {

        next SOURCE if !$Self->{"PaS$Count"};

    
        my %PaS = $Self->{"PaS$Count"}->PaSGet( %Param, );
        next SOURCE if !%PaS;
        # get all dynamic fields for the object type PaS
		my $DynamicFieldList = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
			ObjectType => 'PaS',
		);

		DYNAMICFIELD:
		for my $DynamicFieldConfig ( @{$DynamicFieldList} ) {

			# validate each dynamic field
			next DYNAMICFIELD if !$DynamicFieldConfig;
			next DYNAMICFIELD if !$DynamicFieldConfig->{Name};


			# get the current value for each dynamic field
			my $Value = $Kernel::OM->Get('Kernel::System::DynamicField::Backend')->ValueGet(
				DynamicFieldConfig => $DynamicFieldConfig,
				ObjectID		   => $Param{PaSID},
			);

			# set the dynamic field name and value into the Product data hash
			$PaS{ 'DynamicField_' . $DynamicFieldConfig->{Name} } = $Value // '';
		}
        # return Product data
        return (
            %PaS,
            Source => "PaS$Count",
            Config => $ConfigObject->Get("PaS$Count"),
        );
    }
    return;
	
}

sub PaSDelete {
    my ( $Self, %Param ) = @_;

    # check needed stuff
#    for my $Argument (qw(PaSID UserID)) {
#        if ( !$Param{$Argument} ) {
#            $Kernel::OM->Get('Kernel::System::Log')->Log(
#                Priority => 'error',
#                Message  => "Need $Argument!",
#            );
#
#            return;
#        }
#    }

 
    # delete article
    return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL  => 'DELETE FROM pas WHERE id = ?',
        Bind => [ \$Param{PaSID} ],
    );


    # delete cache
#      my $PaSCacheclear = $Self->{ $Param{Source} }->_PaSCacheClear(
#        %Param,
#		PaSID => $Param{PaSID},
#	);

    return 1;
}

sub UserPaSAdd {
    my ( $Self, %Param ) = @_;
	my %Data = $Self->PaSsGet( PaSID => $Param{PaSID} );
		
    my $message = "";
    
    my $productquestions = "";
    


    my @exclude = qw(Action FormID PaSID Subaction UserID PaSRefNo ChallengeToken checkboxname subtotal);
	for my $key (  keys %Param ) {
		if ( $key ~~ @exclude ) {
			next;
		} else {
			my $label;
			$label = $key;
			if($key =~ /^Vendor Email.*/){
				$label = $key;
				$label =~ s/Vendor/YTL HR\/ Vendor/ig;
			}
			if($key =~ /^Vendor Name.*/){
				$label = $key;
				$label =~ s/Vendor/YTL HR\/ Vendor/ig;
			}
			
			$productquestions .= "<p>".$label." : ".$Param{$key} . " </p>";
		}
	}

	# Compose the Article body
	my $body .=$message;
	$body .= $productquestions;
	

	# check for duplicate
	my $exists = $Self->UserPaSCheckExisting(
		PaSID => $Param{PaSID},
		UserID => $Param{UserID},
	);
		
   if ( 0 eq $exists ) {

		    return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
		        SQL => 'INSERT INTO user_product_cart (user_id,pas_id,order_details,checkout_info, quantity, subtotal)
		            VALUES ( ?, ?, ?, ?, ?, ?)',
		        Bind => [
		         \$Param{UserID},\$Param{PaSID},\$body,\$Param{PaSID}, \$Param{quantity}, \$Param{subtotal}
		        ],
		    );     		
   }    
       
}


sub UserPaSCheckExisting {
	my ( $Self, %Param ) = @_;

		# get data from database
		return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
			SQL => 'SELECT distinct pas_id '
				. 'FROM user_product_cart '
				. 'WHERE user_id = ? AND pas_id = ? ',
			Bind  => [ \$Param{UserID}, \$Param{PaSID} ],
		);
		
		my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray();
	
		if(!@Row){
        	return 0;			
		} else {
			return 1;
		}
}

sub PaS_SLAList{
	
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!'
        );
        return;
    }

    # set valid param
    if ( !defined $Param{Valid} ) {
        $Param{Valid} = 1;
    }

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # add ServiceID
    my %SQLTable;
    $SQLTable{sla} = 'sla s';
    my @SQLWhere;
    

    # add valid part
    if ( $Param{Valid} ) {

        # get valid object
        my $ValidObject = $Kernel::OM->Get('Kernel::System::Valid');

        # create the valid list
        my $ValidIDs = join ', ', $ValidObject->ValidIDsGet();

        push @SQLWhere, "s.name LIKE '%PaS%' ";
    }

    # create the table and where strings
    my $TableString = join q{, }, values %SQLTable;
    my $WhereString = @SQLWhere ? ' WHERE ' . join q{ AND }, @SQLWhere : '';

    # ask database
    $DBObject->Prepare(
        SQL => "SELECT s.id, s.name FROM $TableString $WhereString",
    );

    # fetch the result
    my %SLAList;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $SLAList{SlaID} = $Row[0];
        $SLAList{SlaName} = $Row[1];
       
    }
	
    return %SLAList;
	
}

sub ShowCustomerCart {
	my ( $Self, %Param ) = @_;

	# get all products/services for customer
	return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
		SQL => 'SELECT distinct pas_id '
			. 'FROM user_product_cart '
			. 'WHERE user_id = ? ',
		Bind  => [ \$Self->{UserID} ],
	); 

    my %DataPaS;
    my @PaSID;	
	while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
		push @PaSID, $Row[0];	
	}	

	for my $key ( @PaSID ) {
		
		my %Data = $Self->PaSsGet( PaSID => $key );
		my %Attachments = $Self->PaSAttachmentList( PaSID => $key);
		
		for my $key ( keys %Attachments ) {
			$Data{Filename} = $key;
		}
		
		# get all products/services for customer
		return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
			SQL => 'SELECT quantity, subtotal '
				. 'FROM user_product_cart '
				. 'WHERE pas_id = ? ',
			Bind  => [ \$key ],
		); 			

		while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
			$Data{quantity} = $Row[0];
			$Data{subtotal} = $Row[1];
		}
	
#			$LayoutObject->Block(
#				Name => 'ShoppingCartMenu',
#				Data => \%Data,
#			);

	}

}

sub DoorAccessUserPaSAdd {
    my ( $Self, %Param ) = @_;
	my %Data = $Self->PaSsGet( PaSID => $Param{PaSID} );
		
    my $message = "";
    
    my $productquestions = "";
    


    my @exclude = qw(Action FormID PaSID Subaction UserID PaSRefNo ChallengeToken checkboxname subtotal);
	my @Door_Access_Fields=("Onboarding Request Number","Employee Name","Email ID","Engagement Type",'Designation','Bussiness Phone','Department','HOD Name','Date Of Joining','Date Of Birth',"Staff ID","Company Name","Street","State","Zip","City","IC or Passport Number","Access Card Issuance","From Duration","To Duration");

for my $i (0 .. $#Door_Access_Fields) {
	
			
			$productquestions .= "<p>".$Door_Access_Fields[$i]." : ".$Param{$Door_Access_Fields[$i]} . " </p>";
		
	}

	# Compose the Article body
	my $body .=$message;
	$body .= $productquestions;
	

	# check for duplicate
	my $exists = $Self->UserPaSCheckExisting(
		PaSID => $Param{PaSID},
		UserID => $Param{UserID},
	);
		
   if ( 0 eq $exists ) {

		    return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
		        SQL => 'INSERT INTO user_product_cart (user_id,pas_id,order_details,checkout_info, quantity, subtotal)
		            VALUES ( ?, ?, ?, ?, ?, ?)',
		        Bind => [
		         \$Param{UserID},\$Param{PaSID},\$body,\$Param{PaSID}, \$Param{quantity}, \$Param{subtotal}
		        ],
		    );     		
   }    
       
}

sub SharedSpaceResourceFormUserPaSAdd {
    my ( $Self, %Param ) = @_;
	my %Data = $Self->PaSsGet( PaSID => $Param{PaSID} );
		
    my $message = "";
    
    my $productquestions = "";
    


    my @exclude = qw(Action FormID PaSID Subaction UserID PaSRefNo ChallengeToken checkboxname subtotal);
my @Door_Access_Fields;

if ($Param{'Access Card Issuance'} eq 'Temporary')
{

@Door_Access_Fields=("Full Name","Email ID","Street","City","State","Zip","IC or Passport No","Staff ID","Company Name","Date of Joining","Office Space","Sub-Contractors","Contact number","HOD","Department","Designation","Birthdate","Access Card Issuance","checkboxname","From Duration","To Duration");

}
else{
@Door_Access_Fields=("Full Name","Email ID","Street","City","State","Zip","IC or Passport No","Staff ID","Company Name","Date of Joining","Office Space","Sub-Contractors","Contact number","HOD","Department","Designation","Birthdate","Access Card Issuance","checkboxname");

}

for my $i (0 .. $#Door_Access_Fields) {
	
			if ($Door_Access_Fields[$i] eq 'checkboxname')
			{
				my $office_pre='Office Premise';
							$productquestions .= "<p>".$office_pre." : ".$Param{$Door_Access_Fields[$i]} . " </p>";

			} 
			else{
							$productquestions .= "<p>".$Door_Access_Fields[$i]." : ".$Param{$Door_Access_Fields[$i]} . " </p>";

			}
		
	}

	# Compose the Article body
	my $body .=$message;
	$body .= $productquestions;
	

	# check for duplicate
	my $exists = $Self->UserPaSCheckExisting(
		PaSID => $Param{PaSID},
		UserID => $Param{UserID},
	);
		
   if ( 0 eq $exists ) {

		    return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
		        SQL => 'INSERT INTO user_product_cart (user_id,pas_id,order_details,checkout_info, quantity, subtotal)
		            VALUES ( ?, ?, ?, ?, ?, ?)',
		        Bind => [
		         \$Param{UserID},\$Param{PaSID},\$body,\$Param{PaSID}, \$Param{quantity}, \$Param{subtotal}
		        ],
		    );     		
   }    
       
}

1;
