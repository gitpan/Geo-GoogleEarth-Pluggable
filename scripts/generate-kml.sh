#!/usr/bin/perl
use strict;
use warnings;

my $lint="";
$lint="/usr/bin/xmllint --format - " if -x "/usr/bin/xmllint";
while (my $file=shift) {
  next unless -r $file;
  printf "Running: %s\n", $file;
  print qx{perl -Mblib $file kml | $lint > "$file.kml"};
  print qx{perl -Mblib $file kmz  > "$file.kmz"};
}
