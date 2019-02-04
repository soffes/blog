---
tags:
  - development
  - ruby
  - markdown
---

# Static Blog

So I redid my blog again. I don’t think there is a piece of software I have worked on more over the years. Way back in 2006, I remember constantly redoing my custom WordPress theme over and over again. Since then I rewrote it [in PHP a bunch of times](/i-am-addicted-to-redoing-my-blog), Rails a few times, and then [some weird stuff on top of Sinatra](/new-blog) for awhile. I tried [Jekyll on GitHub pages](/new-blog-on-github-and-jekyll), WordPress, Roon, Ghost, and probably some other stuff mixed in there too.

This iteration is built on top of [Jekyll](https://jekyllrb.com). My [previous iteration](/new-blog) was built on the idea that I should store my posts separately in [a repo](https://github.com/soffes/blog) that’s just Markdown and the images used in the posts. I optimized for a format that I enjoy writing with the hope that it would help me write more. [The blog](https://github.com/soffes/soffes.blog) imported the posts and did a bunch of processing to eventually store the rendered posts in Redis.

Lately, I’ve been playing with [Netlify](https://netlify.com), a great static site host. It’s been really great of a bunch of simple projects. My blog was the last big thing I had on Heroku and wasn’t cheap to run. I figured since it was mostly static already, I could just convert it to Jekyll without too much effort.

Since I write my posts differently than Jekyll expects, I had to write several plugins to make things work correctly. You might wonder why I don’t just write my posts the way Jekyll wants instead of doing all of this work. ==I want to keep the details of my blogging engine separate from my content.==

Feel free to explore [my plugins](https://github.com/soffes/soffes.blog/tree/2019-02-03/_plugins) (this links to the state at the time of this writing) if you’re curious. The main things of note are a custom excerpt processor, pagination, and [JSON feed](https://jsonfeed.org) support. There is also a plugin that moves images around and handles rewriting paths. I like storing images for my posts in the same folder as the post instead of all in one directory.

Another thing that’s cool is ==everything auto-deploys==. When I push a commit to my blog repo or posts repo, Netlify automatically deploys the site in about a minute. It’s pretty great to not have to worry about deploys ever.

I don’t necessarily recommend doing this yourself, but I really like this setup. I had a really good time exploring [Jekyll’s plugin support](https://jekyllrb.com/docs/plugins/). Time to start writing more.
