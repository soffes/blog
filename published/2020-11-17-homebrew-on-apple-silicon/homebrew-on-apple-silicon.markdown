# Homebrew on Apple Silicon

Today, my new 13-inch MacBook Pro arrived! I was super excited to get it out of the box and set it up. This thing is fast! I am already very impressed. When I started setting up my development environment, things started to get a little frustrating. Have no fear, it’s solvable!

The biggest issue for me was [Homebrew](https://brew.sh). According to [this issue](https://github.com/Homebrew/brew/issues/7857) “There won’t be any support for native ARM Homebrew installations for months to come.” No big deal though. ==Homebrew can work just fine with Rosetta 2== and some things work natively.

## Using Rosetta 2

Rosetta 2 is Apple’s translation later. This lets you run Intel things with a little overhead. In Terminal, you can run any process with Rosetta by prefixing it with `arch -x86_64`.

To get Homebrew working, let’s install it using Rosetta:

```
$ arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

This command is the standard installer from [brew.sh](https://brew.sh) with the Rosetta prefix. This will setup Homebrew in `/usr/local`. Now whenever you want to interact with it, you can run `arch -x86_64 brew …`. Easy enough!

If you want to wait for official support for Apple Silicon, feel free to stop reading here.

## Multiple Homebrews

Homebrew does sorta work on Apple Silicon. See [this issue](https://github.com/Homebrew/brew/issues/7857) for the current status. OpenJDK and Go don’t work as of this writing and that blocks a lot of things. I was able to get Postgres, Redis, ImageMagick, rbenv, etc. all working natively though! To do this, you’ll need a second Homebrew.

Homebrew for Apple Silicon is expected to be installed in `/opt/homebrew` instead of the `/usr/local` you’re expecting. Let’s get that set up:

```
$ sudo mkdir -p /opt/homebrew
$ sudo chown -R $(whoami):staff /opt/homebrew
$ cd /opt
$ curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
```

This creates a new directory, setups the right permissions, and downloads Homebrew.

Be sure to add `/opt/homebrew/bin` to your `$PATH`!

Now if you run plain `brew` you get this one in `/opt/homebrew`. You can run `arch -x86_64 brew` to get the Rosetta one in `/usr/local`.

My workflow is trying to `brew install` like normal and if it fails prefix with `arch -x86_64` and try again. As long as you only install it with one of them, you don’t need to prefix things you’ve installed when you run them. Pretty great!

---

**Disclaimer:** This is as of 2020-11-17. Things are surely going to change. Follow along in [this issue](https://github.com/Homebrew/brew/issues/7857) for the latest from the Homebrew team.
