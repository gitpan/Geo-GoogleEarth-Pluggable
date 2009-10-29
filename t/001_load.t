# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 2;

BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable' ); }

my $object = Geo::GoogleEarth::Pluggable->new ();
isa_ok ($object, 'Geo::GoogleEarth::Pluggable');


