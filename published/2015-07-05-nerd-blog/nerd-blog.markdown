---
title: Git + Redis Backed Blog
categories: blog ruby meta web
---

I switched back to the old blog I was using before [Roon](http://roon.io) (this blogging platform I used to run). Right before Roon, I had all of these fun ideas for the nerdy blogging platform that I wanted.

==The main idea was all of my posts lived in [their own repo](https://github.com/soffes/blog).== This is great for a bunch of reason. Being separate from my blog's source code is nice since it changes every few years. Even when I was blogging on Roon and [Ghost](http://ghost.org), I kept this up to date (with some scripts). I saw a talk from one of the guys that works on [Archive.org](http://archive.org) and was really inspired to start saving as much as I can.

Since my posts are in their own repo, a simple ==post-commit hook can update my blog==. GitHub simply posts to [an enpoint on my blog](https://github.com/soffes/blog.soff.es/blob/master/lib/soffes/blog/application.rb#L11) that causes it to [reimport](https://github.com/soffes/blog.soff.es/blob/master/lib/soffes/blog/importer.rb) my posts into [Redis](http://redis.io). ==Another added benefit is people can PR typo fixes.== When I click the merge button on GitHub, the webhook fires and automatically updates the post on my site. Neat!

==Basically, it's a static site backed by Git & Redis that updates automatically==. This is what I built the last few days here and there in my free time last week. The code is [on GitHub](https://github.com/soffes/blog.soff.es). I plan to eventually make it more generic so anyone can use it. Also, a lot of the code is 2+ years old so it's pretty gross.

One of my favorite parts is all of the images live in this posts repo. That way, the images aren't tied to any particular host. As [part of the importer](https://github.com/soffes/blog.soff.es/blob/master/lib/soffes/blog/importer.rb#L77), it finds all `<img>` tags, looks for local images in the repo, uploads them to S3, and then updates the tag from a relative link to an absolute link for the newly uploaded image. (It also caches what it knows it uploaded to speed up the process on future runs.)

I'm really enjoying writing posts in [my favorite Markdown editor](http://usewhiskey.com) and simply running `git push` to publish posts!

