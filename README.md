# NAME

Dist::Zilla::Chef - Cook your distributions with Dist::Zilla

# VERSION

version 0.002

# DESCRIPTION

Dist::Zilla::Chef is a suite of [Dist::Zilla](http://search.cpan.org/perldoc?Dist::Zilla) commands that help you
build & test your dist AND all of its dependencies.  The idea is to
use Dist::Zilla to establish a workflow for managing and testing
dependencies in isolation while your dist grows and evolves.

Dist::Zilla::Chef relies on [Pinto](http://search.cpan.org/perldoc?Pinto) to create and manage a local
CPAN-like repository containing a snapshot of all the prerequisites
that are required by your dist.  As your code evolves, you can use the
Dist::Zilla::Chef commands to periodically load the repository with any
additional prerequisites that your dist needs.  At any time, you can
build your dist and all of its dependencies in isolation, thus giving
you a full test of your entire code stack.

This is alpha code.  It is just a proof of concept.  It could even be
a disproof of concept.  You have been warned.

# WHY IT IS CALLED CHEF

In some ways, creating a dist is like cooking food, and you are the
chef!  Your dist has many ingredients (dependencies).  We store
these ingredients in a pantry (Pinto repository).  When we are
hungry for some code, we cook (build) our dist by combining it with
all of the necessary ingredients.

I know, the cooking metaphor isn't perfect.  But I needed a coherent
set of names for these command plugins.  The cooking metaphor seemed
reasonable.  Who knows, maybe it will get some traction.  Suggestions
are welcome.

# HOW TO COOK

Here's the general workflow for using the Dist::Zilla::Chef commands.
For this example, suppose you are going to make a new distribution called
`Frobulator`.  So you use [dzil](http://search.cpan.org/perldoc?dzil) to create the basic distribution
structure for you...

    $> dzil new Frobulator

Now we write some code.  Suppose you've decided that the `Frobulator`
is going to use [Dancer](http://search.cpan.org/perldoc?Dancer).  We also add an `ABSTRACT`, which is
required by Dist::Zilla...

    # in lib/Frobulator.pm
    package Frobulator;

    # ABSTRACT: Does stuff

    use Dancer;

And after a few minutes of coding, you have a few subroutines and
maybe a couple test scripts to accompany `Frobulator`.  Now it is
time to cook!

First, you need to gather the "ingredients" for your distribution and
"stock" them in the "pantry"...

    dzil stock

[Dancer](http://search.cpan.org/perldoc?Dancer) (and all of its dependencies) will now be "stocked" in
a CPAN-like repository in the `pan` directory.  Now you can "cook"
your distribution and all of its dependencies together...

    dzil cook

This builds, tests, and installs your distribution into the `dlib`
directory, along with all the dependencies.  The result is stashed
in the `dlib` directory.

Now suppose you add a new dependency on [Test::More](http://search.cpan.org/perldoc?Test::More).  Once again,
we run the `stock` command to gather any ingredients that are missing
from our pantry...

    dzil stock

And finally, we cook our distribution again...

    dzil cook

But this time, only the new dependencies need to be built, since the
`dlib` directory still has all the dependencies from the last baking.

Over time, the `dlib` directory may get crufty, or you just might
want to cook from scratch again.  In that case, you "scrub" your
work space to remove the `dlib` directory...

    dzil scrub

Now the next time you cook, Dist::Zilla::Chef will assemble your
distribution and all of its dependencies again.

# SUPPORT

## Perldoc

You can find documentation for this module with the perldoc command.

    perldoc Dist::Zilla::Chef

## Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

- Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

[http://search.cpan.org/dist/Dist-Zilla-Chef](http://search.cpan.org/dist/Dist-Zilla-Chef)

- CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

[http://cpanratings.perl.org/d/Dist-Zilla-Chef](http://cpanratings.perl.org/d/Dist-Zilla-Chef)

- CPAN Testers

The CPAN Testers is a network of smokers who run automated tests on uploaded CPAN distributions.

[http://www.cpantesters.org/distro/D/Dist-Zilla-Chef](http://www.cpantesters.org/distro/D/Dist-Zilla-Chef)

- CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual overview of the test results for a distribution on various Perls/platforms.

[http://matrix.cpantesters.org/?dist=Dist-Zilla-Chef](http://matrix.cpantesters.org/?dist=Dist-Zilla-Chef)

- CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

[http://deps.cpantesters.org/?module=Dist::Zilla::Chef](http://deps.cpantesters.org/?module=Dist::Zilla::Chef)

## Bugs / Feature Requests

[https://github.com/thaljef/Dist-Zilla-Chef/issues](https://github.com/thaljef/Dist-Zilla-Chef/issues)

## Source Code



[https://github.com/thaljef/Dist-Zilla-Chef](https://github.com/thaljef/Dist-Zilla-Chef)

    git clone git://github.com/thaljef/Dist-Zilla-Chef.git

# AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.