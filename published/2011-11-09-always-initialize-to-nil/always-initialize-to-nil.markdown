# Always Initialize to Nil

Here's an excerpt from [a great blog post](http://ryfar.com/post/12591151308/initialize) on why you should always initialize your variables to `nil`.

> ==“Always initialize your object variables to nil, no matter what, because some day they may be captured by a block and if they contain junk when the block is copied you’re going to crash.”==

It's just good practice, but this really sums it up. Thanks for the write up [Ryan Perry](http://twitter.com/ryfar)!
