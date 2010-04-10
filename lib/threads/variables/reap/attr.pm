package threads::variables::reap::attr;

use strict;
use warnings;

BEGIN { $^W = 0; }

use Attribute::Lexical ();
use threads::variables::reap;

our $VERSION = '0.02';

sub import
{
    Attribute::Lexical->import("SCALAR:reap" => \&reap);
    Attribute::Lexical->import("ARRAY:reap" => \&reap);
    Attribute::Lexical->import("HASH:reap" => \&reap);
}

=pod

=head1 NAME

threads::variables::reap::attr - reap variables in new threads by attribute

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use threads::variables::reap::attr;

    # force database handle being reaped in each new thread
    my $dbh : reap = DBI->connect(...);

    # force array being emptied in each new thread
    my @connections : reap = map { DBI->connect( @{$_} ) } @dsnlist;

=head1 DESCRIPTION

C<threads::variables::reap::attr> provides an attribute C<reap> by lexical
scoping using L<Attribute::Lexical> to mark variables to get reaped in new
threads or child processes at compile time.

=head1 AUTHOR

Jens Rehsack, C<< <rehsack at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-threads-variables-reap at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=threads-variables-reap>.
I will be notified, and then you'll automatically be notified of progress
on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc threads::variables::reap::attr

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=threads-variables-reap>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/threads-variables-reap>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/threads-variables-reap>

=item * Search CPAN

L<http://search.cpan.org/dist/threads-variables-reap/>

=back

=head1 ACKNOWLEDGEMENTS

Larry Wall for giving us Perl - all our modules provide on his work.
David Golden for his great contribution about Perl and threads on PerlMonks
(see http://www.perlmonks.org/?node_id=483162).
Steffen Mueller for Attribute::Handlers and the helpful explanantion about
attributes there.
Andrew Main, Adam Kennedy and Joshua ben Jore helping me pointing my problem
I'm going to solve with this module.

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Jens Rehsack.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;
