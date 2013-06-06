---
title: RubyMotion Review
tags: [development, objective-c, ruby]
---

[RubyMotion](http://www.rubymotion.com) was released today. ==RubyMotion lets you write iPhone and iPad apps in Ruby.==

> RubyMotion is a revolutionary toolchain for iOS. It lets you quickly develop and test native iOS applications for iPhone or iPad, all using the awesome Ruby language you know and love.

### Background

It's a very exciting new product from [Laurent Sansonetti](http://twitter.com/lrz), the creator of [MacRuby](http://macruby.com). He was at Apple working on MacRuby full-time, but decided to leave and do his own thing. This is what he made.

### Initial Reaction

After paying the $149.99 for RubyMotion, I was excited to try it out. The installation process was super easy. There was a small issue with it not finding my version of Xcode right away, but I have a pre-release version, so that's understandable.

==I got my first app up and running in less than a minute== (once I got my Xcode issues sorted out). Already way impressed.

### Ruby Instead of Objective-C

Writing Ruby code like this is amazing.

```ruby
@window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
@window.makeKeyAndVisible
```

Here's the same code in Objective-C

``` objective-c
self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
[self.window makeKeyAndVisible];
```

Here's another example. Ruby code:

``` ruby
navigationBar = UINavigationBar.appearance
navigationBar.setBackgroundImage(UIImage.imageNamed('nav-background.png'), forBarMetrics: UIBarMetricsDefault)
navigationBar.setTitleTextAttributes({
  UITextAttributeFont: UIFont.cheddarFontWithSize(24.0),
  UITextAttributeTextShadowColor: UIColor.colorWithWhite(0.0, alpha:0.4),
  UITextAttributeTextColor: UIColor.whiteColor
})
```

Objective-C:

``` objective-c
id navigationBar = [UINavigationBar appearance];
[navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-background.png"] forBarMetrics:UIBarMetricsDefault];
[navigationBar setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
  [UIFont cheddarFontWithSize:24.0f], UITextAttributeFont,
  [UIColor colorWithWhite:0.0f alpha:0.4f], UITextAttributeTextShadowColor,
  [UIColor whiteColor], UITextAttributeTextColor,
  nil]];
```

I'm totally in love with the Ruby syntax over Objective-C. Also, ==I'm really looking forward to using mixins==. Categories are also awesome. Want to add a method to a class? Just open the class and add it:

``` ruby
class UIColor
  def self.cheddarTextColor
    self.colorWithWhite(0.267, alpha:1.0)
  end
end
```

### Build Settings

The way the build system works in RubyMotion might be my favorite thing. It's just a rake task, and it's amazing.

I have custom fonts in the application I was working on. I figured this would be annoying to figure out how it wants me to tell it that I'm using a custom font. After reading the [RubyMotion docs](http://www.rubymotion.com/developer-center/guides/project-management#_configuration), I ran `rake config` to see the current configuration. ==It already had the correct configuration!== RubyMotion detected that I added a font file to my resources folder and added the appropriate configuration for me. Amazing.

Here's an excerpt of my Rakefile:

``` ruby
Motion::Project::App.setup do |app|
  app.name = 'Cheddar'
  app.interface_orientations = [:portrait]
  app.prerendered_icon = true
  app.icons = %w{Icon-29.png Icon-50.png Icon-57.png Icon-58.png Icon-72.png Icon-100.png Icon-114.png Icon-144.png}
end
```

I totally love this. This is a million times better than fighting with Xcode's clunky UI for configuring all of these options. I also really like that RubyMotion gives you access to edit whatever Info.plist or build settings you want.

You can just run `rake config` to see the entire configuration of your application. For anything you want to change, you just add the option in the Rakefile. Such a great way to do it.

### Console

==The [REPL](http://en.wikipedia.org/wiki/Read–eval–print_loop) (read-eval-print loop) is hands down the most amazing part of RubyMotion.== It's even more advanced than Apple's tools here. [Watch the demo](http://www.rubymotion.com/getting-started/) to understand how awesome it is.

You can command-click a view on the screen and then it becomes `self` in the console. Say you command-click a UILabel in the simulator. You can type the following command:

``` ruby
>> self.text = 'Awesome'
```

and see label's text updates immediately.

I was trying to see if some fonts were being loaded in my RubyMotion application. Normally, I would add some logs to the beginning of my application delegate to see what's going on. I realized I had a console, so just typed what I was going to log in the console. There was the output immediately. Amazing.

### Testing

I'm also really looking forward to testing with Ruby tools. The Objective-C community rarely tests stuff. The Ruby community is all about it. My theory is that's due to the compiled nature of Objective-C. Anyway, I'm really excited to use [MiniTest](http://docs.seattlerb.org/minitest/) to test my apps. The RubyMotion documentation is a bit lacking here at the moment.

### Final Thoughts

I am quite confident that if Laurent had stayed at Apple, we wouldn't have anything close to this today for two reasons. Apple is heavily invested in Objective-C. Objective-C is fantastic. Apple has been using it for years and years. It's not "broken" per se. Secondly, I think the main reason is this is a lot of new stuff. Apple is a giant company. Stuff like this would take a ton of effort navigating internal politics to pull off. ==I'm glad he left and made it a reality.==

==I really like the build system, configuration, and writing Ruby.==

I plan on converting [Cheddar](http://cheddarapp.com) to RubyMotion in my free time. I doubt I'll ship a RubyMotion version anytime soon, but I'm not opposed to the idea. ==Overall, RubyMotion is great. It means more people on the iOS platform, which is a good thing.==
