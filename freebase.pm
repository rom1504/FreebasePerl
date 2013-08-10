package freebase;

use strict;
use JSON;
use URI::Escape;
use LWP::UserAgent;

sub get
{
	my ($query)=@_;
	
	my $SERVER = 'https://www.googleapis.com';
	my $QUERYURL = $SERVER . '/freebase/v1/mqlread';



	my $encoded = to_json($query);
	my $escaped = uri_escape($encoded);


	my $url = $QUERYURL . "?query=" . $escaped;
# 	print($url."\n");
	my $ua = LWP::UserAgent->new(ssl_opts => { verify_hostname => 1 });

	my $response = $ua->get($url);

	if ($response->is_success)
	{
		my $responsetext = $response->content;
		my $response = from_json($responsetext);

		if (exists($response->{code}) && $response->{code} ne "/api/status/ok")
		{
			my $err = $response->{messages}[0];
			die $err->{code}.': '.$err->{message};
		}
		return $response->{result};
	}
	else
	{
		if($response->code eq "400")
		{
			my $responsetext = $response->content;
			my $response = from_json($responsetext);
			die "Server returned error code 400 with message ".$response->{error}->{message}."\n";
		}
		else {die "Server returned error code " . $response->code."\n";}
	}
}

1;