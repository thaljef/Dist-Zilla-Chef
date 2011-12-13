package Dist::Zilla::App::Command::scrub;

# ABSTRACT: clean up your kitchen

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

    return 1;
}

#-------------------------------------------------------------------------------

1;

__END__
