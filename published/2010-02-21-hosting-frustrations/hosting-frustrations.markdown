---
title: Hosting Frustrations
categories: development web
---

Lately I've been struggling with good hosting. Here's three stories about some stuff I've tried. (Skip to the bottom of the post if you just want my conclusion and don't care about the stories.)

## Heroku

I love [Heroku][]. I did [a screencast](http://samsoff.es/posts/easy-deployment-with-heroku) on how awesome they are a few months ago. Since then, I've moved all of my personal apps and all of [Tasteful Works][]'s apps to [Heroku][]. They've been really great until recently.

I have two big complains (and one small one) with [Heroku][].

### SSL

We were using [SNI SSL](http://addons.heroku.com/ssl) for the [Tasteful Works Store](http://tastefulworks.com/store) for awhile with great success. We realized that [Google Chrome](http://google.com/chrome) (as well as IE 6, which I don't really care about) don't support SNI SSL.

Chrome really yells at you when you go to a site using SNI SSL.

![SNI Chrome](2N2n1J2w320f0r3T1c1I0q2S0Q3D0j2W.png)

To get around this, you have to pay $100 a month ($95 more than SNI). This totally sucks. Heroku is awesome because they are affordable and easy. We finally decided to suck it up and pay the extra $95 a month. After paying they told it would take 1-2 business days to set it up. ==That totally sucks.== After paying all of that money, we have to wait. I was pissed to say the least. They got it setup in 8 hours, but still.

The reason for the high price is due to how SSL works. Basically they spin up another $70/month [Amazon EC2](http://aws.amazon.com/ec2/) instance to filter all of your requests through that into their routing grid. This is necessary because SSL requires that a certificate always uses the same IP. Understandable, but where the extra $30 comes from or why people can't share doesn't make sense to me.

### HTTPS

Another recently frustrating thing with [Heroku][] is how SSL environment variables work. `rack.url_scheme` is set to `http` or `https` depending on your request. Lots of [Rack](http://rack.rubyforge.org/) pieces rely on this. [Heroku][] sets `HTTP_X_FORWARDED_PROTO` to `https` if it's an HTTPS request or omits that variable completely if it's an HTTP request.

This isn't a huge deal, but it caused me quite a few issues. I [patched](http://github.com/soffes/refraction/commit/2739dd9670b24c7a03e0d95679e879d732325abc) [Refraction](http://github.com/pivotal/refraction) to work correctly on [Heroku][] and all was happy.

[Heroku][] told me on IRC that this is because requests sent internally are sent using HTTP and only HTTPS is used for the requests coming into the routing grid. That's fine and all, but it wish they informed applications of HTTPS in a more standard way.

### Bundler

I know that they are working on better [Bundler][] support, but it's kinda painful right now. You can't use gems from a git repository and whenever it re-bundles your app, it installs all of your gems, not just the ones needed for the current environment. So if you're like me and have a lot of testing gems, this takes forever.

## Engine Yard Cloud

Some of the [Engine Yard][] employees saw my frustrated [Heroku][] tweets (which makes me laugh that they search for frustrated [Heroku][] customers). They offered me two free weeks on the [Engine Yard Cloud][], which I thought was really cool.

After checking it out, I was ==very disappointed==. I tried to get [Markdownr][] setup on their service. After messing with it for over an hour, I gave up. [Markdownr][] is probably one of the simplest Rails apps. (You can see the [code on GitHub](http://github.com/soffes/markdownr.com).) It only uses one gem besides Rails and doesn't use a database.

You have to add all of your gems that you need in their web portal. This seems so dumb. I wish it just used [Bundler][] (especially since [the guys that wrote it](http://github.com/carlhuda) work at [Engine Yard][]). I never got my app to launch. It kept saying the i18n gem wasn't found. I thought this might be due to using a [pre-release version of Rails](http://rubygems.org/gems/rails/versions/3.0.0.beta), so I installed them all separately and it still didn't work.

I emailed them and they said "Sorry that it looks like ey cloud is not for you." ==If it can't work with the simplest of apps, what can it work with?== The price is also a bit high. (I also know [a good friend](http://twitter.com/mdavis) that had a horrible experience with them.)

## Rackspace Cloud

A few friends [said they liked the Rackspace Cloud](http://twitter.com/jt/status/9376463152), so I thought I'd check it out since I am a little pissed at [Heroku][] for all of the SSL junk and the [Engine Yard Cloud][] just let me down. I checked out their site (which isn't to pretty) to get some more information, but didn't really feel like reading a poorly laid out marketing site. At the top of the page it said "Call Us," so I figured why not? I was curious if someone would answer at 11pm.

A support guy answered after just one ring. I was already impressed. If their support is that easy to contact, (granted it was at 11pm) that's really awesome. I told him I had some general questions about their platform and he was super nice and answered all of my questions.

I would totally go with [Rackspace Cloud][] over any other VPS type service. They seem really awesome.

## Final Thoughts

All of that said, [Heroku][] is still hands down the easiest platform for hosting a Rails application. The [Engine Yard Cloud][] is completely worthless. The [Rackspace Cloud][] is really cool, but I don't want to manage a server.

So all of that said, we're staying on [Heroku][] and paying the extra $95 a month for SSL.

[Heroku]: http://heroku.com/
[Bundler]: http://github.com/carlhuda/bundler
[Tasteful Works]: http://tastefulworks.com/
[Engine Yard]: http://engineyard.com/
[Engine Yard Cloud]: http://engineyard.com/products/cloud/
[Markdownr]: http://markdownr.com/
[Rackspace Cloud]: http://rackspacecloud.com/
