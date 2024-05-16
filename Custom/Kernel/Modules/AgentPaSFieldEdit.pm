# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaSFieldEdit;

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

	# get param object
	my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

	# get needed QuestionID
	my $QuestionID = $ParamObject->GetParam( Param => 'QuestionID' );
	my $PaSID = $ParamObject->GetParam( Param => 'PaSID' );

	
	# get layout object
	my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

	my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
	# check needed stuff
	if ( !$QuestionID ) {
		return $LayoutObject->ErrorScreen(
			Message => 'No QuestionID is given!',
			Comment => 'Please contact the admin.',
		);
	}
#if ( !$PasID ) {
#		return $LayoutObject->ErrorScreen(
#			Message => 'No PaSID is given!',
#			Comment => 'Please contact the admin.',
#		);
#	}
	# get config object
	my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

	# get config of frontend module
	$Self->{Config} = $ConfigObject->Get("Questions::Frontend::$Self->{Action}");

	# get Question object
	my $QuestionObject = $Kernel::OM->Get('Kernel::System::Question');


	# get Question data
	my $Question = $QuestionObject->QuestionGet(
		QuestionID => $QuestionID,
		UserID   => $Self->{UserID},
	);
  
	# check if Question is found
	if ( !$Question ) {
		return $LayoutObject->ErrorScreen(
			Message => "Question '$QuestionID' not found in database!",
			Comment => 'Please contact the admin.',
		);
	}
	

	# store needed parameters in %GetParam to make this page reloadable

	my %GetParam;
	for my $ParamName (
		qw(
		QuestionID PaSID
		
		)
		)
	{
		$GetParam{$ParamName} = $ParamObject->GetParam( Param => $ParamName );
	}


	# get Dynamic fields from ParamObject
	my %DynamicFieldValues;

	# get the dynamic fields for this screen
	 my $DynamicField = $DynamicFieldObject->DynamicFieldListGet(
	Valid      => 1,
	ObjectType  => [ 'Question' ],
	FieldFilter => $ConfigObject->Get("Question::Frontend::$Self->{Action}")->{DynamicField} || {},
    );

	# get dynamic field backend object
#	my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

	# cycle trough the activated Dynamic Fields for this screen
	DYNAMICFIELD:
	for my $DynamicFieldConfig ( @{$DynamicField} ) {
	
	# extract the dynamic field value from the web request and add the prefix
		$DynamicFieldValues{ 'DynamicField_' . $DynamicFieldConfig->{Name} }
			= $DynamicFieldBackendObject->EditFieldValueGet(
			DynamicFieldConfig => $DynamicFieldConfig,
			ParamObject		=> $ParamObject,
			LayoutObject	   => $LayoutObject,
			);
	}



	# Remember the reason why performing the subaction was not attempted.
	my %ValidationError;

	# get upload cache object
	my $UploadCacheObject = $Kernel::OM->Get('Kernel::System::Web::UploadCache');

	# get form id
	$Self->{FormID} = $ParamObject->GetParam( Param => 'FormID' );

	# create form id
	if ( !$Self->{FormID} ) {
		$Self->{FormID} = $UploadCacheObject->FormIDCreate();
	}

	# get time object
	my $TimeObject = $Kernel::OM->Get('Kernel::System::Time');

	# update Question
	if ( $Self->{Subaction} eq 'Save' ) {

		# cycle trough the activated Dynamic Fields for this screen
		DYNAMICFIELD:
		for my $DynamicFieldConfig ( @{$DynamicField} ) {
			next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

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

#		# check if an attachment must be deleted
#		ATTACHMENT:
#		for my $Number ( 1 .. 32 ) {
#
#			# check if the delete button was pressed for this attachment
#			my $Delete = $ParamObject->GetParam( Param => "AttachmentDelete$Number" );
#
#			# check next attachment if it was not pressed
#			next ATTACHMENT if !$Delete;
#
#			# remember that we need to show the page again
#			$ValidationError{Attachment} = 1;
#
#			# remove the attachment from the upload cache
#			$UploadCacheObject->FormIDRemoveFile(
#				FormID => $Self->{FormID},
#				FileID => $Number,
#			);
#		}

		# check if there was an attachment upload
#		if ( $GetParam{AttachmentUpload} ) {
#
#			# remember that we need to show the page again
#			$ValidationError{Attachment} = 1;
#
#			# get the uploaded attachment
#			my %UploadStuff = $ParamObject->GetUploadAll(
#				Param  => 'FileUpload',
#				Source => 'string',
#			);
#
#			# add attachment to the upload cache
#			$UploadCacheObject->FormIDAddFile(
#				FormID => $Self->{FormID},
#				%UploadStuff,
#			);
#		}

		# update only when there are no input validation errors
		if ( !%ValidationError ) {

			# setting of Question state and requested time is configurable
			my %AdditionalParam;
			
			# update the Question
			my $CouldUpdateQuestion = $QuestionObject->QuestionUpdate(
				QuestionID	  => $QuestionID,
				UserID => $Self->{UserID},				
				%DynamicFieldValues,
			);
			
#		    my $CouldUpdateQuestionHistory = $QuestionObject->QuestionHistoryAdd(
#				QuestionID	  => $QuestionID,
#				UserID => $Self->{UserID},
#				Name => 'Question Updated',				
#				%DynamicFieldValues,
#			);
			
			# update was successful
			if ($CouldUpdateQuestion) {

				# get all attachments from upload cache
#				my @Attachments = $UploadCacheObject->FormIDGetAllFilesData(
#					FormID => $Self->{FormID},
#				);

				# build a lookup lookup hash of the new attachments
#				my %NewAttachment;
#				for my $Attachment (@Attachments) {
#
#					# the key is the filename + filesize + content type
#					my $Key = $Attachment->{Filename}
#						. $Attachment->{Filesize}
#						. $Attachment->{ContentType};
#
#					# append content id if available (for new inline images)
#					if ( $Attachment->{ContentID} ) {
#						$Key .= $Attachment->{ContentID};
#					}
#
#					# store all of the new attachment data
#					$NewAttachment{$Key} = $Attachment;
#				}

				# get all attachments meta data
#				my @ExistingAttachments = $QuestionObject->QuestionAttachmentList(
#					QuestionID => $QuestionID,
#				);

				# check the existing attachments
				FILENAME:
#				for my $Filename (@ExistingAttachments) {
#
#					# get the existing attachment data
#					my $AttachmentData = $QuestionObject->QuestionAttachmentGet(
#						QuestionID => $QuestionID,
#						Filename => $Filename,
#						UserID   => $Self->{UserID},
#					);
#
#					# do not consider inline attachments
#					next FILENAME if $AttachmentData->{Preferences}->{ContentID};
#
#					# the key is the filename + filesize + content type
#					# (no content id, as existing attachments don't have it)
#					my $Key = $AttachmentData->{Filename}
#						. $AttachmentData->{Filesize}
#						. $AttachmentData->{ContentType};
#
#					# attachment is already existing, we can delete it from the new attachment hash
#					if ( $NewAttachment{$Key} ) {
#						delete $NewAttachment{$Key};
#					}
#
#					# existing attachment is no longer in new attachments hash
#					else {
#
#						# delete the existing attachment
#						my $DeleteSuccessful = $QuestionObject->QuestionAttachmentDelete(
#							QuestionID => $QuestionID,
#							Filename => $Filename,
#							UserID   => $Self->{UserID},
#						);
#
#						# check error
#						if ( !$DeleteSuccessful ) {
#							return $LayoutObject->FatalError();
#						}
#					}
#				}

				# write the new attachments
#				ATTACHMENT:
#				for my $Attachment ( values %NewAttachment ) {
#
#					# check if attachment is an inline attachment
#					my $Inline = 0;
#					if ( $Attachment->{ContentID} ) {
#
#						# remember that it is inline
#						$Inline = 1;
#
#						# remember if this inline attachment is used in
#						# the Question description or justification
#						my $ContentIDFound;
#
#						
#						# we do not want to keep this attachment,
#						# because it was deleted in the richt text editor
#						next ATTACHMENT if !$ContentIDFound;
#					}
#
#					# add attachment
#					my $Success = $QuestionObject->QuestionAttachmentAdd(
#						%{$Attachment},
#						QuestionID => $QuestionID,
#						UserID   => $Self->{UserID},
#					);
#
#					# check error
#					if ( !$Success ) {
#						return $LayoutObject->FatalError();
#					}
#
#					next ATTACHMENT if !$Inline;
#					next ATTACHMENT if !$LayoutObject->{BrowserRichText};
#
#					# picture url in upload cache
#					my $Search = "Action=PictureUpload .+ FormID=$Self->{FormID} .+ "
#						. "ContentID=$Attachment->{ContentID}";
#
#					# picture url in Question atttachment
#					my $Replace = "Action=AgentQuestionZoom;Subaction=DownloadAttachment;"
#						. "Filename=$Attachment->{Filename};QuestionID=$QuestionID";
#
#					# replace urls
#					$GetParam{Description} =~ s{$Search}{$Replace}xms;
#					$GetParam{Justification} =~ s{$Search}{$Replace}xms;
#
#					# update Question
#					$Success = $QuestionObject->QuestionUpdate(
#						QuestionID	  => $QuestionID,
#						Description   => $GetParam{Description},
#						Justification => $GetParam{Justification},
#						UserID		=> $Self->{UserID},
#					);
#
#					# check error
#					if ( !$Success ) {
#						$Kernel::OM->Get('Kernel::System::Log')->Log(
#							Priority => 'error',
#							Message  => "Could not update the inline image URLs "
#								. "for QuestionID '$QuestionID'!!",
#						);
#					}
#				}

				# delete the upload cache
				$UploadCacheObject->FormIDRemove( FormID => $Self->{FormID} );

				# load new URL in parent window and close popup
				return $LayoutObject->PopupClose(
					URL => "Action=AgentPaSFieldZoom;QuestionID=$QuestionID;PaSID=$PaSID",
				);

			}
			else {

				# show error message
				return $LayoutObject->ErrorScreen(
					Message => "Was not able to update Question $QuestionID!",
					Comment => 'Please contact the admin.',
				);
			}
		}
	}

	# handle AJAXUpdate
	elsif ( $Self->{Subaction} eq 'AJAXUpdate' ) {
	
	my $QuestionID = $ParamObject->GetParam( Param => 'QuestionID' );
	my @TemplateAJAX;
	
	   @TemplateAJAX = (
				{
				  Name => 'QuestionID',
				  Data => $QuestionID,
				 },
		     );
		

		# Customization by Swapnil End

		my $JSON = $LayoutObject->BuildSelectionJSON();
		return $LayoutObject->Attachment(
			ContentType => 'application/json; charset=' . $LayoutObject->{Charset},
			Content	 => $JSON,
			Type		=> 'inline',
			NoCache	 => 1,
		);
	}

	# delete all keys from %GetParam when it is no Subaction
	else {

		%GetParam = ();
	#	get all attachments meta data
#		my @ExistingAttachments = $QuestionObject->QuestionAttachmentList(
#			QuestionID => $QuestionID,
#		);

		# copy all existing attachments to upload cache
		FILENAME:
#		for my $Filename (@ExistingAttachments) {
#
#			# get the existing attachment data
#			my $AttachmentData = $QuestionObject->QuestionAttachmentGet(
#				QuestionID => $QuestionID,
#				Filename => $Filename,
#				UserID   => $Self->{UserID},
#			);
#
#			# do not consider inline attachments
#			next FILENAME if $AttachmentData->{Preferences}->{ContentID};
#
#			# add attachment to the upload cache
#			$UploadCacheObject->FormIDAddFile(
#				FormID	  => $Self->{FormID},
#				Filename	=> $AttachmentData->{Filename},
#				Content	 => $AttachmentData->{Content},
#				ContentType => $AttachmentData->{ContentType},
#			);
#		}
	}

#	 if there was an attachment delete or upload
	# we do not want to show validation errors for other fields
#	if ( $ValidationError{Attachment} ) {
#		%ValidationError = ();
#	}


	# output header
	my $Output = $LayoutObject->Header(
		Title => 'Edit',
		Type  => 'Small',
	);

	# cycle trough the activated Dynamic Fields for this screen
	DYNAMICFIELD:
	for my $DynamicFieldConfig ( @{$DynamicField} ) {

		# get Question dynamic fields from Question if page is loaded the first time
		if ( !$Self->{Subaction} ) {
			$DynamicFieldValues{ 'DynamicField_' . $DynamicFieldConfig->{Name} }
				= $Question->{ 'DynamicField_' . $DynamicFieldConfig->{Name} };
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
#	$LayoutObject->Block(
#		Name => 'AttachmentUpload',
#		Data => {%Param},
#	);

	# get all attachments meta data
#	my @Attachments = $UploadCacheObject->FormIDGetAllFilesMeta(
#		FormID => $Self->{FormID},
#	);

	# show attachments
	ATTACHMENT:
#	for my $Attachment (@Attachments) {
#
#		# do not show inline images as attachments
#		# (they have a content id)
#		if ( $Attachment->{ContentID} && $LayoutObject->{BrowserRichText} ) {
#			next ATTACHMENT;
#		}
#
#		$LayoutObject->Block(
#			Name => 'Attachment',
#			Data => $Attachment,
#		);
#	}

	# add rich text editor javascript
	# only if activated and the browser can handle it
	# otherwise just a textarea is shown
#	if ( $LayoutObject->{BrowserRichText} ) {
#		$LayoutObject->Block(
#			Name => 'RichText',
#			Data => {%Param},
#		);
#	}
	$GetParam{PaSID} = $PaSID;
			
	# start template output
	$Output .= $LayoutObject->Output(
		TemplateFile => 'AgentPaSFieldEdit',
		Data		 => {
			%Param,
			%{$Question},
			%GetParam,
			%ValidationError,
			FormID => $Self->{FormID},

		},
	);

	# add footer
	$Output .= $LayoutObject->Footer( Type => 'Small' );

	return $Output;
}

1;
