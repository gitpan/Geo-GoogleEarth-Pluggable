#!/usr/bin/perl
use strict;
use warnings;
use Geo::GoogleEarth::Pluggable;
use DateTime;

my $document=Geo::GoogleEarth::Pluggable->new(name=>sprintf("Style Example - %s", DateTime->now));

my $IconStyleBlueDot=$document->IconStyle(
               color   => {red=>0, green=>0, blue=>192},
               scale   => 1.2,
               href    => "http://maps.google.com/mapfiles/kml/shapes/shaded_dot.png",
               hotSpot => {x=>20,y=>2,xunits=>"pixels",yunits=>"pixels"},
                                );

my $point=$document->Point(
                       name  => "Blue Point",
                       lat   =>  39.1,
                       lon   => -77.1,
                       style => $IconStyleBlueDot,
                     );

print $document->render;
