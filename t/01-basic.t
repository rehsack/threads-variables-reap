#!perl -T

BEGIN {
    use Config;
    if (! $Config{'useithreads'}) {
        print("1..0 # SKIP Perl not compiled with 'useithreads'\n");
        exit(0);
    }
}

#eval { require threads; use threads; $have_threads = 1; } if( 'define' eq $Config{usethreads} );
use threads;
use threads::variables::reap;
use threads::variables::reap::attr;
use Test::More;

INIT {
    # for debugging
    1;
}

#plan( skip_all => "Test 01-basic isn't reasonable without threads" ) unless $threads::threads;
plan( tests => 18 );

sub runThreads(@)
{
    my @threads = @_;
    foreach my $thr (@threads)
    {
	threads->create($thr);
    }
    do
    {
	threads->yield();
	foreach my $thr (threads->list(threads::joinable) )
	{
	    $thr->join();
	}
    } while( scalar( threads->list(threads::all) ) > 0 );
}

my $dbh1 : reap;
$dbh1 = 0;
my $dbh2 = 6;
reap($dbh2);

runThreads( \&runThreadS1, \&runThreadS2 );
++$dbh1;
++$dbh2;
is( $dbh1, 1, 'attributed scalar' );
is( $dbh2, 7, 'function scalar' );

our @ary1 : reap;
@ary1 = qw(Hello world);
my @ary2;
@ary2 = qw'Perl rocks';
reap(@ary2);
runThreads( \&runThreadA1, \&runThreadA2 );
is( join(' ', @ary1), 'Hello world', 'attributed array' );
is( join(' ', @ary2), 'Perl rocks', 'function array' );

our %h1 : reap;
%h1 = ( Hello => 'world' );
my %h2;
%h2 = ( Perl => 'rocks' );
reap(%h2);
runThreads( \&runThreadH1, \&runThreadH2 );
is( join(' ', %h1), 'Hello world', 'attributed hash' );
is( join(' ', %h2), 'Perl rocks', 'function hash' );

sub runThreadS1
{
    is( $dbh1, undef, 'new thread attributed scalar in ' . threads->tid() );
    $dbh1 = 2;
    threads->create( \&runThreadS1, 1 ) unless( $_[0] );
}

sub runThreadS2
{
    is( $dbh2, undef, 'new thread function scalar in ' . threads->tid() );
    $dbh2 = 4;
    threads->create( \&runThreadS2, 1 ) unless( $_[0] );
}

sub runThreadA1
{
    is( join(' ', @ary1), '', 'new thread attributed array in ' . threads->tid() );
    @ary1 = qw(Hello Perl);
    threads->create( \&runThreadA1, 1 ) unless( $_[0] );
}

sub runThreadA2
{
    is( join(' ', @ary2), '', 'new thread function array in ' . threads->tid() );
    @ary2 = qw'NetBSD rocks';
    threads->create( \&runThreadA2, 1 ) unless( $_[0] );
}

sub runThreadH1
{
    is( join(' ', %h1), '', 'new thread attributed hash in ' . threads->tid() );
    %h1 = ( Hello => 'world' );
    threads->create( \&runThreadH1, 1 ) unless( $_[0] );
}

sub runThreadH2
{
    is( join(' ', %h2), '', 'new thread function hash in ' . threads->tid() );
    %h2 = ( NetBSD => 'rocks' );
    threads->create( \&runThreadH2, 1 ) unless( $_[0] );
}
