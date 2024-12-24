# Ruby on Apple Silicon

I’ve been using [Homebrew on Apple Silicon](https://soffes.blog/homebrew-on-apple-silicon) for a few weeks now and it’s been working well.

With Ruby 3.0.0, I haven’t had any issues installing it with [rbenv](https://github.com/rbenv/rbenv). Today, I needed to install an older version and had some trouble getting it. Here’s what I did to figure it out. (This assumes your Homebrews are setup like I described in [my post](https://soffes.blog/homebrew-on-apple-silicon).)

First, install rbenv with your native Homebrew:

``` sh
$ brew install rbenv
```

If you already have readline installed, you’ll need to uninstall it while installing the old Ruby:

``` sh
$ brew uninstall --ignore-dependencies readline
```

Now we’ll need to install OpenSSL with the Rosetta Homebrew:

``` sh
$ ibrew install openssl
```

Finally, we can use Rosetta to install an older Ruby (in my case, 2.7.2). This uses Rosetta when building and makes sure it uses the Rosetta version of OpenSSL you installed with `ibrew`.

``` sh
$ RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(ibrew --prefix openssl)" arch -x86_64 rbenv install 2.7.2
```

If you are using Nokogiri, you’ll have some issues with the Ruby you just installed. Here’s how to get it working:

``` sh
$ ibrew install libxml2
$ gem install nokogiri -- --use-system-libraries --with-xml2-include=$(ibrew --prefix libxml2)/include/libxml2
```

If you’re still having trouble with Nokogiri, checkout their normal [installation guide](https://nokogiri.org/tutorials/installing_nokogiri.html).

Now, reinstall readline if you uninstalled it above:

``` sh
$ brew install readline
```

Kind of a pain, but the speed of your fancy new Mac is worth the hassle, right?
