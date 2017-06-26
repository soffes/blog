---
tags:
- video
- development
- ruby
- web
---

# Easy Deployment with Heroku

<div class="video vimeo"><iframe src="
https://player.vimeo.com/video/7465783?title=0&amp;byline=0&amp;portrait=0&amp;color=f05b35" width="640" height="480" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe></div>

I put together [a quick screencast](http://vimeo.com/7465783) that shows the power of [Heroku][] and how easy it is to deploy your app in literally seconds. I've started moving all of my little sites there. [My company](http://tastefulworks.com) is even going to try a few of our new apps on there to see how we like it for bigger things.

[Heroku][] is worth checking out even if you're happy with your current host. Their [architecture](http://heroku.com/how/architecture) is really impressive and the [add-ons](http://addons.heroku.com/) are really cool.

[Heroku]: http://heroku.com/

## Gem Gotcha

At first my app gave me an error saying it couldn't load gems. I thought I needed to unpack my gems, but [Heroku replied to me on Twitter](http://twitter.com/heroku/status/5485647467) and provided a really good alternative to unpacking!
