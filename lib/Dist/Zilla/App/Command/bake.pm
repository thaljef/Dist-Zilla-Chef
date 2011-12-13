package Dist::Zilla::App::Command::bake;

# ABSTRACT: bake your dist from scratch

use strict;
use warnings;

use Dist::Zilla::App -command;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------

sub execute {
    my ($self, $opt, $arg) = @_;

    my $dlib    = $self->zilla->root->subdir('dlib');
    my $pantry  = 'file://' . $self->zilla->root->subdir('pantry')->absolute();
    my $archive = $self->zilla->build_archive();

    system( qw(cpanm --mirror-only --mirror), $pantry, '-L', $dlib, $archive );

    return 1;
}

#-------------------------------------------------------------------------------

1;

__END__
