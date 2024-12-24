# Automating Simple Things

Most of my projects contain a Rakefile with some common tasks. [rake](https://ruby.github.io/rake/) is Ruby’s tool for running tasks. It’s my tool of choice for little scripts, but you could of course do whatever you want. My friend [Ayaka](https://twitter.com/ayanonagon) even did a talk on [scripting with Swift](https://news.realm.io/news/swift-scripting/)!

Usually my scripts are for something tedious that can be easily automated. Here’s a few examples in my own projects:

## Gather Dependencies

Some of the most elaborate scripts I’ve written in projects have been to automate gathering dependencies. This can be complicated depending on your setup. My goal is always for someone that isn’t a developer to clone, run the command, open Xcode, and build. That may seem like overkill, but if you make it that easy, you make it that easy for yourself and teammates which saves a ton of time.

The key to making it this easy is being really vigilant about errors and handling everything that could go wrong with a helpful error message.

For example, let’s say we’re using [Carthage](https://github.com/carthage/carthage) for our project. You could first check that they have it installed. If they don’t prompt them to install it and exit. Now you can run the command to bootstrap the project with Carthage. You usually want to specify the platform to save time and some other options. Instead of a long readme with lots of instructions a simple, “run this script” is far superior in my opinion.

## Distribute a Beta Build

This is probably the biggest time saver you can do as an iOS developer. Making a build and uploading to TestFlight can be really time consuming. I’ve used [Fastlane](https://fastlane.tools) for this in the past, but there can be some setup involved to get it going though.

I usually wrap all of this in a rake task to take away any thoughts. For example, you might have to install dependencies first or deal with provisioning, etc. You can do all of that in the task since it might not be appropriate to do this in the Fastlane lane.

For Mac apps, I’ll usually have the task build the app, sign it for Sparkle, and print the entry to use my appcast.xml. All of that is easy enough to do on your own, but automating it away behind on task is such a time saver.

## Blog Posts

I have a [git repo](https://github.com/soffes/blog) with all of my blog posts. I recently added a few tasks to this repo too. They are already saving me tons of time.

``` sh
$ rake new "Thoughts About Things"
```

This simply checks to make sure the title is unique, makes a new folder, markdown file in that folder, and opens it in [Whiskey](http://usewhiskey.com). Takes all of the friction away from creating a post. I have a lot of posts in this repo. Even just making a new folder and scrolling to it is pretty tedious. Problem solved!

``` sh
$ rake recent
```

It’s fairly common that I have a typo in a post or start writing one and then leave to go finish something else. Same thing for opening the most recent. It’s a few seconds to find it and open it in my editor. ==Automating this away helps me write more.==

Anyway, hopefully this inspires you to automate some stuff and save yourself some time!
