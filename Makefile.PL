

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Geo::GoogleEarth::Pluggable',
    VERSION_FROM => 'lib/Geo/GoogleEarth/Pluggable.pm', # finds \$VERSION
    AUTHOR       => 'Michael R. Davis (domain=>michaelrdavis,tld=>com,account=>perl)',
    ABSTRACT     => 'Module abstract (<= 44 characters) goes here',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44,
                     'Scalar::Util' => 0,
                     'strict'       => 0,
                     'warnings'     => 0,
                    },
);
