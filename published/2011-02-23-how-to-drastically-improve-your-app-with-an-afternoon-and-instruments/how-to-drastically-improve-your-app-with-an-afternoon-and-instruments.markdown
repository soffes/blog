# How to Drastically Improve Your App with an Afternoon and Instruments

I was [bragging on Twitter](http://twitter.com/#!/samsoffes/status/40214844405710848) about how I just made my application way better with some simple tweaks. I wanted to write a quick post about what I did that really helped that will probably help most people. This stuff is a bit application specific, but I think you'll see parallels to your application.

### Symptoms

My application pulls a ton of data from the network and puts it in Core Data when you login for the first time. From using the application, I noticed that performance totally sucks at first and then goes back to normal. (My table views all scroll at 60fps, but I'll save that for another post. Sorry. Had to throw that in there. I'm way proud.) This was troubling since it usually works really great, (okay, now I'm done bragging about my cells) so I investigated.

Just so you know, I am doing all of my networking, data parsing, and insertion into Core Data on background threads via `NSOperationQueue`.

### The Problems

After running Instruments with the object allocations instrument, I noticed that I was using about 22MB of memory while it was downloading all of this data. In my opinion, that is way too high. I'll add that to list of stuff to mess with.

I also noticed that my `NSDate` category for parsing [ISO8601](http://en.wikipedia.org/wiki/ISO_8601) date strings (standard way to put a date into [JSON](http://en.wikipedia.org/wiki/JSON)) was taking about 7.4 seconds using the timer instrument. Totally unacceptable. Added to the list.

After messing around for a little while longer, I noticed that a lot of time was being spent in one of my `NSString` categories, specifically in `NSRegularExpression`. This sounds annoying, so I'll save that for last.

### The Solutions

#### Memory

I had a few guess on how to cut memory usage while converting large amounts of JSON strings into `NSManagedObject`s. My guess was that a ton of objects needed to be autoreleased but the `NSAutoreleasePool` wasn't being drained until the operation finished. The simple solution for this to ==add a well-placed `NSAutoreleasePool` around problem code==. This took a few tries to get in the right spot. I would put it where I think most of the temporary objects were being created and then watch the object allocations instrument to make sure it got flatter.

Here was my first try:

![First Try](1E0p3Z2h0u372d210l1e0H1z3X0s3G2O.png)

See how it goes up and drops sharply down a bit and then builds up for awhile then finally drops off? That's a sign there is another loop nested deeper down that should have a pool around it. For the first one, it did a little and then drained (probably because it did less stuff in that operation). Since the second giant hump (note the peak of that is 23MB or so) doesn't drop off for awhile, I know to look for another loop deeper down. Hopefully that makes sense. Once you get in there, it will suddenly hit you after stumbling around for a bit. You'll see.

After moving it to a more nested loop, here's the result:

![Second Try](0J2k2S3D0U3t2L3d0x0y3a0F0K1s1O1P.png)

Once I got it in the right spot, ==it was using under 2MB of memory for the entire process!== Score! Next problem.

#### Date Stuff

The date stuff had me stumped for awhile. I was using [ISO8601Parser](https://github.com/square/iso8601parser) (a subclass of `NSFormatter`) which was working really, really well compared to `NSDateFormatter`. After looking at timer instrument, I saw that most of that time was spent in system classes like `NSCFCalendar`. I assumed there was a better way. I tried switched back to `NSDateFormatter`, but that didn't work well and still wasn't great memory and speed wise.

As a disclaimer, I am all about Objective-C. I love it. I'm not one of those engineers that's says "hey, we should rewrite this in C" all the time, but hey, we should rewrite this in C. I did... and the result was astounding!

Here's the code:

``` objective-c
#include <time.h>

+ (NSDate *)dateFromISO8601String:(NSString *)string {
    if (!string) {
        return nil;
    }

    struct tm tm;
    time_t t;

    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);

    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];
}


- (NSString *)ISO8601String {
    struct tm *timeinfo;
    char buffer[80];

    time_t rawtime = [self timeIntervalSince1970] - [[NSTimeZone localTimeZone] secondsFromGMT];
    timeinfo = localtime(&rawtime);

    strftime(buffer, 80, "%Y-%m-%dT%H:%M:%S%z", timeinfo);

    return [NSString stringWithCString:buffer encoding:NSUTF8StringEncoding];
}
```

See, it's not too crazy. ==Using the C date stuff took my date parsing from 7.4 seconds to 300ms. Talk about a performance boost!== (I updated [SSTookit](http://github.com/samsoffes/sstoolkit)'s [NSDate category](https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/NSDate%2BSSToolkitAdditions.h) to use this new code.)

#### Regular Expression

I have several `NSString` categories in my application for doing various things. Some of them were called throughout the process I was trying to optimize. I drilled down in the time profiler instrument and realized that `[NSRegularExpression regularExpressionWith...]` was taking a ton of the time. This totally makes sense, since it compiles your regex to use later and I was doing it each time. Simple solution:

``` objective-c
- (NSString *)camelCaseString {
    static NSRegularExpression *regex = nil;
    if (!regex) {
        regex = [[NSRegularExpression alloc] initWithPattern:@"(?:_)(.)" options:0 error:nil];
    }

    // Use regex...

    return string;
}
```

This was actually the easiest part :)

### Conclusions

So using Instruments to track down slow or bad code is really easy once you get the hang of it. Start with the leaks instrument if you're new. You shouldn't have any (known) leaks in your application.

Once you get that down (or get so frustrated trying to track it down you give up and move to something else) do the object allocations instrument next. You can watch the graph and see how many objects you have alive. If you see a big spike that never goes down, you most likely have a ton of memory around that you probably don't need but still have a reference to so it doesn't show up in leaks. Adding autorelease pools around loops that do lots of processing always helps.

Finally, use the time profiler instrument to see what's taking a long time and optimize the crap out of it. This is the most fun since it's easy to see whats happening and how much of an improvement you made by the changes you just made. The key to making this instrument useful is the checkboxes on the left. Turning on Objective-C only or toggling the inverted stack tree is really useful.

### This is Hard

Don't feel bad, especially if you're new to this. This stuff is hard. All of my solutions I listed above are pretty simple. I spent almost an entire day coming up with those few things. The majority of the time you spend will be tracking down problems. Fixing them is usually pretty simple, especially after you've done it a few times. This is hard. You're smart. :)
