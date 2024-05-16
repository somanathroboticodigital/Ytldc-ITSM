# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaSFieldDelete;

use strict;
use warnings;

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

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

  
    # get params
    my %GetParam;

    # get needed Item id
    $GetParam{QuestionID} = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'QuestionID' );

    # check needed stuff
    if ( !$GetParam{QuestionID} ) {

        # error page
        return $LayoutObject->ErrorScreen(
            Message => "No QuestionID is given!",
            Comment => 'Please contact the administrator.',
        );
    }

    # get Question object
    my $QuestionObject = $Kernel::OM->Get('Kernel::System::Question');

    # get Question item data
    my %QuestionData = $QuestionObject->QuestionGet(
        QuestionID     => $GetParam{QuestionID},
        UserID     => $Self->{UserID},
    );
     my $QuestionDeleteData = $QuestionObject->QuestionGet(
        QuestionID     => $GetParam{QuestionID},
        UserID     => $Self->{UserID},
    );
  
    if ( !%QuestionData ) {
        return $LayoutObject->ErrorScreen();
    }


    if ( $Self->{Subaction} eq 'Delete' ) {

        # delete the Question article
        my $CouldDeleteItem = $QuestionObject->QuestionDelete(
            QuestionID => $QuestionDeleteData->{QuestionID},
            UserID => $Self->{UserID},
        );

        if ($CouldDeleteItem) {

            # redirect to explorer, when the deletion was successful
            return $LayoutObject->Redirect(
                OP => "Action=AgentPaS",
                # OP => "AgentPaSZoom;PaSID=$QuestionDeleteData->{SupplierName}",
            );
        }
        else {

            # show error message, when delete failed
            return $LayoutObject->ErrorScreen(
                Message => "Was not able to delete the Question article $QuestionData{QuestionID}!",
                Comment => 'Please contact the administrator.',
            );
        }
    }

    # set the dialog type. As default, the dialog will have 2 buttons: Yes and No
    my $DialogType = 'Confirmation';
    # output content
    my $Output = $LayoutObject->Output(
        TemplateFile => 'AgentPaSFieldDelete',
        Data         => {
            %Param,
            $QuestionDeleteData,
            QuestionID => $QuestionDeleteData->{QuestionID},
        },    
    );

    # build the returned data structure
    my %Data = (
        HTML       => $Output,
        DialogType => $DialogType,
    );

    # return JSON-String because of AJAX-Mode
    my $OutputJSON = $LayoutObject->JSONEncode( Data => \%Data );

    return $LayoutObject->Attachment(
        ContentType => 'application/json; charset=' . $LayoutObject->{Charset},
        Content     => $OutputJSON,
        Type        => 'inline',
        NoCache     => 1,
    );
}

1;
