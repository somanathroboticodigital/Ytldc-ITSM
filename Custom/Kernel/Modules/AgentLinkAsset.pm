# --
# OTOBO is a web-based ticketing system for service organisations.
# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# Copyright (C) 2019-2024 Rother OSS GmbH, https://otobo.de/
# --
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
# --

package Kernel::Modules::AgentLinkAsset;

use strict;
use warnings;
use LWP::UserAgent;
use JSON;

use Kernel::Language qw(Translatable);

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

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');


    # get params
    my %Form;
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $TicketID = $ParamObject->GetParam( Param => 'TicketID' );
    my $AssetUUID;
    my $AssetName;
    my $AssetCategory;
    my $AssetManufacture;
    
    if ( $Self->{Subaction} eq 'AssetData' ) {
    	$TicketID = $ParamObject->GetParam( Param => 'TicketIDTest' );
        $AssetUUID = $ParamObject->GetParam( Param => 'assetuuid' );
        $AssetName = $ParamObject->GetParam( Param => 'assetname' );
        $AssetCategory = $ParamObject->GetParam( Param => 'assetcategory' );
        $AssetManufacture = $ParamObject->GetParam( Param => 'assetmanufacture' );

        if ($AssetUUID or $AssetName or $AssetCategory or $AssetManufacture) {

            my $api_url = 'http://13.127.188.200:8000/dev-asset-search-service/api/v1/asset-search/search-n-filter?search=&fieldName=assetName,assetCategory,manufacture,model,assetCriticality,assetHealth,assetLocation,assignees,status,assetBuilding&from=0&size=100&assetHealth';

            my $AssetObject = $Kernel::OM->Get('Kernel::System::AssetLink');
            my $access_token_new = $AssetObject->Gettoken();

            # Create a user agent object
            my $ua = LWP::UserAgent->new;

            # Set authorization header
            $ua->default_header('Authorization' => "Bearer $access_token_new");

            # Make GET request
            my $response = $ua->post($api_url);

            # Check for errors
            if($response->is_success) {
                my $response_code = $response->code;
                # die "Failed to get data from the API: " . $response->status_line;
            }
            my $data = decode_json($response->content);
            # Extract results
            my @results = @{$data->{results}};
            
            $LayoutObject->Block(
                Name => 'LinkTable',
                Data => {AssetID => $AssetUUID,TicketID => $TicketID}
            );

            foreach my $result (@results) {
                if (($AssetUUID eq $result->{assetId}) or ($AssetName eq $result->{assetName}) or ($AssetCategory eq $result->{assetCategory}) or ($AssetManufacture eq $result->{manufacture})) {
                    
                    $LayoutObject->Block(
                        Name => 'TableComplexBlockRow',
                    );
                    
                    $LayoutObject->Block(
                        Name => 'Checkbox',
                        Data => {
                        AssetID => $result->{assetId},
                    	},
                    );

                    $LayoutObject->Block(
                        Name => 'TableComplexBlockRowColumn',
                        Data => {
                            AssetID => $result->{assetId},
                            AssetName => $result->{assetName},
                            AssetCategory => $result->{assetCategory},
                            AssetStatus => $result->{status},
                        },
                    );                 
                }
            }
        }
    }

    if ($Self->{Subaction} eq 'AssetLink') {

        my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
        my $AssetID = $ParamObject->GetParam( Param => 'AssetId' );
        my $TicketIDAsset = $ParamObject->GetParam( Param => 'TicketIDAsset' );
		my @AssetID = $ParamObject->GetArray( Param => 'selectedAssets' );


        foreach my $ID (@AssetID) {
        	if ($ID ne '') {
	            my $AssetObject = $Kernel::OM->Get('Kernel::System::AssetLink');
	            my $AssetlinkAdd    => $AssetObject->AssetlinkAdd(
	                TicketID        => $TicketIDAsset,
	                AssetID         => $ID,
	            );

	            $TicketObject->HistoryAdd(
	                TicketID     => $TicketIDAsset,
	                CreateUserID => 1,
	                HistoryType  => 'AddNote',
	                Name         => "\%\%Added Asset link with AssetID $ID",
	            );
        	}
        }
    }
    
    # ------------------------------------------------------------ #
    # close
    # ------------------------------------------------------------ #
    if ( $Self->{Subaction} eq 'Close' ) {
        return $LayoutObject->PopupClose(
            Reload => 1,
        );
    }
    
    # output header
    my $Output = $LayoutObject->Header( Type => 'Small' );
        # ------------------------------------------------------------ #     
    # start template output
    $Output .= $LayoutObject->Output(
        TemplateFile => 'AgentLinkAsset',
        Data         => {TicketID => $TicketID,AssetName => $AssetName, AssetUUID =>$AssetUUID,AssetManufacture => $AssetManufacture,AssetCategory =>$AssetCategory }
    );

    $Output .= $LayoutObject->Footer( Type => 'Small' );

    return $Output;
}

1;

