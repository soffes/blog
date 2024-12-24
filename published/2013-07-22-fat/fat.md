---
cover_image: cover.jpg
tags:
- life
---

# Fat

I'm fat. About a year ago, I made [a little website](http://fat.soff.es) about my data and such. My friend [Brian Minor](https://twitter.com/brianminor) inspired me. ==My thought was if I publicly track data, it will keep me motivated.==

I redid my little site last night to have a graph. Right now it just pulls in my weight from the [Fitbit](http://fitbit.com) [Aria scale](http://fitbit.com/aria) and shows a simple graph. There is a rake task that runs every 10 minutes and stores the data as a JSON string in Redis. The rest is a simple Sinatra app that just sends the JSON straight to JavaScript. The graph is made using [Chart.js](http://chartjs.org).

When I have more time (lol) I want to make this pretty and show more data. Fitbit collects a ton of really sweet data. Making a custom dashboard thing sounds like fun.

Anyway, [all of the code is on GitHub](https://github.com/soffes/fat). If you see the graph go up, tell me I suck [on Twitter](https://twitter.com/soffes).

**[See my progress](http://fat.soff.es).**
