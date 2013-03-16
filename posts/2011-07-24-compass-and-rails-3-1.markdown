---
title: Compass and Rails 3.1
tags: [compass, css, development, rails]
---

Here's how I finally got Compass working with Rails 3.1rc4 (with includes, sprites, etc).

Gemfile excerpt:

``` ruby
gem 'sass-rails', :git => 'https://github.com/rails/sass-rails.git', :ref => '031236b31eaf20658226a9ae051749cc6647c33f'
gem 'compass', :git => 'https://github.com/chriseppstein/compass.git', :ref => '2c1fcfcad708875d10db65740aabf417abc636a6'
gem 'sprockets', '2.0.0.beta.10'
```

config/compass.rb excerpt:

``` ruby
http_images_path = '/assets/'
```

**That's it.** You don't have to do any of the crazy initializer hacks or anything like that. (If you were doing that, you can remove it all). The rest of my Gemfile and compass.rb are just standard stuff. Here's my [full compass.rb](https://gist.github.com/1103112#file_full_compass.rb) if that helps though.

The only other thing you'll need to do is be sure all of your stylesheets are in `app/assets/stylesheets/` and end in `.css.scss` or `.css.sass`. Eventually you won't have to include the `.css` part if you don't want to, but for now, it's required (due to Sprockets).

Big thanks to [Jon McCartie](http://twitter.com/jmccartie) and [
Chris Eppstein](http://twitter.com/chriseppstein) for all of their help!

### Update: Rails 3.1.0.rc5

Rails 3.1.0.rc5 just came out. Here's the updates for rc5.

Gemfile excerpt:

``` ruby
gem 'sass-rails', :git => 'https://github.com/rails/sass-rails.git', :ref => '231b14da040c3ad320076cbaaa70190d14b95d37'
gem 'compass', :git => 'https://github.com/chriseppstein/compass.git', :ref => '33263caffe5548a64253976c0a034afe1ed567f4'
```

**That's it!** Your compass.rb remains the same as before with `http_images_path`. You don't need to add `.css` to partials' file names any more now!
