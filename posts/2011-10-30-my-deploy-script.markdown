---
title: My Deploy Script
tags: [development, heroku, rails]
---

Here's my basic rake task I use to deploy my blog:

``` ruby

desc 'Deploy to Heroku and push to GitHub'
task :deploy do
  unless `git status -s`.length == 0
    puts 'WARNING: There are uncommitted changes'
    puts 'Commit any changes before deploying.'
    exit
  end

  `git push origin master`
  `git push heroku master`
  `heroku run rake assets:precompile`
end
```

Notice I run `rake assets:precompile` after I deploy to [Heroku](http://heroku.com). I am using [asset_sync](https://github.com/rumblelabs/asset_sync) to host my assets on S3 instead of Heroku. There is a known issue with Heroku and this gem, so that's my workaround. Having it in my little rake task means I won't forget any more :)
