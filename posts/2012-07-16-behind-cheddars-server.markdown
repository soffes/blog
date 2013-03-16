---
title: Behind Cheddar's Server
tags: [cheddar, development, heroku, rails, ruby]
---

So, [tech doesn't matter](http://samsoff.es/posts/cheddar-lessons-so-far). Tech is interesting though. Here's some of what I use to make Cheddar's server. A lot of Cheddar is on the server. I've spent way more time writing Ruby than writing Objective-C when it comes to Cheddar.

The Cheddar web app is written in [Ruby on Rails](http://rubyonrails.org). I choose Ruby on Rails because I already have a lot of experience with it and it let's me work quickly. 

For awhile, the API and the web app were two separate Rails apps. The web app simply used the API. This quickly became hard to manage and test. I ended up merging them back together before launching. The API is still very separate from the web app. At some point, I would like to split it out once I have more time to work on my internal tools.

All of the realtime aspects are powered by [Pusher](http://pusher.com). I considered building something from scratch to do all of this, but was focused on shipping. At some point, it would be easy for me to replace Pusher with my own stuff, but honestly they are awesome and very affordable. I doubt I ever will.

All of the API documentation I did from scratch. I wrote a little Ruby gem to do code coloring and truncation of example responses the way I wanted called [Pizzazz](http://github.com/samsoffes/pizzazz). I really love [Stripe](http://stripe.com)'s API documentation. They use your real data in all of the examples and give you example commands for each method. It was actually a lot easier than I thought to implement this and people seem to really like it.

All of the [OAuth](http://oauth.net/2) stuff I did from scratch as well. There are a few solutions out there but I started to spend more time customizing them than it would take to write my own. I've written OAuth clients and servers before so it wasn't a big deal.

The tasks and lists view uses [Backbone.js](http://backbonejs.org) (in conjunction with Pusher) to make everything feel really instant. All of the JavaScript for Cheddar is written in [CoffeeScript](http://coffeescript.org) and all of the CSS is written in [SCSS](http://sass-lang.com).

Here's my [Gemfile](http://gembundler.com/man/gemfile.5.html). I added lots of comments so you can see what everything is for.

``` ruby
source 'https://rubygems.org'

# The latest version of Ruby
ruby '1.9.3'

# The lastest version of Rails
gem 'rails', '3.2.6'

# Postgres
gem 'pg'

# EventMachine-based web server
gem 'thin'

# Backbone adapter
gem 'backbone-on-rails'

# Easily send Ruby to JavaScript in views
gem 'gon'

# Hashtag and autolink parsing
gem 'twitter-text'

# Emoji detection
gem 'named_emoji'

# Encrypt passwords
gem 'bcrypt-ruby'

# Sending email
gem 'postmark-rails'

# Ordering of lists and tasks
gem 'acts_as_list'

# Easy seeding of the database without duplicates
gem 'seed-fu'

# Payment processor
gem 'stripe'

# Used for list slugs
gem 'base32-crockford', require: 'base32/crockford'

# Networking. Mainly for verifying iTunes receipts
gem 'httparty'

# Memcache client. Used for various caching
gem 'dalli'

# Key-value store client. Used for some caching
gem 'redis'

# Pretty API docs
gem 'pizzazz'

# Sidekiq queueing system and dependencies
gem 'sidekiq'
gem 'slim'
gem 'sinatra', :require => nil

# Pusher and dependencies
gem 'em-http-request'
gem 'pusher'

# For the Asset Pipeline
group :assets do
  # Pre-release of SASS for @media
  gem 'sass', '>= 3.2.0.alpha.261'

  # SASS Rails integration
  gem 'sass-rails'

  # SASS awesome mixins
  gem 'bourbon'

  # Simple CSS grids
  gem 'grater'

  # CoffeeScript Rails integration
  gem 'coffee-rails'

  # jQuery
  gem 'jquery-rails'

  # JavaScript compressor
  gem 'uglifier'
end

# Only used in development
group :development do
  # Manage multiple processes
  gem 'foreman'

  # Heroku and dependencies
  gem 'heroku'
  # gem 'taps'
  # gem 'sqlite3'

  # Open emails in development
  gem 'letter_opener'

  # Hide asset requests from developmenet logs
  gem 'quiet_assets'

  # Scan for security issues
  gem 'brakeman'
end

# Only used for testing
group :test do
  # Simple factories
  gem 'miniskirt', require: false

  # Generate dummy data
  gem 'faker'

  # Fantastic tests
  gem 'minitest'

  # Color test output
  gem 'minitest-wscolor'

  # Test Rack requests
  gem 'rack-test', require: false

  # Mock external libraries
  gem 'mocha', require: false

  # Simulate the browser
  gem 'capybara', require: false

  # Work with cookies while testing
  gem 'show_me_the_cookies'

  # Test coverage analysis
  gem 'simplecov', require: false

  # Simple test runner (my fork fixes MiniTest integration)
  gem 'm', git: 'https://github.com/samsoffes/m.git', require: false
end

# Only used in production
group :production do
  # Reporting
  gem 'newrelic_rpm'

  # Easy SSL redirection for certain paths
  gem 'rack-ssl-enforcer'

  # Exception reporting
  gem 'exceptional'

  # Limit requests to 30 seconds
  gem 'rack-timeout'
end
```

Everything is hosted on [Heroku](http://heroku.com). I use [Heroku Postgres](http://postgres.heroku.com) for the database, their memcached add-on, and the [RedisToGo](http://redistogo.com/) add-on. Here's a recent post about [lessons learned while scaling](http://samsoff.es/posts/scaling-cheddar).
