---
tags:
- meta
- development
- web
---

# New Blog

I redo my blog a lot. This time around, it's very different than past iterations. ==Everything is stored in git and cached in Redis.==

After being inspired by [Waza](http://waza.heroku.com) this year, I decided to have a more durable way to store my posts. Instead of storing years of work in Postgres, I decided to store them [on GitHub](https://github.com/soffes/blog). I even took the time to go through [Archive.org](http://archive.org) and try to find as my old posts as I could find.

I'm not worried about Postgres durability. I'm more worried about accidently deleting my database or my dev database getting corrupted. Anyway, having them on my computer, external backups, and on GitHub is a good feeling. Granted I could have done that with Postgres, but managing markdown files on my computer is fun and easy.

Anyway, my blog is [a really simple Sinatra app](https://github.com/soffes/soff.es) that loads the posts out of Redis. There is a post deploy hook from my posts repository that triggers my blog to import the latest post.

It's been great to read my old posts. [This one about the ROKR](/the-motorola-rokr) or [when I got an iPhone](http://soff.es/i-got-an-iphone) is hilarious to read. I've been cataloing my life on this silly site since 2005, although all my posts before 2006 seem to be lost. ==It makes me kind of sad that those memories are probably gone forever. That's why I spent so much time to try to perseve everything going forward.==

Anyway, enjoy.
