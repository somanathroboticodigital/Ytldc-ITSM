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

package Kernel::Output::HTML::TicketZoom::AssetLink;

use parent 'Kernel::Output::HTML::Base';

use strict;
use warnings;
use LWP::UserAgent;
use JSON;

our $ObjectManagerDisabled = 1;

sub Run {
    my ( $Self, %Param ) = @_;

   

    # get link table view mode
    my $LinkTableViewMode =
        $Kernel::OM->Get('Kernel::Config')->Get('LinkObject::ViewMode');

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $Location = '';

    my $AssetObject = $Kernel::OM->Get('Kernel::System::AssetLink');

    my @AgentHistoryDeatils = $AssetObject->AssetGet(TicketID => $Param{Ticket}->{TicketID});

    if (@AgentHistoryDeatils) {

        my $api_url = 'http://13.127.188.200:8000/dev-asset-search-service/api/v1/asset-search/search-n-filter?search=&fieldName=assetName,assetCategory,manufacture,model,assetCriticality,assetHealth,assetLocation,assignees,status,assetBuilding&from=0&size=20&assetHealth';
        
        # # Call the function to get access token
        my $access_token_new = $AssetObject->Gettoken();

        # Create a user agent object
        my $ua = LWP::UserAgent->new;

        # Set authorization header
        $ua->default_header('Authorization' => "Bearer $access_token_new");

        # Make GET request
        my $response = $ua->post($api_url);

        # Check for errors
        if($response->is_success) {

            my $data = decode_json($response->content);

            # Extract results
            my @results = @{$data->{results}};

            $LayoutObject->Block(
                Name => 'LinkTableComplex',
            );
            # for my $Data (@results) {
                for my $Data (@results) {
                    for my $AgentData (@AgentHistoryDeatils) {
                        if ($Data->{assetId} eq $AgentData) {

                        if ( $LinkTableViewMode eq 'Complex' ) {
                            $LayoutObject->Block(
                                Name => 'Row',
                                Data => {AssetID      =>$Data->{assetId},
                                        AssetName     =>$Data->{assetName},
                                        AssetCategory =>$Data->{assetCategory},
                                        AssetStatus   =>$Data->{status}
                                  },
                            );
                            $Location = 'Main';
                        }
                    }
                }
            }
        }
    }
    # output the complex link table

    my $Output = $LayoutObject->Output(
        TemplateFile => 'AgentTicketZoom/AssetLink',
        Data         => {},
    );
    return {
        Location => $Location,
        Output   => $Output,
        Rank     => '0350',
    };
}

# sub get_access_token {
#     my ( $Self, %Param ) = @_;

#     # Create UserAgent object
#     my $ua = LWP::UserAgent->new;

#     # Make POST request to API endpoint
#     my $response = $ua->post($Param{URL});

#     $Kernel::OM->Get('Kernel::System::Log')->Log(
#         Priority => 'error',
#         Message  => "Values >>> $json_response   >>> $Param{URL}",
#     );
#     # Check if request was successful
#     if ($response->is_success) {
#         my $json_response = $response->decoded_content;
        

#         # Extract access token from JSON response
#         # my $access_token = $Self->extract_access_token(jsonvalue => $json_response);
#     }
#     return 1;
# }

# # Function to extract access token from JSON response
# sub extract_access_token {
#     my ( $Self, %Param ) = @_;

#     my $decoded_json = decode_json($Param{jsonvalue});
#     my $access_token = $decoded_json->{'access_token'};

#     return $access_token;
# }


1;
