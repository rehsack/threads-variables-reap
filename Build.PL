use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'threads::variables::reap',
    license             => 'perl',
    dist_author         => q{Jens Rehsack <rehsack@cpan.org>},
    dist_version_from   => 'lib/threads/variables/reap.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'threads-variables-reap-*' ],
    create_makefile_pl  => 'traditional',
    requires            => {
    },
    recommends          => {
	threads         => 0,
    },
);

$builder->create_build_script();
