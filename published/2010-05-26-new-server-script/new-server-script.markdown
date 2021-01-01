---
tags:
- development
---

# New Server Script

I've found myself setting up lots of servers over at [RackSpace Cloud](http://rackspacecloud.com) lately. It seemed look a good idea to automate everything instead of leaving it up to myself to remember everything you have to do each time.

I wrote [this little shell script](http://gist.github.com/314865) to make life easier. It installs everything I need to run a Ruby on Rails app in a matter of minutes. It's designed to work with Cent OS 5.4+. Here's the script's main tasks:

* Install Git 1.7.1.1
* Install Ruby 1.8.7p299
* Install  RubyGems 1.3.7
* Install  Passenger 2.2.15
* Install  Nginx 0.8.45 (with Passenger and SSL modules)
* Install  Postgres 8.4.4
* Initialize Postgres
* Install  ImageMagick 6.6.3-0
* Install  Bundler (latest)
* Open port 80 in iptables
* Open port 443 in iptables
* Start Nginx
* Start Postgres

For me, that's enough to get the bare bones of an app running. The rest, I let [Bundler](http://gembundler.com/) handle for me. I use this on all of my servers that I manage.

## Let's get started already

All you have to do to setup your new server is run the following one line:

```sh
$ wget http://gist.github.com/raw/314865/new_server.sh;chmod +x new_server.sh;./new_server.sh
```

You'll have to press `y` twice at the beginning when yum asks you to install some stuff. After that, you can let it do its thing.

## Configuration

It's super easy to add a new Nginx virtual host. All you have to do is add a file with the `.conf` extension to `/usr/local/nginx/conf/virtual_hosts/`. Here's a good [example virtual host](http://gist.github.com/314883#file_example.conf). Of course, you can configure any of the installed stuff like you normally would. My [nginx.conf](http://gist.github.com/314883#file_nginx.conf) just makes setting up virtual hosts easy. After you edit any of the Nginx configuration files, you'll want to run `service nginx reload` to apply your changes.

## One more thing

There's also [another little script](http://gist.github.com/314865#file_z_after.sh) that I run after the main one that is more specific to my needs. This little guy creates `/var/www/`, setups the proper permissions, and installs some database related gems. You can run it with the following one line:

```sh
$ wget http://gist.github.com/raw/314865/z_after.sh;chmod +x z_after.sh;./z_after.sh
```

**Updated 07/13/10:** Bumped versions of packages and fixed ImageMagick
