package Kernel::System::KeycloakAuth;

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

# Encode JWT with expiration in $expires_sec time
sub encode_jw_token {
    # my ($payload, $secret, $expires_sec) = @_;
    my ($Self, %Param) = @_;
    
    my $now = time();
    my $expires = $now + $Param{expires_sec};  # $expires_sec in seconds

    $Param{payload}->{'exp'} = $expires;

    my $jwt;

    eval {
        $jwt = Crypt::JWT::encode_jwt(
            payload => $Param{payload},
            key => $Param{secret},
            alg => 'HS256',
            claims => { exp => $expires, iat => $now },
        );
    };
    if ($@) {
        my $error_message = $@;

        my @error_array = split ' at ', $error_message;

        return $error_array[0];
    }
   
    return $jwt;
}

# Decode JWT
sub decode_jw_token {
    my ($Self, %Param) = @_;
    my $decoded;
    eval {
        $decoded = decode_jwt(
            token => $Param{jwt},
            # key => $Param{secret},
            verify_exp => 1
        );
    };
    if ($@) {
        my $error_message = $@;

        my @error_array = split ' at ', $error_message;

        return $error_array[0];
    }
    
    return $decoded;
}

sub GetauthtokenAgent {
    my ($Self, %Param) = @_;
    my $client = REST::Client->new();
    my $url = 'https://13.127.188.200:8446/realms/ytldc/protocol/openid-connect/token';
    my %params = (
        client_id     => 'ytldc',
        code          => $Param{code},
        grant_type    => 'authorization_code',
        redirect_uri  => 'http://13.202.10.168/otobo/index.pl',
        client_secret => 'WB5OM0FJX95Gk3aksM47a3ATQLsGZcs5',
        scope         => 'openid'
    );

    # Encode the parameters for the request body
    my $encoded_params = join '&', map { uri_encode($_) . '=' . uri_encode($params{$_}) } keys %params;

    # Add SSL options
    $client->getUseragent()->ssl_opts(verify_hostname => 0);
    $client->getUseragent()->ssl_opts(SSL_verify_mode => 'SSL_VERIFY_NONE');

    # Set headers
    $client->addHeader('Content-Type', 'application/x-www-form-urlencoded');

    # Make the POST request with the parameters
    my $response = $client->POST($url, $encoded_params);
   
    # Check if the request was successful
    if ($client->responseCode() == 200) {
        my $PerlStructureScalar = $Kernel::OM->Get('Kernel::System::JSON')->Decode(
            Data => $client->responseContent(),
        );

        my ($header_base64, $payload_base64, $signature_base64) = split(/\./, $PerlStructureScalar->{access_token});
        my $UserDetails = $Kernel::OM->Get('Kernel::System::JSON')->Decode(
            Data => MIME::Base64::decode_base64( $payload_base64 ),
        );

        if(defined $UserDetails->{preferred_username}){
            my $UserObject = $Kernel::OM->Get('Kernel::System::User');
            my $UserID = $UserObject->UserLookup(
                UserLogin => $UserDetails->{preferred_username},
            );

            $Self->AddUserAccessToken(UserID => $UserID, AccessToken =>$PerlStructureScalar->{access_token}, IDToken => $PerlStructureScalar->{id_token}, UserType => 'Agent');
        }

        return $UserDetails;
    } else {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Error: >> $client->responseCode()",
        );
        return ;
    }
}

sub GetauthtokenCustomer {
    my ($Self, %Param) = @_;
    my $client = REST::Client->new();
    my $url = 'https://13.127.188.200:8446/realms/ytldc/protocol/openid-connect/token';
    my %params = (
        client_id     => 'ytldc',
        code          => $Param{code},
        grant_type    => 'authorization_code',
        redirect_uri  => 'http://13.202.10.168/otobo/customer.pl',
        client_secret => 'WB5OM0FJX95Gk3aksM47a3ATQLsGZcs5',
        scope         => 'openid'
    );

    # Encode the parameters for the request body
    my $encoded_params = join '&', map { uri_encode($_) . '=' . uri_encode($params{$_}) } keys %params;

    # Add SSL options
    $client->getUseragent()->ssl_opts(verify_hostname => 0);
    $client->getUseragent()->ssl_opts(SSL_verify_mode => 'SSL_VERIFY_NONE');

    # Set headers
    $client->addHeader('Content-Type', 'application/x-www-form-urlencoded');

    # Make the POST request with the parameters
    my $response = $client->POST($url, $encoded_params);
   
    # Check if the request was successful
    if ($client->responseCode() == 200) {
        my $PerlStructureScalar = $Kernel::OM->Get('Kernel::System::JSON')->Decode(
            Data => $client->responseContent(),
        );
        my ($header_base64, $payload_base64, $signature_base64) = split(/\./, $PerlStructureScalar->{access_token});
        my $UserDetails = $Kernel::OM->Get('Kernel::System::JSON')->Decode(
            Data => MIME::Base64::decode_base64( $payload_base64 ),
        );

        if(defined $UserDetails->{preferred_username}){
            $Self->AddUserAccessToken(UserID => $UserDetails->{preferred_username}, AccessToken =>$PerlStructureScalar->{access_token}, IDToken => $PerlStructureScalar->{id_token}, UserType => 'CustomerUser');
        }
        return $UserDetails;
    } else {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Error: >> $client->responseCode()",
        );
        return ;
    }
}

sub GetUserDetailsFromAuthtoken {
    my ($Self, %Param) = @_;

    my ($header_base64, $payload_base64, $signature_base64) = split(/\./, $Param{access_token});
    my $UserDetails = $Kernel::OM->Get('Kernel::System::JSON')->Decode(
        Data => MIME::Base64::decode_base64( $payload_base64 ),
    );

    if (defined $UserDetails->{preferred_username}) {
        my $UserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup(
            UserLogin => $UserDetails->{preferred_username} ,
        );
        return $UserID;
    }
    else{
        return ;
    }
    
}


sub AddUserAccessToken{
    my ( $Self, %Param ) = @_;
    # check needed stuff
    for my $Argument (qw(UserID AccessToken IDToken UserType)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # add  to Risk to database
    return if !$Kernel::OM->Get('Kernel::System::DB')->Do(
        SQL => "INSERT INTO user_access_token ( user_id, access_token, id_token, user_type) VALUES ( ?,?,?, ?)",
        Bind => [
            \$Param{UserID}, \$Param{AccessToken}, \$Param{IDToken}, \$Param{UserType}
        ],
    );
    return 1
}

sub DeleteUserAccessToken{
    
    my ( $Self, %Param ) = @_;
    for my $Attribute (qw(UserID UserType)) {
        if ( !$Param{$Attribute} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Attribute!",
            );
            return;
        }
    }
  
    my $Success = return if !$Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => 'DELETE FROM user_access_token WHERE user_id = ? and user_type = ?',
        Bind  => [ \$Param{UserID},\$Param{UserType} ],
            
    );
 
    return $Success;
}

sub GetAccessToken{
    
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Attribute (qw(UserID UserType)) {
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
        SQL => "SELECT access_token FROM user_access_token WHERE user_id = ? and user_type = ?",           
        Bind  => [ \$Param{UserID},\$Param{UserType} ],         
    );
    my $AccessToken;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $AccessToken = $Row[0];
    }   
        
    return $AccessToken;
    
}

sub AddUserInKeycloak{
    my ( $Self, %Param ) = @_;

    my $token = $Self->GetAccessToken(UserID => $Param{ChangeUserID} , UserType => 'Agent');

    my $url = "http://13.127.188.200:8000/dev-user-service/api/v1/user/create-user";

    # Define data to be sent in the request body
    my $data = {
        firstName => $Param{UserFirstname},
        lastName => $Param{UserLastname},
        userName => $Param{UserLogin},
        password => $Param{UserPw},
        emailId  =>  $Param{UserEmail},
        primaryPhoneCountryCode  => "91",
        primaryPhone  => $Param{UserMobile},
        userType  => $Param{UserType}
    };

    my $json_data = $Kernel::OM->Get('Kernel::System::JSON')->Encode(
        Data => $data,
    );

    my $client = REST::Client->new();
    $client->addHeader('Authorization', "Bearer $token");
    $client->addHeader('Content-Type', 'application/json');

   

    $client->POST($url, $json_data);

    my $error =  $client->responseContent();
    $Kernel::OM->Get('Kernel::System::Log')->Log(
        Priority => 'error',
        Message  => "error result <> $error <> ",
    );
    if ($client->responseCode() == 200) {
        return 1;
    } else {
        return 0;
    }
}

sub UpdateUserInKeycloak{
    my ( $Self, %Param ) = @_;

    my $token = $Self->GetAccessToken(UserID => $Param{ChangeUserID} , UserType => 'Agent');

    my $url = "http://13.127.188.200:8000/dev-user-service/api/v1/user/update-user/$Param{OldUserLogin}";

    # Define data to be sent in the request body
    my $data = {
        firstName => $Param{UserFirstname},
        lastName => $Param{UserLastname},
        userName => $Param{UserLogin},
        emailId  =>  $Param{UserEmail},
        primaryPhoneCountryCode  => "91",
        primaryPhone  => $Param{UserMobile},
        userType  => $Param{UserType}
    };

    my $json_data = $Kernel::OM->Get('Kernel::System::JSON')->Encode(
        Data => $data,
    );

    my $client = REST::Client->new();
    $client->addHeader('Authorization', "Bearer $token");
    $client->addHeader('Content-Type', 'application/json');

    $client->PUT($url, $json_data);

    if ($client->responseCode() == 200) {
        return 1;
    } else {
        return 0;
    }
}

sub GetAccessTokenDetails{
    
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Attribute (qw(UserID UserType)) {
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
        SQL => "SELECT access_token,id_token  FROM user_access_token WHERE user_id = ? and user_type = ?",           
        Bind  => [ \$Param{UserID},\$Param{UserType} ],         
    );

    my %Result;
    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        $Result{AccessToken} = $Row[0];
        $Result{IDToken} = $Row[1];
       
    }
    
    return %Result;
    
}


1;