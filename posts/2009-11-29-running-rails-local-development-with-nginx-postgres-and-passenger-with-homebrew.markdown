---
title: Running Rails Local Development with Nginx, Postgres, and Passenger with Homebrew
tags: [development, heroku, homebrew, local-development, nginx, passenger, postgres, rails]
---

**Update 03/03/12:** Nowadays, I recommend using [Foreman](https://github.com/ddollar/foreman) or [Pow](http://pow.cx/). This isn't a horrible approach, but definitely more complicated than I like to have things.

Lately I have been playing with [Homebrew][], an awesome package manager for Mac OS X. I really like not having to worry about dependencies and such when installing. The "rarely sudo" mentality is also pretty great.

When I noticed the [Nginx][] (a sweet open source web server that is way better than Apache) had a `--with-passenger` option (which is also way awesome), I figured I'd give it a shot. I was using the built-in Apache with [Passenger][] [Preference Pane](http://github.com/alloy/passengerpane), which was pretty cool, but I really like Nginx, so I switched. I also really wanted to start using [PostgreSQL][] instead of SQLite since all of my stuff is hosted on [Heroku][] and that's what they're running. (I do plan on writing a Preference Pane for doing for this setup eventually.)

Here are the steps to get all of this going. I tried to keep it as simple and clear as possible with lots of examples. It looks like a lot, but it's really quite simple.

This probably goes without saying, but you'll need [Xcode installed](http://developer.apple.com/technologies/xcode.html) to do all of this.

### Installation

1. [Install Homebrew](http://github.com/mxcl/homebrew#readme) and follow [the steps in the wiki about not sudoing when installing RubyGems](http://wiki.github.com/mxcl/homebrew/cpan-ruby-gems-and-python-disttools).

    If you don't want to do it that way (I highly recommend doing it the above way), you can just run this command to install homebrew.

        $ sudo chown -R $USER /usr/local
        $ curl -Lsf http://github.com/mxcl/homebrew/tarball/master | tar xvz -C/usr/local --strip 1

    You'll need to sudo install gems if you do it this way.

2. Install the [Passenger][] gem

        $ gem install passenger

    I also had to install the `fastthread` gem to get Passenger to play nice later. You might not have to do this. If you need to, all you have to do is `gem install fastthread`.

3. Install [Nginx][] with the [Passenger][] module

        $ brew install nginx --with-passenger

    > You can start Nginx with `sudo nginx` and stop it with `sudo nginx -s stop`.

4. Install [PostgreSQL][]

        $ brew install postgresql

    After the installation completes, there will be instructions on how to initialize the database, start the server, start the server at login, and install the pg gem. ==Do all of this.==

### Server Configuration

1. Modify your Nginx configuration for Passenger. It will be located at `/usr/local/Cellar/nginx/0.7.62/conf/nginx.conf` (obviously you will need to replace the version number with whatever version you installed). Here is what mine looks like.

    ``` nginx
    user samsoffes staff;
    worker_processes 1;

    error_log logs/error.log;

    events {
      worker_connections  1024;
    }

    http {
      include mime.types;
      default_type application/octet-stream;

      # Passenger
      passenger_root /usr/local/Cellar/Gems/1.8/gems/passenger-2.2.7;
      passenger_ruby /usr/local/bin/gem_ruby;
      passenger_default_user samsoffes;

      sendfile on;
      keepalive_timeout 65;

      # Include virtual host configurations
      include samsoffes.conf;
    }
    ```

    There are a few things to note:

    1. I run it as my user (`staff` is my group). You don't have to do this, but I like to have the processes running as me. (If there are more of me, I'm more productive, right?) You'll need to comment this line out or change to your user.

    2. I am pointing the `passenger_root` directive to the passenger root. This will change with whatever version of Passenger you have installed. You can get the current path by running `passenger-config --root` (you'll probably need to do this since the version is in the path).

    3. I also have `passenger_ruby` set to `gem_ruby`. I had a horrible time getting Passenger to see my custom `GEM_PATH` (that I setup by following the [Homebrew wiki](http://wiki.github.com/mxcl/homebrew/cpan-ruby-gems-and-python-disttools)). I created this little shell script to fix the environment variables. It would be great if Passenger had a way to do this. I know you can in the Apache version, but I couldn't figure it out for Nginx. Here is what my `gem_ruby` looks like:

        ``` bash
        #!/bin/bash
        export GEM_PATH=/usr/local/Cellar/Gems/1.8:/System/Library/Frameworks/Ruby.framework/Versions/Current/usr/lib/ruby/gems/1.8/gems
        export GEM_HOME=/usr/local/Cellar/Gems/1.8

        /usr/bin/ruby $*
        ```

2. I like to keep all of my virtual hosts in separate files in the `conf` directory and then include them into `nginx.conf`, but you can do it however you want. Here is what `samsoffes.conf` looks like:

    ``` nginx
    server {
      listen 80;
      server_name samsoffes.local;
      root /Users/samsoffes/code/samsoffes/samsoff.es/public;

      rails_env development;
      passenger_enabled on;

      charset utf-8;
    }
    ```

3. You will need to edit your `/etc/hosts` for any virtual hosts you add. Mine looks like this:

    ```
    ##
    # Host Database
    #
    # localhost is used to configure the loopback interface
    # when the system is booting.  Do not change this entry.
    ##
    127.0.0.1       localhost
    255.255.255.255 broadcasthost
    ::1             localhost
    fe80::1%lo0     localhost
    127.0.0.1       samsoffes.local
    ```

### Database Configuration

1. If you haven't already, edit your application's `database.yml` file to use PostgreSQL. Here is an example:

    ``` yaml
    development:
      adapter: postgresql
      database: samsoffes_development
      encoding: utf8
      username: samsoffes
      password:
      host: localhost

    production:
      adapter: postgresql
      database: samsoffes_production
      encoding: utf8
      username: samsoffes
      password:
      host: localhost

    test:
      adapter: postgresql
      database: samsoffes_test
      encoding: utf8
      username: samsoffes
      password:
      host: localhost
    ```

    Notice that the username is `samsoffes` and not `root`. Using the `root` user is considered bad practice by most. (We'll create that user in the next step.)

2. Enter the PostgreSQL prompt to create your user and databases:

        $ psql  postgres
        # CREATE USER samsoffes SUPERUSER;
        # CREATE DATABASE samsoffes_development OWNER samsoffes;
        # CREATE DATABASE samsoffes_test OWNER samsoffes;
        # \q

    Note: you need to make your user a superuser for your tests to run correctly. More on this [here](http://blogs.law.harvard.edu/djcp/2009/01/rails-22-postgres-and-testing/comment-page-1/).

### Let's get started already!

So, to review, you have just installed and configured Nginx, Passenger, and PostgreSQL. Now, all you have to do is type `sudo nginx` to start Nginx and point your browser to your virtual host (so for me it would be `http://samsoffes.local`). That's it! You're done!

If you forgot to copy the commands out of the PostgreSQL install, here's how to start and stop PostgreSQL:

    # Start
    $ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start

    # Stop
    $ pg_ctl -D /usr/local/var/postgres stop -s -m fast

Before, I found myself typing `sudo apachectl restart` a lot to reload my application. Now, you would run `sudo nginx -s reload` to reload the server configuration and restart the app. (You can of course do the `touch tmp/restart.txt` method as well.)

That probably seemed a bit tedious, but now all you have to do is create a virtual host in Nginx, add it your your hosts file, and create your database. I really like developing locally like this. [Homebrew][] makes this entire process ==very easy==.

If you have any issues, feel free to [send me an email](mailto:sam@samsoff.es) and I'll see what I can do. (I really need to get comments going on here don't I)

[Homebrew]: http://github.com/mxcl/homebrew
[Nginx]: http://nginx.net
[Passenger]: http://modrails.com
[PostgreSQL]: http://postgresql.org
[Heroku]: http://heroku.com
