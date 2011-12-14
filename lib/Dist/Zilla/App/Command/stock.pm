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
    my @deps = $self->_extract_dependencies($self->zilla, \@phases);
    $self->_stock_pantry(@deps);

    return 1;
}

#-------------------------------------------------------------------------------

sub _extract_dependencies {
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

    my @sorted = sort { lc $a cmp lc $b } @required;

    return @sorted;
}

#-------------------------------------------------------------------------------

sub _stock_pantry {
    my ($self, @deps) = @_;

    my $pan   = $self->_create_or_find_pantry();
    my $pinto = Pinto->new(root_dir => $pan);
    $pinto->new_batch(noinit => 1, nocommit => 1);
    $pinto->add_action('Import', package_name => $_) for @deps;
    $pinto->run_actions();

    return;
}

#-------------------------------------------------------------------------------

sub _create_or_find_pantry {
    my ($self) = @_;

    # TODO: Look for a .git or .svn directory in the root directory
    # and then use the appropriate Store class.  Beware that the
    # Store::VCS::Git expects that the pantry itself is the root of
    # the work tree, not the zilla root.

    my $pan = $self->zilla->root->subdir('pan');
    return $pan if -e $pan;

    my $creator = Pinto::Creator->new(root_dir => $pan);
    $creator->create(noinit => 1);

    return $pan;
}

#-------------------------------------------------------------------------------

1;

__END__

=head1 SYNOPSIS

  dzil stock

=head1 DESCRIPTION

This L<Dist::Zilla> command "stocks" the "pantry" with all the
ingredients for your distribution.  More specifically, the C<stock>
command extracts the dependencies from your distribution and uses
L<Pinto> to import all of them into a local CPAN-like repository in
the F<pan> directory.  As your distribution evolves and accumulates
more dependencies, you can run the C<stock> command again to "stock"
the additional ingredients.

=head1 ARGUMENTS

None.

=head1 OPTIONS

None.

=head1 NOTES

The easiest way to declare your dependencies is to use the
L<Dist::Zilla::Plugin::AutoPrereqs> plugin, which automatically
discovers dependencies by examining your code.  To use the plugin,
add this to your F<dist.ini> file, like so...

  [AutoPrereqs]


