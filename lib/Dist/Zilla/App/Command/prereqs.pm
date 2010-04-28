use 5.008;
use strict;
use warnings;

package Dist::Zilla::App::Command::prereqs;
our $VERSION = '1.100750';

# ABSTRACT: print your distribution's prerequisites
use Dist::Zilla::App -command;
use Moose::Autobox;
use Capture::Tiny 'capture';
sub abstract { "print your distribution's prerequisites" }

sub execute {
    my ($self, $opt, $arg) = @_;
    capture {
        $_->before_build for $self->zilla->plugins_with(-BeforeBuild)->flatten;
        $_->gather_files for $self->zilla->plugins_with(-FileGatherer)->flatten;
        $_->prune_files  for $self->zilla->plugins_with(-FilePruner)->flatten;
        $_->munge_files  for $self->zilla->plugins_with(-FileMunger)->flatten;
        for my $plugin ($self->zilla->plugins_with(-FixedPrereqs)->flatten) {
            my $prereq = $plugin->prereq;
            $self->zilla->register_prereqs($_ => $prereq->{$_}) for keys %$prereq;
        }
    };
    my $prereq = $self->zilla->prereq->as_distmeta;
    my %req;
    for (qw(requires build_requires configure_requires)) {
        $req{$_}++ for keys %{ $prereq->{$_} || {} };
    }
    delete $req{perl};
    print map { "$_\n" } sort keys %req;
}
1;


__END__
=pod

=head1 NAME

Dist::Zilla::App::Command::prereqs - print your distribution's prerequisites

=head1 VERSION

version 1.100750

=head1 SYNOPSIS

    # dzil prereqs | xargs cpanm

=head1 DESCRIPTION

This is a command plugin for L<Dist::Zilla>. It provides the C<prereqs>
command, which prints your distribution's prerequisites. You could use that
list to pipe it into L<cpanm> - see L<App::cpanminus>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org/Public/Dist/Display.html?Name=Dist-Zilla-App-Command-prereqs>.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see
L<http://search.cpan.org/dist/Dist-Zilla-App-Command-prereqs/>.

The development version lives at
L<http://github.com/hanekomu/Dist-Zilla-App-Command-prereqs/>.
Instead of sending patches, please fork this project using the standard git
and github infrastructure.

=head1 AUTHOR

  Marcel Gruenauer <marcel@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Marcel Gruenauer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

