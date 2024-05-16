# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaSFieldAdd;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

sub new {
	my ( $Type, %Param ) = @_;

	# allocate new hash for object
	my $Self = {%Param};
	bless( $Self, $Type );

	return $Self;
}

sub Run {
	my ( $Self, %Param ) = @_;

	# get needed objects
	my $ProductObject = $Kernel::OM->Get('Kernel::System::Question');
	my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

	# get config of frontend module
	$Self->{Config} = $ConfigObject->Get("Question::Frontend::$Self->{Action}");

	
	# get layout object
	my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

	
	
	# get param object
	my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');
	
	
	my $PaSID = $ParamObject->GetParam( Param => 'PaSID' );

	
	# store needed parameters in %GetParam to make it reloadable
	my %GetParam;
	for my $ParamName (
		qw(QuestionID PaSID)
		)
	{
		$GetParam{$ParamName} = $ParamObject->GetParam( Param => $ParamName );
	}

	# get dynamic fields from ParamObject
	my %DynamicFieldValues;

	# get the dynamic fields for this screen
	my $DynamicField = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
		Valid	   => 1,
		ObjectType  => 'Question',
		FieldFilter => $Self->{Config}->{DynamicField} || {},
	);

	# get dynamic field backend object
	my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

	# cycle trough the activated Dynamic Fields for this screen
	DYNAMICFIELD:
	for my $DynamicFieldConfig ( @{$DynamicField} ) {
	#	next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

		# extract the dynamic field value from the web request and add the prefix
		$DynamicFieldValues{ 'DynamicField_' . $DynamicFieldConfig->{Name} }
			= $DynamicFieldBackendObject->EditFieldValueGet(
			DynamicFieldConfig => $DynamicFieldConfig,
			ParamObject		=> $ParamObject,
			LayoutObject	   => $LayoutObject,
			);
	}


	# get upload cache object
	my $UploadCacheObject = $Kernel::OM->Get('Kernel::System::Web::UploadCache');
	

	# get form id
	$Self->{FormID} = $ParamObject->GetParam( Param => 'FormID' );

	# create form id
	if ( !$Self->{FormID} ) {
		$Self->{FormID} = $UploadCacheObject->FormIDCreate();
	}

	# get log object
	my $LogObject = $Kernel::OM->Get('Kernel::System::Log');

	# Remember the reason why saving was not attempted.
	my %ValidationError;

	# the TicketID can be validated even without the Subaction 'Save',
	# as it is passed as GET-param or in a hidden field.
	

	# perform the adding
	if ( $Self->{Subaction} eq 'Save' ) {
		
	$LayoutObject->ChallengeTokenCheck();
	
	# cycle trough the activated Dynamic Fields for this screen
		DYNAMICFIELD:
		for my $DynamicFieldConfig ( @{$DynamicField} ) {
			next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

			my $ValidationResult = $DynamicFieldBackendObject->EditFieldValueValidate(
				DynamicFieldConfig => $DynamicFieldConfig,
				ParamObject		=> $ParamObject,
				Mandatory		  => $Self->{Config}->{DynamicField}->{ $DynamicFieldConfig->{Name} } == 2,
			);

			if ( !IsHashRefWithData($ValidationResult) ) {
				return $LayoutObject->ErrorScreen(
					Message =>
						"Could not perform validation on field $DynamicFieldConfig->{Label}!",
					Comment => 'Please contact the admin.',
				);
			}
		}
		
				
				my $QuestionID = $ProductObject->QuestionAdd(
				QuestionNumber	=> $ParamObject->GetParam( Param => 'SelectedQuestionRefNo' ),
				PaSID		=> $PaSID, 
				UserID		=> $Self->{UserID},
				%DynamicFieldValues,
			);
	
	
			if ($QuestionID) {
				
				$Kernel::OM->Get('Kernel::System::LinkObject')->LinkAdd(
											SourceObject	=> 'PaS',
											SourceKey		=> $PaSID,
											TargetObject	=> 'Question',
											TargetKey		=> $QuestionID,
											Type			=> 'Normal',
											State			=> 'Valid',
											UserID			=> $Self->{UserID},
										);
				
				
					return $LayoutObject->Redirect(
					OP => "Action=AgentPaSFieldZoom;QuestionID=$QuestionID;PaSID=$PaSID",
				);
					}
					else {
						$LogObject->Log(
							Priority => 'error',
							Message  => 'Cannot add',
						);
					}
				
	}
	# handle AJAXUpdate
	elsif ( $Self->{Subaction} eq 'AJAXUpdate' ) {

		

	my @TemplateAJAX = ();
	my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
	my $strPrefix			= '';
	my $strNewProductNumber	= '';
	$strPrefix = 'QU';
	$strNewProductNumber = $strPrefix . $TicketObject->TicketCreateNumber();
		
			@TemplateAJAX = (
				{
					Name => 'SelectedQuestionRefNo',
					Data => $strNewProductNumber,
				},
				{
					Name => 'QuestionRefNo',
					Data => $strNewProductNumber,
				},
			);
		
		
		# build json
		my $JSON = $LayoutObject->BuildSelectionJSON(
			[ 
				@TemplateAJAX
			],
		);

		# return json
		return $LayoutObject->Attachment(
			ContentType => 'text/plain; charset=' . $LayoutObject->{Charset},
			Content	 => $JSON,
			Type		=> 'inline',
			NoCache	 => 1,
		);
	}

	

	# output header
	my $Output = $LayoutObject->Header(
		Title => 'Add',
	);
	$Output .= $LayoutObject->NavigationBar();

	

	# cycle trough the activated Dynamic Fields for this screen
	DYNAMICFIELD:
	for my $DynamicFieldConfig ( @{$DynamicField} ) {

	next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

	# get dynamic fields defaults if page is loaded the first time
	if ( !$Self->{Subaction} ) {
		$DynamicFieldValues{ 'DynamicField_' . $DynamicFieldConfig->{Name} }
			= $DynamicFieldConfig->{Config}->{DefaultValue} || '';
	}

	# get field html
	my $DynamicFieldHTML = $DynamicFieldBackendObject->EditFieldRender(
		DynamicFieldConfig => $DynamicFieldConfig,
		Value			  => $DynamicFieldValues{ 'DynamicField_' . $DynamicFieldConfig->{Name} },
		ServerError		=> $ValidationError{ $DynamicFieldConfig->{Name} } || '',
		Mandatory		  => $Self->{Config}->{DynamicField}->{ $DynamicFieldConfig->{Name} } == 2,
		LayoutObject	   => $LayoutObject,
		ParamObject		=> $ParamObject,
		AJAXUpdate		 => 0,
	);

	# skip fields that HTML could not be retrieved
	next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldHTML);

	$LayoutObject->Block(
		Name => 'DynamicField',
		Data => {
			Name  => $DynamicFieldConfig->{Name},
			Label => $DynamicFieldHTML->{Label},
			Field => $DynamicFieldHTML->{Field},
		},
	);

	# example of dynamic fields order customization
	$LayoutObject->Block(
		Name => 'DynamicField_' . $DynamicFieldConfig->{Name},
		Data => {
			Name  => $DynamicFieldConfig->{Name},
			Label => $DynamicFieldHTML->{Label},
			Field => $DynamicFieldHTML->{Field},
		},
	);
}

	# add rich text editor javascript
	# only if activated and the browser can handle it
	# otherwise just a textarea is shown
	if ( $LayoutObject->{BrowserRichText} ) {
		$LayoutObject->Block(
			Name => 'RichText',
			Data => {%Param},
		);
	}

	# start template output
	$Output .= $LayoutObject->Output(
		TemplateFile => 'AgentPaSFieldAdd',
		Data		 => {
			%Param,
			%GetParam,
			%ValidationError,
			FormID => $Self->{FormID},
		},
	);

	# add footer
	$Output .= $LayoutObject->Footer();

	return $Output;
}

1;
