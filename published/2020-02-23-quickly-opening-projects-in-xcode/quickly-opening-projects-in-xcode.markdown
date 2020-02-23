# Quickly Opening Projects in Xcode

I’ve used a little utility called [`x`](https://github.com/soffes/dotfiles/blob/master/bin/x) for several years now. Simply running `x` in a directory will open the directory in Xcode. Here’s an example:

    $ cd my_project
    $ x

Now the project is open in Xcode. So quick!

I just extended it to support Swift packages that don’t have a project since that works so well now.

The code is [available on GitHub](https://github.com/soffes/dotfiles/blob/master/bin/x). Here’s an easy way to install it:

    $ mkdir -p ~/bin
    $ curl -L https://github.com/soffes/dotfiles/raw/master/bin/x > ~/bin/x
    $ chmod +x ~/bin/x

Make sure `~/bin` is in your `$PATH` (here’s a [guide](https://linuxize.com/post/how-to-add-directory-to-path-in-linux/) on that). Now you’re good to go. Enjoy!
