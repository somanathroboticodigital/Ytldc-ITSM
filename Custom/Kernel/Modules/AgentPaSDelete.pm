# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaSDelete;

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
    $GetParam{PaSID} = $Kernel::OM->Get('Kernel::System::Web::Request')->GetParam( Param => 'PaSID' );

    # check needed stuff
    if ( !$GetParam{PaSID} ) {

        # error page
        return $LayoutObject->ErrorScreen(
            Message => "No PaSID is given!",
            Comment => 'Please contact the administrator.',
        );
    }

    # get PaS object
    my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');

    # get PaS item data
    my %PaSData = $PaSObject->PaSGet(
        PaSID     => $GetParam{PaSID},
        UserID     => $Self->{UserID},
    );
     my $PaSDeleteData = $PaSObject->PaSGet(
        PaSID     => $GetParam{PaSID},
        UserID     => $Self->{UserID},
    );
  
    if ( !%PaSData ) {
        return $LayoutObject->ErrorScreen();
    }


    if ( $Self->{Subaction} eq 'Delete' ) {

        # delete the PaS article
        my $CouldDeleteItem = $PaSObject->PaSDelete(
            PaSID => $PaSDeleteData->{PaSID},
            UserID => $Self->{UserID},
        );

        if ($CouldDeleteItem) {

            # redirect to explorer, when the deletion was successful
            return $LayoutObject->Redirect(
                OP => "Action=AgentPaS",
            );
        }
        else {

            # show error message, when delete failed
            return $LayoutObject->ErrorScreen(
                Message => "Was not able to delete the PaS article $PaSData{PaSID}!",
                Comment => 'Please contact the administrator.',
            );
        }
    }

    # set the dialog type. As default, the dialog will have 2 buttons: Yes and No
    my $DialogType = 'Confirmation';

    # output content
    my $Output = $LayoutObject->Output(
        TemplateFile => 'AgentPaSDelete',
        Data         => {
            %Param,
            $PaSDeleteData,
            PaSID => $PaSDeleteData->{PaSID},
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
