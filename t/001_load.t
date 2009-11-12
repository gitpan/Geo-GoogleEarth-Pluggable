# -*- perl -*-

# t/001_load.t - check module loading and create testing directory

use Test::More tests => 12;

BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable' ); }

my $object = Geo::GoogleEarth::Pluggable->new ();
isa_ok ($object, 'Geo::GoogleEarth::Pluggable');

BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable::Base' ); }
BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable::Contrib::LinearRing' ); }
BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable::Contrib::LineString' ); }
BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable::Contrib::Point' ); }
BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable::Folder' ); }
BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable::NetworkLink' ); }
BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable::Placemark' ); }
BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable::Plugin::Default' ); }
BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable::Plugin::Style' ); }
BEGIN { use_ok( 'Geo::GoogleEarth::Pluggable::Style' ); }
