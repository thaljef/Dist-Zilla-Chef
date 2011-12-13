package Dist::Zilla::App::Command::stock;

# ABSTRACT: stock the pantry with ingredients for your dist

use strict;
use warnings;

use Pinto;
use Pinto::Creator;
use Moose::Autobox;
use Dist::Zilla::App -command;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------
sub execute {
    my ($self, $opt, $arg) = @_;

    my @phases = qw(build test configure runtime);
    my @deps = $self->extract_dependencies($self->zilla, \@phases);
    $self->stock_pantry(@deps);

    return 1;
}

#-------------------------------------------------------------------------------

sub extract_dependencies {
    my ($self, $zilla, $phases) = @_;

    $_->before_build for $zilla->plugins_with(-BeforeBuild)->flatten;
    $_->gather_files for $zilla->plugins_with(-FileGatherer)->flatten;
    $_->prune_files  for $zilla->plugins_with(-FilePruner)->flatten;
    $_->munge_files  for $zilla->plugins_with(-FileMunger)->flatten;
    $_->register_prereqs for $zilla->plugins_with(-PrereqSource)->flatten;

    my $req = Version::Requirements->new;
    my $prereqs = $zilla->prereqs;

    for my $phase (@$phases) {
        $req->add_requirements( $prereqs->requirements_for($phase, 'requires') );
        $req->add_requirements( $prereqs->requirements_for($phase, 'recommends') );
    }

    my @required = grep { $_ ne 'perl' } $req->required_modules;

    return sort { lc $a cmp lc $b } @required;
}

#-------------------------------------------------------------------------------

sub stock_pantry {
    my ($self, @deps) = @_;

    my $pantry = $self->zilla->root->subdir('pantry');
    $self->create_pantry($pantry) if not -e $pantry;

    my $pinto = Pinto->new(root_dir => $pantry);
    $pinto->new_batch(noinit => 1, nocommit => 1);
    $pinto->add_action('Import', package_name => $_) for @deps;
    $pinto->run_actions();

    return;
}

#-------------------------------------------------------------------------------

sub create_pantry {
    my ($self, $pantry) = @_;

    # TODO: Look for a .git or .svn directory in the root directory
    # and then use the appropriate Store class.  Beware that the
    # Store::VCS::Git expects that the pantry itself is the root of
    # the work tree, not the zilla root.

    my $creator = Pinto::Creator->new(root_dir => $pantry);
    $creator->create(noinit => 1);

    return;
}

#-------------------------------------------------------------------------------

1;

__END__
