---
title: Making Roon Faster
cover_image: cover.jpg
categories: development ruby web
---

Last night, I deployed some changes to [Roon](http://roon.io) that made things a lot faster. Drew told me I should write about it, so here we are. I did three things:

## CloudFront

Our assets were taking awhile to load because S3 is a tad slow. We use the fantastic [asset_sync](https://github.com/rumblelabs/asset_sync) to serve assets off of S3 instead of Heroku. This is a big performance (and cost) win by itself since Heroku is expensive and is better suited serving dynamic requests.

The main problem here is webfonts. Users can't see any text on our pages until the font loads for the first time. This is kind of a big deal for a blogging app. Even worse, due to iOS security, if you hit Roon in Tweetbot (or any other app using UIWebView), it will have to download it since it doesn't share the system HTTP cache for security reasons. All of this made Roon feel super slow—especially on mobile.

Simply setting up a CloudFront distribution pointed at our S3 bucket and simply changing our asset host took less than a minute. Now all the fonts (as well as CSS and JavaScript) are quite snappy. That was easy!


## Less Queries

The viewer (the part that serves users' blogs) is our #1 concern regarding performance. We absolutely want to make the best writing experience possible, but people reading your content is priority. I sat down for 30 minutes or so and used [mini-profiler](https://github.com/SamSaffron/MiniProfiler/tree/master/Ruby) to see what queries were being performed and why. It turns out there were a few things we could optimize. The main thing here was prefetching relationships on objects so it would do `n` queries.

Took it from quite a few queries to load the page down to just a handful. Feeling much better about things there. I'll definitely work to improve things on a regular basis.

## Unicorn

I think was one of our biggest wins in the latest changes. We switched from [Puma](http://puma.io) to [Unicorn](http://unicorn.bogomips.org). Unicorn is a really fast, multi-process Ruby web server. I've used it in the past, but I heard Puma is the new hotness, so I've been using that for projects lately.

I saw a talk by [Andre Arko](https://vimeo.com/67476626) (he's [@indirect](http://twitter.com/indirect) and on the [Bundler](http://gembundler.com) core team). It was a really great talk on scaling a web service. You should [watch it](https://vimeo.com/67476626). Seriously.

Anyway, he was saying using Unicorn over Puma really helped their stuff and explained the concurrency stuff. I thought it was worth a try. Surprisingly, it really improved the time it took from the Heroku router reporting a request to Rails handling it. I'm not sure what the deal was the Puma, but a simple switch to Unicorn and now everything is way faster.

## Enjoy

So, I hope you enjoy these speed improvements. The whole site is definitely noticeably faster. If you haven't tried [Roon](http://roon.io), check it out. Maybe write about what you do on an average day at work or something. You'd be surprised about the interesting stuff you find when you just sit down to write about a topic.

