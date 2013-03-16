---
title: Updated iPhone JSON Benchmarks
tags: [benchmarks, cocoa, development, iphone, json]
---

**Update:** You can see the latest benchmarks at <https://github.com/samsoffes/json-benchmarks>. The results change quite a bit, so I'd recommend just running the code and seeing who wins.

I wrote [a post awhile ago about JSON benchmarks](http://samsoff.es/posts/iphone-json-benchmarks). I was telling [a friend](http://twitter.com/lukeredpath) he should use [JSON Framework][] based on my old benchmark post. He asked if I had run them again recently, so I figured I'd run them again.

I [updated my test app](http://github.com/samsoffes/json-benchmarks/commit/18ec5f34a46b8c973aa301fe738753ce52c12f4d) and added a new library called [YAJL][] based on a [C library](http://lloyd.github.com/yajl/). My results were very similar to before. This time I tested it on an iPad and iPod Touch.

![16GB 1st Gen iPad running iOS 3.2](http://assets.samsoff.es/posts/updated-iphone-json-benchmarks/ipad-json-benchmarks.png)

![8GB 3rd Gen iPod Touch running iOS 3.1.3](http://assets.samsoff.es/posts/updated-iphone-json-benchmarks/ipod-json-benchmarks.png)

### Results

On both devices, they ranked [Apple JSON][], [YAJL][], [JSON Framework][], and [TouchJSON][]. You can read the detailed results [on GitHub](http://github.com/samsoffes/json-benchmarks/blob/18ec5f34a46b8c973aa301fe738753ce52c12f4d/Readme.markdown).

In conclusion, *it looks like [YAJL][] is the new one to use*. Again, feel free to [check out my code on GitHub](http://github.com/samsoffes/json-benchmarks).

[TouchJSON]: http://code.google.com/p/touchcode/
[JSON Framework]: http://code.google.com/p/json-framework/
[Apple JSON]: http://samsoff.es/post/parsing-json-with-the-iphones-private-json-framework
[YAJL]: http://github.com/gabriel/yajl-objc
