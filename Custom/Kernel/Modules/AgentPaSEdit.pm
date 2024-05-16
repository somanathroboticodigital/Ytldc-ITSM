# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaSEdit;

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

	# get needed PaSID
	my $PaSID = $ParamObject->GetParam( Param => 'PaSID' );

	# get layout object
	my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

	my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
	# check needed stuff
	if ( !$PaSID ) {
		return $LayoutObject->ErrorScreen(
			Message => 'No PaSID is given!',
			Comment => 'Please contact the admin.',
		);
	}

	# get config object
	my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

	# get config of frontend module
	$Self->{Config} = $ConfigObject->Get("PaS::Frontend::$Self->{Action}");

	# get PaS object
	my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');


	# get PaS data
	my $PaS = $PaSObject->PaSGet(
		PaSID => $PaSID,
		UserID   => $Self->{UserID},
	);
  
	# check if PaS is found
	if ( !$PaS ) {
		return $LayoutObject->ErrorScreen(
			Message => "PaS '$PaSID' not found in database!",
			Comment => 'Please contact the admin.',
		);
	}
	

	# store needed parameters in %GetParam to make this page reloadable

	my %GetParam;
	for my $ParamName (
		qw(
		PaSID 
		AttachmentUpload FileID PaSTitle
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
	ObjectType  => [ 'PaS' ],
	FieldFilter => $ConfigObject->Get("PaS::Frontend::$Self->{Action}")->{DynamicField} || {},
    );

	# get dynamic field backend object
	my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

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

	# update PaS
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

		$GetParam{SLAID} = $ParamObject->GetParam( Param => 'SLAID' );
		$GetParam{PaSTitle} = $ParamObject->GetParam( Param => 'PaSTitle' );
	 

		open(my $Fh, '>', '/tmp/AgentPasEdit.pm.log');
		use Data::Dumper;
		print $Fh Dumper \%ValidationError;
		close($Fh);

		delete $ValidationError{PaSCost};


		# update only when there are no input validation errors
		if ( !%ValidationError ) {

			# setting of PaS state and requested time is configurable
			my %AdditionalParam;
			
			
			
			# update the PaS
			my $CouldUpdatePaS = $PaSObject->PaSUpdate(
				PaSID	  => $PaSID,
				UserID => $Self->{UserID},
				SLAID	  => $GetParam{SLAID},
				PaSTitle => $GetParam{PaSTitle},				
				%DynamicFieldValues,
			);
			
		    my $CouldUpdatePaSHistory = $PaSObject->PaSHistoryAdd(
				PaSID	  => $PaSID,
				UserID => $Self->{UserID},
				Name => 'PaS Updated',				
				%DynamicFieldValues,
			);
			
			# update was successful
			if ($CouldUpdatePaS) {

				# get all attachments from upload cache
				my @Attachments = $UploadCacheObject->FormIDGetAllFilesData(
					FormID => $Self->{FormID},
				);

				# build a lookup lookup hash of the new attachments
				my %NewAttachment;
				for my $Attachment (@Attachments) {

					# the key is the filename + filesize + content type
					my $Key = $Attachment->{Filename}
						. $Attachment->{Filesize}
						. $Attachment->{ContentType};

					# append content id if available (for new inline images)
					if ( $Attachment->{ContentID} ) {
						$Key .= $Attachment->{ContentID};
					}

					# store all of the new attachment data
					$NewAttachment{$Key} = $Attachment;
				}

				# get all attachments meta data
				my @ExistingAttachments = $PaSObject->PaSAttachmentList(
					PaSID => $PaSID,
				);

				# check the existing attachments
				FILENAME:
				for my $Filename (@ExistingAttachments) {

					# get the existing attachment data
					my $AttachmentData = $PaSObject->PaSAttachmentGet(
						PaSID => $PaSID,
						Filename => $Filename,
						UserID   => $Self->{UserID},
					);

					# do not consider inline attachments
					next FILENAME if $AttachmentData->{Preferences}->{ContentID};

					# the key is the filename + filesize + content type
					# (no content id, as existing attachments don't have it)
					my $Key = $AttachmentData->{Filename}
						. $AttachmentData->{Filesize}
						. $AttachmentData->{ContentType};

					# attachment is already existing, we can delete it from the new attachment hash
					if ( $NewAttachment{$Key} ) {
						delete $NewAttachment{$Key};
					}

					# existing attachment is no longer in new attachments hash
					else {

						# delete the existing attachment
						my $DeleteSuccessful = $PaSObject->PaSAttachmentDelete(
							PaSID => $PaSID,
							Filename => $Filename,
							UserID   => $Self->{UserID},
						);

						# check error
						if ( !$DeleteSuccessful ) {
							return $LayoutObject->FatalError();
						}
					}
				}

				# write the new attachments
				ATTACHMENT:
				for my $Attachment ( values %NewAttachment ) {

					# check if attachment is an inline attachment
					my $Inline = 0;
					if ( $Attachment->{ContentID} ) {

						# remember that it is inline
						$Inline = 1;

						# remember if this inline attachment is used in
						# the PaS description or justification
						my $ContentIDFound;

						
						# we do not want to keep this attachment,
						# because it was deleted in the richt text editor
						next ATTACHMENT if !$ContentIDFound;
					}

					# add attachment
					my $Success = $PaSObject->PaSAttachmentAdd(
						%{$Attachment},
						PaSID => $PaSID,
						UserID   => $Self->{UserID},
					);

					# check error
					if ( !$Success ) {
						return $LayoutObject->FatalError();
					}

					next ATTACHMENT if !$Inline;
					next ATTACHMENT if !$LayoutObject->{BrowserRichText};

					# picture url in upload cache
					my $Search = "Action=PictureUpload .+ FormID=$Self->{FormID} .+ "
						. "ContentID=$Attachment->{ContentID}";

					# picture url in PaS atttachment
					my $Replace = "Action=AgentPaSZoom;Subaction=DownloadAttachment;"
						. "Filename=$Attachment->{Filename};PaSID=$PaSID";

					# replace urls
					$GetParam{Description} =~ s{$Search}{$Replace}xms;
					$GetParam{Justification} =~ s{$Search}{$Replace}xms;

					# update PaS
					$Success = $PaSObject->PaSUpdate(
						PaSID	  => $PaSID,
						Description   => $GetParam{Description},
						Justification => $GetParam{Justification},
						UserID		=> $Self->{UserID},
					);

					# check error
					if ( !$Success ) {
						$Kernel::OM->Get('Kernel::System::Log')->Log(
							Priority => 'error',
							Message  => "Could not update the inline image URLs "
								. "for PaSID '$PaSID'!!",
						);
					}
				}

				# delete the upload cache
				$UploadCacheObject->FormIDRemove( FormID => $Self->{FormID} );

				# load new URL in parent window and close popup
				return $LayoutObject->PopupClose(
					URL => "Action=AgentPaSZoom;PaSID=$PaSID",
				);

			}
			else {

				# show error message
				return $LayoutObject->ErrorScreen(
					Message => "Was not able to update PaS $PaSID!",
					Comment => 'Please contact the admin.',
				);
			}
		}
	}

	# handle AJAXUpdate
	elsif ( $Self->{Subaction} eq 'AJAXUpdate' ) {
	
	my $PaSID = $ParamObject->GetParam( Param => 'PaSID' );
	my @TemplateAJAX;
	
	   @TemplateAJAX = (
				{
				  Name => 'PaSID',
				  Data => $PaSID,
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
		my @ExistingAttachments = $PaSObject->PaSAttachmentList(
			PaSID => $PaSID,
		);

		# copy all existing attachments to upload cache
		FILENAME:
		for my $Filename (@ExistingAttachments) {

			# get the existing attachment data
			my $AttachmentData = $PaSObject->PaSAttachmentGet(
				PaSID => $PaSID,
				Filename => $Filename,
				UserID   => $Self->{UserID},
			);

			# do not consider inline attachments
			next FILENAME if $AttachmentData->{Preferences}->{ContentID};

			# add attachment to the upload cache
			$UploadCacheObject->FormIDAddFile(
				FormID	  => $Self->{FormID},
				Filename	=> $AttachmentData->{Filename},
				Content	 => $AttachmentData->{Content},
				ContentType => $AttachmentData->{ContentType},
			);
		}
	}

#	 if there was an attachment delete or upload
	# we do not want to show validation errors for other fields
	if ( $ValidationError{Attachment} ) {
		%ValidationError = ();
	}


	# output header
	my $Output = $LayoutObject->Header(
		Title => 'Edit',
		Type  => 'Small',
	);

	# cycle trough the activated Dynamic Fields for this screen
	DYNAMICFIELD:
	for my $DynamicFieldConfig ( @{$DynamicField} ) {

		# get PaS dynamic fields from PaS if page is loaded the first time
		if ( !$Self->{Subaction} ) {
			$DynamicFieldValues{ 'DynamicField_' . $DynamicFieldConfig->{Name} }
				= $PaS->{ 'DynamicField_' . $DynamicFieldConfig->{Name} };
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


		 $Kernel::OM->Get('Kernel::System::Log')->Log(
			Priority => 'error',
			Message  => "Edit Dynamic field name <>  $DynamicFieldConfig->{Name}",
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

	# get all attachments meta data
	my @Attachments = $UploadCacheObject->FormIDGetAllFilesMeta(
		FormID => $Self->{FormID},
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

	 # my $SLAItems = $Kernel::OM->Get('Kernel::System::SLA')->SLASearch(
     #                          UserID  => $Self->{UserID},
     #                        );

	 	 my $SLAItems;

         $GetParam{SLAID}= $SLAItems; 
         $GetParam{PaSTitle}= 'test';
         $GetParam{SLASelectedID}= $PaS->{SLAID}; 
         
	# start template output
	$Output .= $LayoutObject->Output(
		TemplateFile => 'AgentPaSEdit',
		Data		 => {
			%Param,
			%{$PaS},
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
