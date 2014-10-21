#!/usr/bin/perl
use strict;
use warnings;
use Geo::GoogleEarth::Pluggable;

=head1 NAME

Geo-GoogleEarth-Pluggable-Folder.pl - Geo-GoogleEarth-Pluggable Folder Example

=cut

my $document=Geo::GoogleEarth::Pluggable->new(name=>"My Document");
$document->Folder(name=>"My Name", description=>"My Description");
#use Data::Dumper qw{Dumper};
#print Dumper($document->structure);
print $document->render;
