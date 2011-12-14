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

    return;
}

#-------------------------------------------------------------------------------

1;

__END__

=head1 SYNOPSIS

  dzil scrub

=head1 DESCRIPTION

This L<Dist::Zilla> command "scrubs" your work space to a clean state
by removing any dependencies that have been installed F<dlib>
directory, thus forcing the next cooking to be done from scratch.

You should periodically C<scrub> your work space to remove any
dependencies that are no longer needed.  But you don't need to do it
every time you cook, or your code/build/test cycles will be unbearably
long.

=head1 ARGUMENTS

None.

=head1 OPTIONS

None
