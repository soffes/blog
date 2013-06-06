---
title: Clean Up Your Project
tags: [cocoa, development, ios, rake, ruby, scribd]
---

Many of the apps I work on are usually 100% custom. There is rarely any system UI components visible to the user. Styling the crap out of apps like this makes for tons of images in my iOS projects to get everything the way the designer wants. I'm starting to `drawRect:` stuff more these days because it makes it easier to reuse, but anyway.

There are literally hundreds of images in the [Scribd](http://samsoff.es/posts/im-moving-to-san-francisco) app I've been working on. Designers changing their mind plus everything custom leaves a lot of images behind that are no longer used. Our application was starting to be several megs and a lot of it was unused images. So... being the programmer I am, ==I wrote a script==.

``` ruby
desc 'Remove unused images'
task :clean_assets do
  require 'set'

  all = Set.new
  used = Set.new
  unused = Set.new

  # White list
  used.merge %w{Icon Icon-29 Icon-50 Icon-58 Icon-72 Icon-114}

  regex = /\[UIImage imageNamed:@"([a-zA-Z0-9\-_]+).png"\]/
  Dir.glob('Classes/*.m').each do |path|
    used.merge File.open(path).read.scan(regex).flatten
  end

  Dir.glob('Resources/Images/*.png').each do |path|
    next if path.include? '@2x.png'
    all << path.gsub(/Resources\/Images\/([a-zA-Z0-9\-_]+).png/, "\\1")
  end

  unused = all - used
  unused.each do |key|
    `rm -f Resources/Images/#{key}.png Resources/Images/#{key}@2x.png`
  end

  puts "#{all.length} total found"
  puts "#{used.length} used found"
  puts "#{unused.length} deleted"
end
```

It basically searches all of your source files for references for `[UIImage imageWithName:@"image_name_here"]`. Then it looks at all of the images on disk and removes any you didn't reference. I setup a whitelist for icons and other images I don't reference directly. You might need to tweak the paths a bit to work for your setup.

Hopefully this little [rake task](http://railscasts.com/episodes/66-custom-rake-tasks) helps someone clean up their project too.
