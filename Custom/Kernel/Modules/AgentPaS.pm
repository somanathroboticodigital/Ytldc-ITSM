# --
# Kernel/Modules/AgentPaS.pm - frontend module
# Copyright (C) (year) (name of author) (email of author)
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentPaS;

use strict;
use warnings;

# Frontend modules are not handled by the ObjectManager.
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

    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    my $Nav = $ParamObject->GetParam( Param => 'Nav' ) || 0;
    my $NavigationBarType = $Nav eq 'Agent' ? 'PaS' : 'Admin';
    my $Search = $ParamObject->GetParam( Param => 'Search' );
    $Search
        ||= $ConfigObject->Get('AgentPaS::RunInitialWildcardSearch') ? '*' : '';
    my $LayoutObject          = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');

  


        $Self->_Overview(
            Nav    => $Nav,
            Search => $Search,
        );
        my $Output = $LayoutObject->Header();
        $Output .= $LayoutObject->NavigationBar(
            Type => $NavigationBarType,
        );

        $Output .= $LayoutObject->Output(
            TemplateFile => 'AgentPaS',
            Data         => \%Param,
        );

        $Output .= $LayoutObject->Footer();
        return $Output;
     

}


sub _Edit {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
	my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');
    $LayoutObject->Block(
        Name => 'Overview',
        Data => \%Param,
    );

    $LayoutObject->Block( Name => 'ActionList' );
    $LayoutObject->Block(
        Name => 'ActionOverview',
        Data => \%Param,
    );

    $LayoutObject->Block(
        Name => 'OverviewUpdate',
        Data => \%Param,
    );


    my $ValidObject = $Kernel::OM->Get('Kernel::System::Valid');

    $Param{'ValidOption'} = $LayoutObject->BuildSelection(
        Data       => { $ValidObject->ValidList(), },
        Name       => 'ValidID',
        Class      => 'Modernize',
        SelectedID => $Param{ValidID},
    );

    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    for my $Entry ( @{ $ConfigObject->Get( $Param{Source} )->{Map} } ) {
        if ( $Entry->[0] ) {
            my $Block = 'Input';

            # build selections or input fields
            if ( $ConfigObject->Get('PaS')->{Selections}->{ $Entry->[0] } ) {
                my $OptionRequired = '';
                if ( $Entry->[4] ) {
                    $OptionRequired = 'Validate_Required';
                }

                # build ValidID string
                $Block = 'Option';
                $Param{Option} = $LayoutObject->BuildSelection(
                    Data =>
                        $ConfigObject->Get('PaS')->{Selections}
                        ->{ $Entry->[0] },
                    Name  => $Entry->[0],
                    Class => "$OptionRequired Modernize " .
                        ( $Param{Errors}->{ $Entry->[0] . 'Invalid' } || '' ),
                    Translation => 0,
                    SelectedID  => $Param{ $Entry->[0] },
                    Max         => 35,
                );

            }
           
            elsif ( $Entry->[0] =~ /^ValidID/i ) {
                my $OptionRequired = '';
                if ( $Entry->[4] ) {
                    $OptionRequired = 'Validate_Required';
                }

                # build ValidID string
                $Block = 'Option';
                $Param{Option} = $LayoutObject->BuildSelection(
                    Data  => { $ValidObject->ValidList(), },
                    Name  => $Entry->[0],
                    Class => "$OptionRequired Modernize " .
                        ( $Param{Errors}->{ $Entry->[0] . 'Invalid' } || '' ),
                    SelectedID => defined( $Param{ $Entry->[0] } ) ? $Param{ $Entry->[0] } : 1,
                );
            }
            else {
                $Param{Value} = $Param{ $Entry->[0] } || '';
            }

            # show required flag
            if ( $Entry->[4] ) {
                $Param{MandatoryClass} = 'class="Mandatory"';
                $Param{StarLabel}      = '<span class="Marker">*</span>';
                $Param{RequiredClass}  = 'Validate_Required';
            }
            else {
                $Param{MandatoryClass} = '';
                $Param{StarLabel}      = '';
                $Param{RequiredClass}  = '';
            }

            # show required flag
            if ( $Entry->[7] ) {
                $Param{ReadOnlyType} = 'readonly="readonly"';
            }
            else {
                $Param{ReadOnlyType} = '';
            }

            # add form option
            if ( $Param{Type} && $Param{Type} eq 'hidden' ) {
                $Param{Preferences} .= $Param{Value};
            }
            else {
                $LayoutObject->Block(
                    Name => 'PreferencesGeneric',
                    Data => {
                        Item => $Entry->[1],
                        %Param
                    },
                );
                $LayoutObject->Block(
                    Name => "PreferencesGeneric$Block",
                    Data => {
                        %Param,
                        Item         => $Entry->[1],
                        Name         => $Entry->[0],
                        Value        => $Param{ $Entry->[0] },
                        InvalidField => $Param{Errors}->{ $Entry->[0] . 'Invalid' } || '',
                    },
                );
                if ( $Entry->[4] ) {
                    $LayoutObject->Block(
                        Name => "PreferencesGeneric${Block}Required",
                        Data => {
                            Name => $Entry->[0],
                        },
                    );
                }
            }
        }
    }
    return 1;
}

sub _Overview {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
	my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');
    $LayoutObject->Block(
        Name => 'Overview',
        Data => \%Param,
    );


    $LayoutObject->Block( Name => 'ActionList' );
    $LayoutObject->Block(
        Name => 'ActionSearch',
        Data => \%Param,
    );

#    my $PaSObject = $Kernel::OM->Get('Kernel::System::PaS');

    # get writable data sources
    my %PaSSource = $PaSObject->PaSSourceList(
        ReadOnly => 0,
    );
   

    # only show Add option if we have at least one writable backend
    if ( scalar keys %PaSSource ) {
        $Param{SourceOption} = $LayoutObject->BuildSelection(
            Data       => { %PaSSource, },
            Name       => 'Source',
            SelectedID => $Param{Source} || '',
            Class      => 'Modernize',
        );

        $LayoutObject->Block(
            Name => 'ActionAdd',
            Data => \%Param,
        );
    }

    $LayoutObject->Block(
        Name => 'OverviewHeader',
        Data => {},
    );

    my %List = ();
    # if there are any registries to search, the table is filled and shown
    if ( $Param{Search} ) {

        my %List = $PaSObject->PaSList(
            Search => $Param{Search},
             Valid  => 0,
        );
        $LayoutObject->Block(
            Name => 'OverviewResult',
            Data => \%Param,
        );

        # get valid list
        my %ValidList = $Kernel::OM->Get('Kernel::System::Valid')->ValidList();

        my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

        # if ( !$ConfigObject->Get('PaS')->{Params}->{ForeignDB} ) {
        #     $LayoutObject->Block( Name => 'LocalDB' );
        # }

        # if there are results to show
        if (%List) {
            for my $ListKey ( sort { $List{$a} cmp $List{$b} } keys %List ) {

                my %Data = $PaSObject->PaSsGet( PaSID => $ListKey );
                $LayoutObject->Block(
                    Name => 'OverviewResultRow',
                    Data => {
                        %Data,
                        Search => $Param{Search},
                        Nav    => $Param{Nav},
                    },
                );

                if ( !$ConfigObject->Get('PaS')->{Params}->{ForeignDB} ) {
                    $LayoutObject->Block(
                        Name => 'LocalDBRow',
                        Data => {
                            Valid => $ValidList{ $Data{ValidID} },
                            %Data,
                        },
                    );
                }

            }
        }

        # otherwise it displays a no data found message
        else {
            $LayoutObject->Block(
                Name => 'NoDataFoundMsg',
                Data => {},
            );
        }
    }

    # if there is nothing to search it shows a message
    else
    {
        $LayoutObject->Block(
            Name => 'NoSearchTerms',
            Data => {},
        );
    }
    return 1;
}
