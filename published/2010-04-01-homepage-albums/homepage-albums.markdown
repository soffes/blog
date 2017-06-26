---
title: Homepage Albums
categories: meta development web ruby
---

I recently added an albums I've been enjoying this week section to my homepage. It's still a major work in progress. For some reason, tons of people have commented about it [on Twitter](http://twitter.com/soffes) asking how I made it, so I thought I'd write a quick post about the tech behind it.

The first thing your probably noticed is the sexy vinyl look. I got this from [Komodo Media](http://www.komodomedia.com/blog/2009/03/sexy-music-album-overlays/) (all of their stuff is awesome, you should check it out). Some simple CSS plus their images and it looks dang sexy.

I'm using the [Last.fm API](http://last.fm/api) to get my listening history. The call to get your top albums for the week doesn't return the album art for that album, so I have to get all of the albums and then get the art for each one. This whole process is pretty slow ([source here](https://github.com/soffes/soff.es/blob/022bec8bd6e8134f944558efeb2b03ac0b0aa4af/lib/tasks/lastfm.rake)) so I shove it in [memcached](http://memcached.org) on [Heroku](http://heroku.com) using the [memcached gem](http://rubygems.org/gems/memcached) so rendering is fast on my homepage.

I setup a cron to nightly rerun the `lastfm:update` rake task from above and update the cache with the new data. Pretty simple.

Anyway, I was proud. Nothing complex, just cool. Feel free to rip off anything I wrote. It's all on [GitHub](http://github.com/soffes/soff.es).
