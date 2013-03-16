---
title: Dealing with Emoji
tags: [development, objective-c, ruby, text]
---

Someone recently pointed out that [Cheddar](http://cheddarapp.com) doesn't support Emoji that well. After lots of banging my head against the wall, I figured out some simple solutions. Here's what I learned.

<span style="color:#999">Note: currently only Safari support emoji so the examples might be a bit confusing if you're using a browser that doesn't support emoji.</span>

### Ruby

Cheddar's server uses [Ruby on Rails](http://rubyonrails.org). It turns out that there is a bug in `ActiveSupport::JSON::Encoding` that doesn't encode high UTF-8/UTF-16 characters correctly. ([More information](http://stackoverflow.com/questions/8635393/ios-5-how-to-convert-an-emoji-to-a-unicode-character/10875016#10875016) on this bug). There's a [simple solution](http://stackoverflow.com/questions/5123993/json-encoding-wrongly-escaped-rails-3-ruby-1-9-2/8339255#8339255) that monkey patches ActiveSupport to use the actual character instead of trying to encode it.

``` ruby
module ActiveSupport::JSON::Encoding
  class << self
    def escape(string)
      if string.respond_to?(:force_encoding)
        string = string.encode(::Encoding::UTF_8, :undef => :replace).force_encoding(::Encoding::BINARY)
      end
      json = string.gsub(escape_regex) { |s| ESCAPED_CHARS[s] }
      json = %("#{json}")
      json.force_encoding(::Encoding::UTF_8) if json.respond_to?(:force_encoding)
      json
    end
  end
end
```

### Objective-C

Next up was iOS. After some digging, this became the apparent source of the problem:

``` objective-c
NSLog(@"Beard face length: %i", @"👨".length);
// Beard face length: 2
```

After watching “Session 128 - Advanced Text Processing” from WWDC 2011, I learned that the beard face is actually a *surrogate unicode pair*. Basically, high UTF-16 characters use this to form characters. For example, `é` is actually `e` + `´`. This is super common in Korean, Chinese, Vietnamese, etc. Emoji is made the same way. Here's another fun discovery:

``` objective-c
NSLog(@"Same first character: %i", [@"👮" characterAtIndex:0] == [@"💇" characterAtIndex:0]);
// Same first character: 1
```

In Cheddar, I do something similar to Twitter's [Tweet Entities](https://dev.twitter.com/docs/tweet-entities). Basically, there are ranges for where there are additions to the text (i.e. bold, tags, links, etc). Since emoji characters are more than 1 in length, this messes up everything.

There's a really great method called `-[NSString enumerateSubstringsInRange:options:usingBlock:]`. If you pass `NSStringEnumerationByComposedCharacterSequences` for the `options` parameter, it will loop through all of the composed characters (or surrogate unicode pairs). We can use this to calculate how much to offset our range to account for emoji and other composed characters.

Here's the code:

``` objective-c
- (NSRange)composedRangeWithRange:(NSRange)range {
  // We're going to make a new range that takes into account surrogate unicode pairs (composed characters)
  __block NSRange adjustedRange = range;

  // Adjust the location
  [self enumerateSubstringsInRange:NSMakeRange(0, range.location + 1) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
    // If they string the iterator found is greater than 1 in length, add that to range location.
    // This means that there is a composed character before where the range starts who's length is greater than 1.
    adjustedRange.location += substring.length - 1;
  }];

  // Adjust the length
  NSInteger length = self.length;

  // Count how many times we iterate so we only iterate over what we care about.
  __block NSInteger count = 0;
  [self enumerateSubstringsInRange:NSMakeRange(adjustedRange.location, length - adjustedRange.location) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
    // If they string the iterator found is greater than 1 in length, add that to range length.
    // This means that there is a composed character inside of the range starts who's length is greater than 1.
    adjustedRange.length += substring.length - 1;

    // Add one to the count
    count++;

    // If we have iterated as many times as the original length, stop.
    if (range.length == count) {
      *stop = YES;
    }
  }];

  // Make sure we don't make an invalid range. This should never happen, but let's play it safe anyway.
  if (adjustedRange.location + adjustedRange.length > length) {
    adjustedRange.length = length - adjustedRange.location - 1;
  }

  // Return the adjusted range
  return adjustedRange;
}
```

Now instead of calling `-[NSString substringWithRange:]`, I call my own method:

``` objective-c
- (NSString *)composedSubstringWithRange:(NSRange)range {
  // Return a substring using a composed range so surrogate unicode pairs (composed characters) count as 1 in the
  // range instead of however many unichars they actually are.
  return [self substringWithRange:[self composedRangeWithRange:range]];
}
```

There is probably a better solution than iterating through all of the characters, but it's the best I could find. A performance optimization would be caching the offsets and only iterating through a string once instead of for each range I need to apply to it.

Anyway, hopefully that was helpful to you if you have to deal with emoji or other crazy characters.

[Follow me on Twitter](http://twitter.com/samsoffes).
