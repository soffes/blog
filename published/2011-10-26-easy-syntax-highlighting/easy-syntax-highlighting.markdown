---
title: Easy Syntax Highlighting
categories: development ruby web
---

Syntax highlight in Ruby is annoying. [Pygments](http://pygments.org/) is the best way to do syntax highlighting, but it's a Python project. (Why no one has ported that to Ruby yet is beyond me. Granted there are a few, but they are all kinda annoying, slow, or don't work that well.)

Anyway, for awhile the best way was to hit a [web service running on App Engine](http://pygments-1-4.appspot.com/) to use Pygments since that's actually running Python. This totally sucks because you have to rely on that service—it could be down, network latency, etc.

[Damian Janowski](https://github.com/djanowski) put out a fantastic gem that solves this called [Pygmentize](https://github.com/djanowski/pygmentize). It's dead simple to use too.

``` ruby
require "pygmentize"
source = "function foo() { return 'bar'; }"
Pygmentize.process(source, :javascript)
```

==The best part about all of this is that you can run it on Heroku!== I [switched my blog to use it](https://github.com/soffes/soff.es/commit/5bf2aa733d020caad897960a133055110e545ea5#L2R14) and it's working great. By the way, if you're using Heroku, be sure you use the [Cedar Stack](http://devcenter.heroku.com/articles/cedar).

Here's my **[little example page running on Heroku](http://pygmentize-example.herokuapp.com)**. The full source is [on GitHub](https://github.com/soffes/pygmentize-example) too. Enjoy!
