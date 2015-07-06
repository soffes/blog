# New Homepage

Last night I updated my ~~blog~~ website. Now that I'm using [Roon](https://roon.io) for my blog, I wanted to update [soff.es](http://soff.es) to pull in my latest post and show off some of the stuff I'm working on.

We have big plans for developer stuff on Roon, but for now I'm just using a little Ruby script to pull my latest post.

``` ruby
desc 'Store my latest post in Redis'
task :update_post do
  response = HTTParty.get('https://roon.io/api/v1/blogs/sam/posts?limit=1')
  post = JSON(response.body).first

  %w{title excerpt_html url}.each do |key|
    redis.hset 'latest_post', key, post[key]
  end

  puts "Done! Cached `#{post['title']}`"
end
```

Pretty simple. We'll be rolling out real documentation and such soonish.

I'm also pretty proud of the apps grid I added.

[![Screen Shot 2013-06-20 at 1,01,16 PM](screenshot.png)](http://soff.es)

This is the first time I put the stuff I've worked on in one spot. A lot of the apps I've worked on aren't in this list though. A depressing amount of the apps I've spent tons of time on never shipped or are now pulled from sale. Oh well.

It's kinda funny that my most successful app was the very first one I did. That said, Bible pretty much sells itself.

Anyway, I'm excited to pretty graphs of my data from Fitbit, Instagram photos, and other stuff. Yay data.
