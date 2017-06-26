---
title: Scaling Cheddar
categories: development ruby web
---

The first few days of the [Cheddar](http://cheddarapp.com) launch was rough. I got hammered the first day with over 40,000 views to the website (not including API traffic). At one point, I was running 40 dynos (Cheddar runs on Heroku).

After awhile, a pattern became clear. ==There would eventually be some request queueing visible in New Relic and then all requests would just time out.== I was using one of the beta databases on Heroku (Crane). The amazing [@mattt](http://twitter.com/mattt) suggested that I switch to a dedicated one, but that didn't seem to help.

Now for the best part, everything was down for 12 hours due to an AWS outage. The power went out in the datacenter. This blows my mind. Datacenter 101 is backup generators with backups for those. Anyway, this totally sucked.

After things came back, it was still rough. Every few hours, requests would start queueing and then everything would die. For awhile, I was just restarting my app from my phone every once in awhile. It didn't matter much. I'd wake up to just find it down.

Two simple things solved this problem:

## Background Tasks

In New Relic, there were lots of calls to external services. I figured this was just calls to auth [Pusher](http://pusher.com) since I use Pusher a ton. After some troubleshooting with a Heroku support engineer, we realized it was [Postmark](http://postmarkapp.com).

Sometimes calls to their API would block for awhile. If enough dynos got in this state, everything would die because the backlog would fill up too quickly.

==This was easily solved by performing all email sending in a [Sidekiq](https://github.com/mperham/sidekiq) queue.== Sidekiq is fantastic. You should use it. There's even a great [ActionMailer extension](https://github.com/mperham/sidekiq/wiki/Delayed-Extensions) to delay sending mail. You just have to add `.delay` like this:

``` ruby
UserMailer.delay.welcome(user)
```

The [Pusher gem](https://github.com/pusher/pusher-gem) also has support for asynchronously sending pushes via EventMachine. Adding this helped too.

## ETAGs & Cache-Control

==Adding ETAGs helped a ton.== Rails does this for you, but customizing them a bit helped a ton. The home page never changes so I can only serve it to the user once. ==Setting the Cache-Control to public== for the homepage also let's Rack::Cache cache it in memcache to avoid serving static pages was also a good improvement.

There's a [fantastic RailsCast](http://railscasts.com/episodes/321-http-caching) on this. I highly recommend watching it.

## CDN & Webfonts

A quick note about assets. All of my assets are served of Amazon's CloudFront CDN. Since Rails adds a hash to the end of the filename, I set all of them to expire forever. I actually serve CloudFront the assets from my Rails app so I can set the appropriate headers for webfonts. This is only one request ever per asset though.

## Conclusion

These two simple things have me happily running with 4 dynos. I know all of this was considered best practice already, but I didn't realize how important it really was. Hopefully this helps someone.

**Update 06/22/2013:** I no longer own Cheddar. [More info](http://soff.es/parting-ways-with-cheddar).
