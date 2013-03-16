---
title: Automatic Reference Counting
tags: [arc, development, objective-c]
---

[Automatic Reference Counting](http://clang.llvm.org/docs/AutomaticReferenceCounting.html) (or ARC) is a new advancement in Objective-C with the [LLVM compiler](http://llvm.org/). There is a lot of debate in the community about its place. I've worked with people who completely despise it and people that think it's the best thing since sliced bread (which by the way, is pretty great). I have some thoughts on ARC too.

I tried it on a Mac app and an iOS app. At first it was really hard to let go of `retain`, `release`, and controlling the details of an objects lifetime. After awhile, it was really nice to not write `dealloc` and just release every ivar.

When I switched back to work on a non-ARC app, I realized how annoying it is to write memory management code. *Now, we're switching all of our apps at work to be ARC.* Here's are my two biggest reasons:

### Less Code

Less code is fantastic. It saves programmer time (which is very expensive). It leaves less chance for human error. *Less code is good.*

Eliminating human error is probably the biggest win with less code. Memory management errors are the biggest source of crashes in Objective-C apps. *Preventing this whole class of bugs is huge.*

### Easier for Beginners

New engineers to the platform often have the hardest time learning memory management. Most platforms, like Java & Ruby, use a garbage collector, so the concept is difficult to grasp.

I think this is huge. *New developers to the platform is a good thing.* I really love all of the work Apple is putting into making starting on their platforms easier. This is good for everyone: developers, users, and Apple.

### The Downsides

There are few things I dislike about ARC. Working with blocks is sometimes awkward since it's all magical and you sometimes need to do non-standard stuff. Working with Core Foundation is also semi-annoying.

### Conclusion

*Memory management is knowing a set of rules.* Currently, we know when and where to write memory management code. Things like `__block` modify these rules and we adjust. ARC is the same way, just with different rules. There is a slightly different set of rules and things modify them as well.

*We have to re-learn these rules with ARC. This is not a bad thing*, it's just different. I realize lots of people will resist this at first, but it really is for the best. Apple will obviously be moving everything to ARC eventually.

So, yes it makes somethings slightly annoying and many, many things way less annoying. Yes, we have to learn new things, but this is good. *I think you should use ARC.*
