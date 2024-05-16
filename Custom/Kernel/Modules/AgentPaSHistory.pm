# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaSHistory;

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
            Message => "Can't show history, as no PaSID is given!",
            Comment => 'Please contact the administrator.',
        );
    }

	my $DynamicFieldObject        = $Kernel::OM->Get('Kernel::System::DynamicField');
    my $DynamicFieldBackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
   
    # get PaS object
    my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');

    # get PaS item data
    my %PaSData = $PaSObject->PaSGet(
		PaSID => $GetParam{PaSID},
		UserID   => $Self->{UserID},
	);
	
    if ( !%PaSData ) {
        return $LayoutObject->ErrorScreen();
    }

    # get PaS article history
    my $History = $PaSObject->PaSHistoryGet(
        PaSID => $GetParam{PaSID},
        UserID => $Self->{UserID},
    );
    
    for my $HistoryEntry ( @{$History} ) {

        # replace ID to full user name on CreatedBy key
        my %User = $Kernel::OM->Get('Kernel::System::User')->GetUserData(
            UserID => $HistoryEntry->{CreatedBy},
            Cached => 1,
        );
        $HistoryEntry->{CreatedBy} = "$User{UserLogin} ($User{UserFirstname} $User{UserLastname})";

        # call Row block
        $LayoutObject->Block(
            Name => 'Row',
            Data => {
                %{$HistoryEntry},
            },
        );
    }

    # output header
    my $Output = $LayoutObject->Header(
        Type  => 'Small',
        Title => 'PaSHistory',
    );

    # start template output
    $Output .= $LayoutObject->Output(
        TemplateFile => 'AgentPaSHistory',
        Data         => {
            %GetParam,
            %PaSData,
        },
    );

    # add footer
    $Output .= $LayoutObject->Footer(
        Type => 'Small',
    );

    return $Output;
}

1;
