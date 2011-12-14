package Dist::Zilla::App::Command::bake;

# ABSTRACT: build and test your dist from scratch

use strict;
use warnings;

use Dist::Zilla::App -command;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub execute {
    my ($self, $opt, $arg) = @_;

    my $dlib = $self->zilla->root->subdir('dlib');
    my $pan  = 'file://' . $self->zilla->root->subdir('pan')->absolute();
    my $archive = $self->zilla->build_archive();

    system( qw(cpanm --mirror-only --mirror), $pan, '-L', $dlib, $archive );
}

#-------------------------------------------------------------------------------

1;

__END__

=head1 SYNOPSIS

  dzil bake

=head1 DESCRIPTION

This L<Dist::Zilla> command "bakes" your distribution from scratch.
It builds, tests, and installs, your distribution and all of its
dependencies in a sandbox using L<cpanm> and L<local::lib>.  The
dependencies are pulled from the local L<Pinto> repository in the
f<pan> directoy, and the resulting build is placed in the F<dlib>
directory.

Baking a distribution is equivalent to installing your distribution
against a virgin Perl with the CPAN toolchain.  The resulting F<dlib>
will contain your distribution and its entire dependency stack.  In
theory, you could then deploy this directory as an isolated
application or component.

=head1 ARGUMENTS

None.

=head1 OPTIONS

None.

=head1 NOTES

Before you can bake a distribution, you need to stock up on the
necessary ingredients (i.e. dependencies).  To do that, use the
C<stock> command.

The F<dlib> directory is preserved after each baking.  But if the
F<dlib> directory gets crufty, use the C<scrub> command to erase it,
and the next baking will start from scratch.
