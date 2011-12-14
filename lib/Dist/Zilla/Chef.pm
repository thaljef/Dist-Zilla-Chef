package Dist::Zilla::Chef;

# ABSTRACT: Cook your distributions with Dist::Zilla

use strict;
use warnings;

#-------------------------------------------------------------------------------

# VERSION

#-------------------------------------------------------------------------------
1;

__END__

=head1 DESCRIPTION

Dist::Zilla::Chef is a suite of L<Dist::Zilla> commands that help you
build & test your dist AND all of its dependencies.  The idea is to
use Dist::Zilla to establish a workflow for managing and testing
dependencies in isolation while your dist grows and evolves.

Dist::Zilla::Chef relies on L<Pinto> to create and manage a local
CPAN-like repository containing a snapshot of all the prerequisites
that are required by your dist.  As your code evolves, you can use the
Dist::Zilla::Chef commands to periodically load the repository with any
additional prerequisites that your dist needs.  At any time, you can
build your dist and all of its dependencies in isolation, thus giving
you a full test of your entire code stack.

This is alpha code.  It is just a proof of concept.  It could even be
a disproof of concept.  You have been warned.

=head1 WHY IT IS CALLED CHEF

In some ways, creating a dist is like cooking food, and you are the
chef!  Your dist has many ingredients (dependencies).  We store
these ingredients in a pantry (Pinto repository).  When we are
hungry for some code, we cook (build) our dist by combining it with
all of the necessary ingredients.

I know, the cooking metaphor isn't perfect.  But I needed a coherent
set of names for these command plugins.  The cooking metaphor seemed
reasonable.  Who knows, maybe it will get some traction.  Suggestions
are welcome.

=head1 HOW TO COOK

Here's the general workflow for using the Dist::Zilla::Chef commands.
For this example, suppose you are going to make a new distribution called
C<Frobulator>.  So you use L<dzil> to create the basic distribution
structure for you...

  $> dzil new Frobulator

Now we write some code.  Suppose you've decided that the C<Frobulator>
is going to use L<Mojolicious>.  We also add an C<ABSTRACT>, which is
required by Dist::Zilla...

  # in lib/Frobulator.pm
  package Frobulator;

  # ABSTRACT: Does stuff

  use Mojolicious;

And after a few minutes of coding, you have a few subroutines and
maybe a couple test scripts to accompany C<Frobulator>.  Now it is
time to cook!

First, you need to gather the "ingredients" for your distribution and
"stock" them in the "pantry"...

  dzil stock

L<Mojolicious> (and all of its dependencies) will now be "stocked" in
a CPAN-like repository in the F<pan> directory.  Now you can "cook"
your distribution and all of its dependencies together...

  dzil cook

This builds, tests, and installs your distribution into the F<dlib>
directory, along with all the dependencies.  The result is stashed
in the F<dlib> directory.

Now suppose you add a new dependency on L<Test::More>.  Once again,
we run the C<stock> command to gather any ingredients that are missing
from our pantry...

  dzil stock

And finally, we cook our distribution again...

  dzil cook

But this time, only the new dependencies need to be built, since the
C<dlib> directory still has all the dependencies from the last baking.

Over time, the C<dlib> directory may get crufty, or you just might
want to cook from scratch again.  In that case, you "scrub" your
work space to remove the C<dlib> directory...

  dzil scrub

Now the next time you cook, Dist::Zilla::Chef will assemble your
distribution and all of its dependencies again.





