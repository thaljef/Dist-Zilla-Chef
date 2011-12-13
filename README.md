# NAME

Dist::Zilla::Chef - Cook your distributions with Dist::Zilla

# VERSION

version 0.001

# DESCRIPTION

Dist::Zilla::Chef is a suite of [Dist::Zilla](http://search.cpan.org/perldoc?Dist::Zilla) commands and plugins
that help you build & test your dist AND all of its dependencies.
The idea is to use Dist::Zilla to establish a workflow for managing
and testing dependencies while your dist grows and evolves.

Dist::Zilla::Chef relies on [Pinto](http://search.cpan.org/perldoc?Pinto) to create and manage a local
CPAN-like repository containing a snapshot of all the prerequisites
that are required by your dist.  As your code evolves, you can
perodically load the repository with any additional prerequisites that
your dist needs.  At any time, you can build your dist and all of
its dependencies in isolation, thus giving you a full test of your
entire code stack.

This is alpha code.  It is just a proof of concept.  It could even be
a disproof of concept.  You have been warned.

# WHY IT IS CALLED CHEF

In some ways, creating a dist is like cooking food, and you are the
chef.  Your dist has many "ingredients" (dependencies).  We store
these ingredients in a "pantry" (Pinto repostiory).  When we are
hungry for some code, we "bake" (build) our dist by combining it with
all of the necessary ingredients.

I know, this metaphor isn't perfect.  But I needed a coherent set of
names for these command plugins.  The cooking metaphor seemed
reasonable.  Who knows, maybe it will get some traction.

# HOW TO BECOME A CHEF

Here's the general process for using the Dist::Zilla::Chef commands.  First,
suppose we are going to make a new distribution call Frobulator.  So we're
going to use [dzil](http://search.cpan.org/perldoc?dzil) to create the basic structure for us...

    dzil new Frobulator

Now we need to write some code.  So let's add a function to the Frobulator
class...

    # in lib/Frobulator.pm
    package Frobulator;

    use autodie;

    sub blazo { ... }

Notice that 

# SUPPORT

## Perldoc

You can find documentation for this module with the perldoc command.

    perldoc Dist::Zilla::Chef

## Websites

The following websites have more information about this module, and may be of help to you. As always,
in addition to those websites please use your favorite search engine to discover more resources.

- Search CPAN

The default CPAN search engine, useful to view POD in HTML format.

[http://search.cpan.org/dist/Pinto](http://search.cpan.org/dist/Pinto)

- CPAN Ratings

The CPAN Ratings is a website that allows community ratings and reviews of Perl modules.

[http://cpanratings.perl.org/d/Pinto](http://cpanratings.perl.org/d/Pinto)

- CPAN Testers

The CPAN Testers is a network of smokers who run automated tests on uploaded CPAN distributions.

[http://www.cpantesters.org/distro/P/Pinto](http://www.cpantesters.org/distro/P/Pinto)

- CPAN Testers Matrix

The CPAN Testers Matrix is a website that provides a visual way to determine what Perls/platforms PASSed for a distribution.

[http://matrix.cpantesters.org/?dist=Pinto](http://matrix.cpantesters.org/?dist=Pinto)

- CPAN Testers Dependencies

The CPAN Testers Dependencies is a website that shows a chart of the test results of all dependencies for a distribution.

[http://deps.cpantesters.org/?module=Dist::Zilla::Chef](http://deps.cpantesters.org/?module=Dist::Zilla::Chef)

## Bugs / Feature Requests

[https://github.com/thaljef/Pinto/issues](https://github.com/thaljef/Pinto/issues)

## Source Code



[https://github.com/thaljef/Pinto](https://github.com/thaljef/Pinto)

    git clone git://github.com/thaljef/Pinto.git

# AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.