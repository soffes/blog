---
cover_image: cover.jpg
tags:
- development
- ruby
---

# Introducing Quesadilla

I've been thinking about making this Ruby gem for awhile. It was originally called "cheddar-text", but I decided something that sounded more fun would be better. Awhile back, I was trying to rewrite this library in C and named the repo Quesadilla. It turns out, writing a C extensions that manipulates strings is really hard, so now the Ruby version is named [Quesadilla](https://github.com/soffes/quesadilla).

Quesadilla is an entity-style text parser. Quesadilla was extracted from [Cheddar](https://cheddarapp.com). It's what powers all of Cheddar's text parsing. It was inspired a bit by [Twitter's tweet entity](https://dev.twitter.com/docs/tweet-entities).

Since Cheddar works on [iOS](https://cheddarapp.com/ios) and [Mac](https://cheddarapp.com/mac) (as well as the web), I needed something that could give me ranges for special things in the text. iOS and Mac convert this to an `NSAttributedString` using the indices included in each entity. [Here's the source](https://github.com/nothingmagical/cheddar-ios/blob/master/Classes/CDKTask+CheddariOSAdditions.m#L35) for how [Cheddar for iOS](https://cheddarapp.com/ios) does it in Objective-C.

We also use Quesadilla in [Seesaw](https://seesaw.co) (my day job). It works really well for us there too.

Quesadilla supports extracting the following:

* Markdown (italic, bold, bold italic, strikethrough, code, and links)
* Links
* Named Emoji
* Hashtags
* User Mentions

Here's a little example of what a hashtag looks like:

``` ruby
Quesadilla.extract('Some #awesome text')
# => {
#   display_text: "Some #awesome text",
#   display_html: "Some <a href=\"#hashtag-awesome\" class=\"tag\">#awesome</a> text",
#   entities: [
#     {
#       type: "hashtag",
#       text: "#awesome",
#       display_text: "#awesome",
#       indices: [5, 13],
#       hashtag: "awesome",
#       display_indices: [5, 13]
#     }
#   ]
# }
```

You can even provide a custom user validator:

``` ruby
validator = lambda do |username|
  # User.where('LOWER(username) = ?', username.downcase).first.try(:id)
  username == 'soffes'
end

extraction = Quesadilla.extract('Real @soffes and fake @nobody', users: true, user_validator: validator)
# An entity for `soffes` will be added, but not for `nobody`
```

Anyway, Quesadilla does a lot of stuff. Checkout the [readme](https://github.com/soffes/quesadilla#readme) for more or read the [documentation](http://rubydoc.info/github/soffes/quesadilla/master/frames). It's tested on Ruby 1.9.2, Ruby 1.9.3, Ruby 2.0.0, JRuby 1.7.2 (1.9 mode), and Rubinius 2.0.0 (1.9 mode), so it should work for you.

[Hit my up on Twitter](https://twitter.com/soffes) if you find this useful. Enjoy!
