package Kernel::System::AssetLink;

use strict;
use warnings;
use JSON;

use Crypt::JWT qw(decode_jwt encode_jwt);
use URI::Encode qw(uri_encode);
use REST::Client;
use MIME::Base64 qw();

our @ObjectDependencies = (
    'Kernel::System::Log',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}


# my $AssetObject = $Kernel::OM->Get('Kernel::System::AssetLink');

sub AssetlinkAdd {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{TicketID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need TicketID!'
        );
        return;
    }

    # check needed stuff
    for my $Needed (qw(TicketID AssetID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!"
            );
            return;
        }
    }

    my $UserID = 1;
    # db insert
        return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL => 'INSERT INTO asset_link '
                . ' (ticket_id, asset_id, asset_name, '
                . ' create_time, create_by) '
                . 'VALUES '
                . '(?, ?, ?, current_timestamp, ?)',
            Bind => [
                \$Param{TicketID}, \$Param{AssetID}, \$Param{AssetName},\$UserID,
            ],
        );

    return 1;
}

sub GetAssetTicketIDs {
    my ( $Self, %Param ) = @_;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    return if !$DBObject->Prepare(
        SQL  => "SELECT ticket_id FROM asset_link where asset_id = ?",
        Bind => [ \$Param{AssetID} ],
    );

    my @TicketIDs;

    while (my @Row = $DBObject->FetchrowArray()) {
        push @TicketIDs, $Row[0]; 
    }

    return @TicketIDs; 
}


sub AssetGet{
    
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Attribute (qw(TicketID)) {
        if ( !$Param{$Attribute} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Attribute!",
            );
            return;
        }
    }   
    # get data from database
    return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => "select asset_id from asset_link where ticket_id = ?",           
        Bind  => [ \$Param{TicketID} ],         
    );
    my @Assetid;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        push @Assetid, $Row[0];
    }   
        
    return @Assetid;
    
}

sub TempAssetlinkAdd {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{FormID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need FormID!'
        );
        return;
    }

    # check needed stuff
    for my $Needed (qw(FormID AssetID)) {
        if ( !$Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!"
            );
            return;
        }
    }

    my $UserID = 1;
    # db insert
        return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL => 'INSERT INTO asset_link_temp '
                . ' (form_id, asset_id, '
                . ' create_time, create_by) '
                . 'VALUES '
                . '(?, ?, current_timestamp, ?)',
            Bind => [
                \$Param{FormID}, \$Param{AssetID}, \$UserID,
            ],
        );

    return 1;
}


sub TempLinkAssetGet {
    my ( $Self, %Param ) = @_;
 
    # check needed stuff
    if ( !$Param{FormID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need FormID to Get Asset !"
        );
        return;
    }

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    return if !$DBObject->Prepare(
        SQL => "SELECT asset_id FROM asset_link_temp WHERE form_id = ?",
        Bind => [ \$Param{FormID} ],
    );

    my @AssetTemp;

    while (my @Row = $DBObject->FetchrowArray()) {
        push @AssetTemp, $Row[0]; 
    }

    return @AssetTemp; 
}


sub Gettoken {
    my ($Self, %Param) = @_;
    my $client = REST::Client->new();
    my $url = 'https://13.127.188.200:8446/realms/ytldc/protocol/openid-connect/token';
    my %params = (
        client_id     => 'ytldc',
        username     => 'testhemant',
        password     => 'Test@1234',
        grant_type    => 'password',
        client_secret => 'WB5OM0FJX95Gk3aksM47a3ATQLsGZcs5',
    );

    # Encode the parameters for the request body
    my $encoded_data = join '&', map { uri_encode($_) . '=' . uri_encode($params{$_}) } keys %params;

    # Add SSL options
    $client->getUseragent()->ssl_opts(verify_hostname => 0);
    $client->getUseragent()->ssl_opts(SSL_verify_mode => 'SSL_VERIFY_NONE');

    # Set headers
    $client->addHeader('Content-Type', 'application/x-www-form-urlencoded');

    # Make the POST request with the parameters
    my $response = $client->POST($url, $encoded_data);
    my $access_token;
    # Check if the request was successful
        if ($client->responseCode() == 200) {
            my $tokendecode = $Kernel::OM->Get('Kernel::System::JSON')->Decode(Data => $client->responseContent(),);
            $access_token = $tokendecode->{access_token};

        } else {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Error: >> $client->responseCode()",
            );
        }
    return $access_token;
}

sub AssetTempGet{
    
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Attribute (qw(FormID)) {
        if ( !$Param{$Attribute} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Attribute!",
            );
            return;
        }
    }   
    # get data from database
    return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => "select asset_id from asset_link_temp where form_id = ?",           
        Bind  => [ \$Param{FormID} ],         
    );
    my $Assetid;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $Assetid = $Row[0];
    }   
        
    return $Assetid;
    
}

1;
