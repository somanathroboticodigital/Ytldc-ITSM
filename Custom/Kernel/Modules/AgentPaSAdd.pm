# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaSAdd;

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
	my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');
	my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

	# get config of frontend module
	$Self->{Config} = $ConfigObject->Get("PaS::Frontend::$Self->{Action}");

	
	# get layout object
	my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');


	# get param object
	my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

	# store needed parameters in %GetParam to make it reloadable
	my %GetParam;
	for my $ParamName (
		qw(PaSID PaSTitle AttachmentUpload FileID)
		)
	{
		$GetParam{$ParamName} = $ParamObject->GetParam( Param => $ParamName );
	}

	# get dynamic fields from ParamObject
	my %DynamicFieldValues;

	# get the dynamic fields for this screen
	my $DynamicField = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldListGet(
		Valid	   => 1,
		ObjectType  => 'PaS',
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

		# challenge token check for write action
		$LayoutObject->ChallengeTokenCheck();
		
		
		
		
		# cycle trough the activated Dynamic Fields for this screen
		DYNAMICFIELD:
		for my $DynamicFieldConfig ( @{$DynamicField} ) {
		#	next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

			my $ValidationResult = $DynamicFieldBackendObject->EditFieldValueValidate(
				DynamicFieldConfig => $DynamicFieldConfig,
				ParamObject		=> $ParamObject,
				Mandatory		  => $Self->{Config}->{DynamicField}->{ $DynamicFieldConfig->{Name} } == 2,
			);

			# propagate validation error to the Error variable to be detected by the frontend
			if ( $ValidationResult->{ServerError} ) {
				$ValidationError{ $DynamicFieldConfig->{Name} } = ' ServerError';
			}
		}

		# check if an attachment must be deleted
		ATTACHMENT:
		for my $Number ( 1 .. 32 ) {

			# check if the delete button was pressed for this attachment
			my $Delete = $ParamObject->GetParam( Param => "AttachmentDelete$Number" );

			# check next attachment if it was not pressed
			next ATTACHMENT if !$Delete;

			# remember that we need to show the page again
			$ValidationError{Attachment} = 1;

			# remove the attachment from the upload cache
			$UploadCacheObject->FormIDRemoveFile(
				FormID => $Self->{FormID},
				FileID => $Number,
			);
		}
    
     
		# check if there was an attachment upload
		if ( $GetParam{AttachmentUpload} ) {

			# remember that we need to show the page again
			$ValidationError{Attachment} = 1;

			# get the uploaded attachment
			my %UploadStuff = $ParamObject->GetUploadAll(
				Param  => 'FileUpload',
				Source => 'string',
			);

			# add attachment to the upload cache
			$UploadCacheObject->FormIDAddFile(
				FormID => $Self->{FormID},
				%UploadStuff,
			);
		}

	
		

		# add only when there are no input validation errors
		if ( !%ValidationError ) {

			my %AdditionalParam;

			# add requested time if configured
			if ( $Self->{Config}->{RequestedTime} ) {
				$AdditionalParam{RequestedTime} = $GetParam{RequestedTime};
			}
         $GetParam{SLAID} = $ParamObject->GetParam( Param => 'SLAID' );
         $GetParam{PaSTitle} = $ParamObject->GetParam( Param => 'PaSTitle' );
        
         
		    # create the product
			my $PaSID = $PaSObject->PaSAdd(
				PaSNumber	=> $ParamObject->GetParam( Param => 'SelectedPaSRefNo'), 
				SLAID		=> $GetParam{SLAID},
				PaSTitle		=> $GetParam{PaSTitle},
				UserID		=> $Self->{UserID},
				%AdditionalParam,
				%DynamicFieldValues,
			 );
        #  open(TT, '>', '/tmp/SAL.log');
        # use Data::Dumper;
        # print TT Dumper(\%GetParam);
        # close(TT);

      
          
			# adding was successful
			if ($PaSID) {

				# move attachments from cache to virtual fs
				my @CachedAttachments = $UploadCacheObject->FormIDGetAllFilesData(
					FormID => $Self->{FormID},
				);

				for my $CachedAttachment (@CachedAttachments) {
					my $Success = $PaSObject->PaSAttachmentAdd(
						%{$CachedAttachment},
						PaSID => $PaSID,
						UserID   => $Self->{UserID},
					);

					# delete file from cache if move was successful
					if ($Success) {

						# rewrite URL for inline images
						if ( $CachedAttachment->{ContentID} ) {

							# get the PaS data
							my $PaSData = $PaSObject->PaSGet(
								PaSID => $PaSID,
								UserID   => $Self->{UserID},
							);

							# picture url in upload cache
							my $Search = "Action=PictureUpload .+ FormID=$Self->{FormID} .+ "
								. "ContentID=$CachedAttachment->{ContentID}";

							# picture url in PaS atttachment
							my $Replace = "Action=AgentPaSZoom;Subaction=DownloadAttachment;"
								. "Filename=$CachedAttachment->{Filename};PaSID=$PaSID";

							

							# check error
							if ( !$Success ) {
								$LogObject->Log(
									Priority => 'error',
									Message  => "Could not update the inline image URLs "
										. "for PaSID '$PaSID'!",
								);
							}
						}

						$UploadCacheObject->FormIDRemoveFile(
							FormID => $Self->{FormID},
							FileID => $CachedAttachment->{FileID},
						);
					}
					else {
						$LogObject->Log(
							Priority => 'error',
							Message  => 'Cannot move File from Cache to VirtualFS'
								. "(${$CachedAttachment}{Filename})",
						);
					}
				}

				 return $LayoutObject->Redirect(
                    OP => "Action=AgentPaSZoom;PaSID=$PaSID",
                );
			}
			else {

				# show error message, when adding failed
				return $LayoutObject->ErrorScreen(
					Message => 'Was not able to add PaS!',
					Comment => 'Please contact the admin.',
				);
			}
		}
	}

	# handle AJAXUpdate
	elsif ( $Self->{Subaction} eq 'AJAXUpdate' ) {

		

		my @TemplateAJAX = ();
		 my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
		my $strPrefix			= '';
		my $strNewPaSNumber	= '';
		$strPrefix = 'PS';
		$strNewPaSNumber = $strPrefix . $TicketObject->TicketCreateNumber();
			
			@TemplateAJAX = (
				{
					Name => 'SelectedPaSRefNo',
					Data => $strNewPaSNumber,
				},
				{
					Name => 'PaSRefNo',
					Data => $strNewPaSNumber,
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

	# if there was an attachment delete or upload
	# we do not want to show validation errors for other fields
	if ( $ValidationError{Attachment} ) {
		%ValidationError = ();
	}

	# get all attachments meta data
	my @Attachments = $UploadCacheObject->FormIDGetAllFilesMeta(
		FormID => $Self->{FormID},
	);

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

	# show the attachment upload button
	$LayoutObject->Block(
		Name => 'AttachmentUpload',
		Data => {%Param},
	);

	# show attachments
	ATTACHMENT:
	for my $Attachment (@Attachments) {

		# do not show inline images as attachments
		# (they have a content id)
		if ( $Attachment->{ContentID} && $LayoutObject->{BrowserRichText} ) {
			next ATTACHMENT;
		}

		$LayoutObject->Block(
			Name => 'Attachment',
			Data => $Attachment,
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

#	 my $SLAItems = $Kernel::OM->Get('Kernel::System::SLA')->SLAPaSList(
#                              UserID  => $Self->{UserID},
#                            );
      

          my $SLAItems ;
         $GetParam{SLAID}= $SLAItems; 
         $GetParam{SLAIDVALUE} = $ParamObject->GetParam( Param => 'SLAID' );
         $GetParam{PaSTitle}= 'test';
	# start template output
	
	# if( 'Yes' eq  $Self->{'UserIsGroup[admin]'} ){
	$Output .= $LayoutObject->Output(
		TemplateFile => 'AgentPaSAdd',
		Data		 => {
			%Param,
			%GetParam,
			%ValidationError,
			FormID => $Self->{FormID},
		},
	);
# 	}else{
# 		# start template output
   # $Output .= $LayoutObject->Output(
# 		TemplateFile => 'AgentPaSErrorMessage',
# 		Data		 => {
# 			%Param,
# 			%GetParam,
# 			%ValidationError,
# 			FormID => $Self->{FormID},
# 		},
# 	);
# 	}
	# add footer
	$Output .= $LayoutObject->Footer();
		
         
	return $Output;
}

1;
