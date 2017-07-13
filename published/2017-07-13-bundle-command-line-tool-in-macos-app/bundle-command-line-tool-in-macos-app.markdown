# Bundle Command Line Tool in macOS App

I spend a lot of time in Terminal. There are several things that I’ll reach for in Terminal before something like Spotlight or Alfred. Here’s an example:

    $ c so<tab>/bl<tab>
    # cd ~/Code/soffes/blog
    $ s

The `s` alias is [defined as](https://github.com/soffes/dotfiles/blob/master/.zsh/aliases.zsh#L21):

    subl .

This simply opens the current directory in Sublime Text, my editor of choice. ==I really love how fast this let’s me get started on something.== I first ran into this pattern with TextMate’s `mate` command. So great.

For [Whiskey](https://usewhiskey.com), (a text editor I used to work on in my free time) I included a command line tool that did the same thing as the `subl` command. Super convenient for people that are used to this workflow and wanted to do that with Whiskey.

## Building a Command Line App

Creating a command line app is really simple. It’s just a binary so you can’t bundle resources or frameworks. You can link frameworks with a path (maybe something like `../../Frameworks` inside your app bundle), but that can be fragile in case someone moves your binary and it breaks the paths. I generally make command line tools call to the main app or statically link any shared code to avoid this.

First, you’ll need a new target. Simply choose the *Command Line Tool* macOS template. Now put whatever you want in this target. ==To print things to Terminal, simply use `print` in Swift. Easy enough.==

## Bundling Your App

In your command line tool’s target, change *Skip Install* to *Yes*. This will ensure your archive contains only a Mac app since we are going to bundle it ourself. If you don’t do this, you won’t be able to upload your archive to the App Store, sign for Developer ID, etc.

Next, in your Mac app, add the command line tool as one of the *Target Dependencies*. Create a *New Copy Files Phase* and name it something like *Embed Command Line Tool*. Set the destination of the copy phase to *Shared Support*. Now click the + under the file list in the phase and select your binary from the *Products* group in your project. That’s it!

Now when you build your app, the command line tool will automatically be built and copied into your bundle. You could provide some UI for copying it or updating their path to include it for the user.

Enjoy.