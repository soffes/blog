---
title: How to Install Ruby 1.9.3
tags: [development, ruby]
---

I'm a fan of living on the edge. Ruby 1.9.3 [just came out](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-core/40527) today. It's apparently really stable as well!

> We've been running it in all our 1.9 deployments for GC tuning + require speed fix.
>
> — [David Heinemeier Hansson](https://twitter.com/dhh/status/130731723750244352)

### Installing rbenv

Installing Ruby 1.9.3 is easy. My preferred approach is using [rbenv](https://github.com/sstephenson/rbenv) and [ruby-build](https://github.com/sstephenson/ruby-build) by [Sam Stephenson](https://github.com/sstephenson) (great name, I know). rbenv makes it easy to have multiple versions of Ruby on your system (and in a much cleaner way than [rvm](http://beginrescueend.com/)).

If you are running Xcode 4.2, you'll need to install GCC since Xcode no longer ships with [GCC](http://gcc.gnu.org/) (in favor of the far superior [LLVM](http://llvm.org/)). You can download an installer [here](https://github.com/kennethreitz/osx-gcc-installer/downloads). Once you get GCC installed, you can run the following commands to get rbenv and ruby-build installed. You'll need Homebrew if you don't already have it. (I **highly** recommend it.)

``` bash
$ brew update
$ brew install rbenv
$ brew install ruby-build
```

You can also use [my dot files](https://github.com/samsoffes/dotfiles) or [install without Homebrew](https://github.com/sstephenson/rbenv#section_2.1) instead if you'd like.

### Installing Ruby

Once you have rbenv and ruby-build installed, you can run the following command to get Ruby 1.9.3 installed.

``` bash
$ rbenv install 1.9.3-p125
```

==Easy as that!== It will take a few minutes to download everything and compile. Now if you'd like to use 1.9.3 by default, you can run the following command:

``` bash
$ rbenv global 1.9.3-p125
```

Done! Now enjoy the and improved Ruby on your system! It's greatly improved over Ruby 1.9.2 with some nice speed improvements. If you have any problems with your new setup, I'd recommend reading over the [rbenv readme](https://github.com/sstephenson/rbenv#readme).
