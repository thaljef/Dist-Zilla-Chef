package Dist::Zilla::App::Command::scrub;

# ABSTRACT: thoroughly clean your kitchen

use strict;
use warnings;

use File::Path;
use Dist::Zilla::App -command;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub execute {
    my ($self, $opt, $arg) = @_;

    $self->zilla->clean;
    my $dlib = $self->zilla->root->subdir('dlib');
    File::Path::rmtree($dlib->stringify()) if -e $dlib;
}

#-------------------------------------------------------------------------------

1;

__END__

=head1 SYNOPSIS

  dzil scrub

=head1 DESCRIPTION

This L<Dist::Zilla> command "scrubs" your workspace clean by removing
any dependencies that have been installed F<dlib> directory, thus
forcing the next C<bake> to be done from scratch.

You should periodically C<scrub> your workspace to remove any
dependencies that are no longer needed.  But you don't need to do it
every time you bake, or your code/build/test cycles will be unbearably
long.

=head1 ARGUMENTS

None.

=head1 OPTIONS

None
