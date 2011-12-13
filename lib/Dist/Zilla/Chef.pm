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

Dist::Zilla::Chef is a suite of L<Dist::Zilla> commands and plugins
that help you build & test your dist AND all of its dependencies.
The idea is to use Dist::Zilla to establish a workflow for managing
and testing dependencies while your dist grows and evolves.

Dist::Zilla::Chef relies on L<Pinto> to create and manage a local
CPAN-like repository containing a snapshot of all the prerequisites
that are required by your dist.  As your code evolves, you can
perodically load the repository with any additional prerequisites that
your dist needs.  At any time, you can build your dist and all of
its dependencies in isolation, thus giving you a full test of your
entire code stack.

This is alpha code.  It is just a proof of concept.  It could even be
a disproof of concept.  You have been warned.

=head1 WHY IT IS CALLED CHEF

In some ways, creating a dist is like cooking food, and you are the
chef.  Your dist has many "ingredients" (dependencies).  We store
these ingredients in a "pantry" (Pinto repostiory).  When we are
hungry for some code, we "bake" (build) our dist by combining it with
all of the necessary ingredients.

I know, this metaphor isn't perfect.  But I needed a coherent set of
names for these command plugins.  The cooking metaphor seemed
reasonable.  Who knows, maybe it will get some traction.

=head1 HOW TO BECOME A CHEF

Here's the general process for using the Dist::Zilla::Chef commands.  First,
suppose we are going to make a new distribution call Frobulator.  So we're
going to use L<dzil> to create the basic structure for us...

  dzil new Frobulator

Now we need to write some code.  So let's add a function to the Frobulator
class...

   # in lib/Frobulator.pm
   package Frobulator;

   use autodie;

   sub blazo { ... }

Notice that
