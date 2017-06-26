---
tags:
- video
- screencast
---

# How to Build a Ruby Gem

This is my first post on the [Treehouse Blog](http://blog.teamtreehouse.com). I did an 8 minute video tutorial on how to make a Ruby gem with Bundler. Check it out.

<div class="video vimeo wide"><iframe src="
https://player.vimeo.com/video/63605506?title=0&amp;byline=0&amp;portrait=0&amp;color=f05b35" width="640" height="360" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe></div>

The code from this video can be found here: [github.com/soffes/adder](https://github.com/soffes/adder). Here is Ruby's [module_function documentation](http://ruby-doc.org/core-2.0/Module.html#method-i-module_function).

## Video Transcription

Hi, I’m Sam Soffes. I’m going to show you how to create and distribute a Ruby Gem. So, let’s say you have some really fancy code that adds 2 numbers together. We’re going to package this up into a Ruby Gem called Adder and you shoot it on Rubygems.org, so anyone can Gem install Adder and use our code. First off, you’ll need Bundler. If you don’t already have Bundler, you can easily install it with Gem install bundler. Now, simply Run, Bundle, Gem, and the name of your Gem. So, in this case, Adder. Great, and you can see here it generated a bunch of files for our Gem so, we’ll open this up in Sublime and try it out. So, most importantly it generated a Gem spec for us. and you can see it has some placeholder values. I’ll go ahead and fill this in. It’s a good idea to add a required Ruby version, that way if you’re using features that aren’t available in 187 or 192 or whatever, Rubygems won’t let you install it on a Ruby that’s not supported. Kind of on a side note, if all you’re using 19 for is the hash syntax, it’s a good idea to go ahead and use the old 187 syntax, so more people can use your code. I really prefer the 19 syntax, but I usually end up switching, just so I can support 187. If that’s the only change, no reason not to.

Anyway, you can see it made a Gem file and all it does is import your Gem spec, so because your Gem spec has Bundler and Rake and such, it will automatically add these to your Gem file using this line. You can see I went ahead and generated the MIT license, which is a really great open source license. It basically means anyone can do whatever they want with your stuff, which is pretty great. It also generated a rake file for us, we’ll get to this in a bit, and then a really nice placeholder “Readme” So you should definitely fill in your stuff when you get a chance. So you can see here in the live folder, it generated Adder to RB and it says Your code goes here’ [inaudible 01:59] and here it imports Adder version.

So, everything in your gem should go in a module. So, in this case it’s just Adder. It usually should match the name of your Gem for some auto-loading conventions. In Adder version, it just sets a constant called version. This is kind of a convention adapted from the generated Gem spec
here that will just pull in your current version. So, that’s real handy. You probably shouldn’t really do anything else with this file except bump the version whenever you’re releasing something new.

So, here we’ll just go ahead and make a new module method called Add. It’s going to take 2 parameters and we’ll just add them together.

So, the easiest way to try out your Gem without pushing it to Rubygems or installing it locally, you should just hop in the console. Bundler adds a really nice thing called Bundle Console, which by the way, this works anywhere, not just in a gem you create. So, now we can call Adder, Add, and Caller code, so you can do 2, 3, you should get 5. Awesome, it works. So, that’s really handy for trying out. Obviously, you should add some tests and cover that in a future post.

So, we verified that our Gem works, and we’re ready to show the world how to use our awesome Gem. First, we’ll just go ahead and commit our code. Now that we’ve committed, we can run Rake minus T, which is just a standard rake command for showing all the tasks available. So, you can see that Bundler has gone ahead and added 3 tasks for us; Build, Install, and Release. So, we’re going to go ahead and build our Gem, which is going to build version 001, and now we can just run Rake, Release, and it will fill, because we haven’t set up a Git remote yet. Because it expects you to have a remote for your project. So, Rake, Release will automatically tag your commit for that version and push it to your master, and then release it to Rubygems.

So, I’m going to go ahead and set this up on Github, and re run the command. So, you can see that it tagged it and failed again, and this is because we haven’t set up our Rubygems.org credentials. So, we just do Gem, Push to set this up, and it’s going to say you don’t have a Rubygems.org account. So, you can either go to Rubygems org/signup to make an account, so I’m just going to fill in my credentials, and now we’ve got an error saying that Gem push failed, which is what we wanted. we just wanted to sign in here. So, this is all stuff you have to do just the first time. Every time after this it’s really easy, so we’ll go ahead and do Rake,
Release again and see it tagged it and now its uploading it to Rubygems.org, and it pushed it. We can open up Safari and head to Rubygems.org/gem/adder, and see our Ruby Gem, you can see this pulled from our Gem spec. This is set up from our license file. It’s my avatar there, since I’m the owner. So, anyone can Gem install Adder and install our Gem, I’ll show you quickly how to update your Gem once you’ve got it published. We’ll head back over to Sublime.

So, lets say you wanted to make this available as a instance or class method so you can include Adder and have the add method, or you can just do Adder. Add. So, there’s a really nice Ruby thing called Module Function that this is force [sounds like 05:59] This basically does the same thing for both versions. I’ll put a link to the documentation if you’re curious how this works specifically. Again, we’ll just test this out real quick in the console. Again, you should obviously write test but for now, but I’ll just do it real quick. Adder, Add or we can just do 1 and 2 and get 3 or we can include Adder and just call Add. I’ll say 4,5,6 and get 11, so you can see both versions work, which is pretty cool. So, we’ll go over here to our version file and we’ll bump the version. Check out simver.org for more on how you should structure your version strength. Semantic versioning is really important in the Ruby community.

So, now that I have this new version, I can run status and see I’ve changed 2 files. We’ll go ahead and commit them. We’ll run Rake, Build again and it’s going to build version 002. We’ll run Rake Release and see its going to tag and get version 002 and it’s going to push it to Github and then it’s gonna push it to Rubygems. There we go, so if we head over to Rubygems.org and reload the page, you can see now 002, and here’s our version history. There we go. We can also head over to Github, right here. That’s again set in our Gem spec and we can see tags right here, and here are our two tags that Bundler created for us in that Rake task. So, pretty great.

Obviously, you should fill in these more and show how to use it and other stuff, and definitely have some tests. We’ll cover all that in a future post.

So, go release some code back to the community and enjoy.
