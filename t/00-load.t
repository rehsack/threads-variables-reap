#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'threads::variables::reap' ) || print "Bail out!\n";
    use_ok( 'threads::variables::reap::attr' ) || print "Bail out!\n";
}

diag( "Testing threads::variables::reap $threads::variables::reap::VERSION, Perl $], $^X" );
