use strict;
use freebase;

my $query = [{
	type => "/people/person",
	name => "Ferdinand Marcos",
	nationality => undef
}];

my $result=freebase::get($query);

print($result->[0]->{nationality}."\n");