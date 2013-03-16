---
title: Archiving Objective-C Objects with NSCoding
tags: [cocoa, iphone, mac, nscoding, objective-c, tutorial]
---

For the seasoned Cocoa developer, this is a piece of cake. For newer developers, this can be a real pain, especially if you don't know what you're looking for. I get this question a decent amount, so I figured I'd put a quick guide together.

### The Problem

You can't put just any object in a [plist](http://en.wikipedia.org/wiki/Property_list). This mainly gets people when they want to put something into [NSUserDefaults](http://developer.apple.com/mac/library/documentation/Cocoa/Reference/Foundation/Classes/NSUserDefaults_Class/Reference/Reference.html) and get an error (because NSUserDefaults archives to a plist under the hood).

Plists only support the core types: `NSString`, `NSNumber`, `NSDate`, `NSData`, `NSArray`, `NSDictionary` (and their CF buddies thanks to the toll-free bridge). The key here is `NSData`. *You can convert any object to `NSData` with the `NSCoding` protocol.*

### The Solution

There are two things you have to do: *implement NSCoding* and then *use the archiver and unarchiver*.

#### Implementing NSCoding

Say you have an object that looks like this:

``` objective-c
@interface Note : NSObject {
	NSString *title;
	NSString *author;
	BOOL published;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic) BOOL published;

@end
```

``` objective-c
#import "Note.h"

@implementation Note

@synthesize title;
@synthesize author;
@synthesize published;

- (void)dealloc {
	[title release];
	[author release];
	[super dealloc];
}

@end
```

Pretty simple, right?

Now, all you have to do to implement NSCoding is the following:

``` objective-c
@interface Note : NSObject <NSCoding> {
	NSString *title;
	NSString *author;
	BOOL published;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic) BOOL published;

@end
```

``` objective-c
#import "Note.h"

@implementation Note

@synthesize title;
@synthesize author;
@synthesize published;

- (void)dealloc {
	[title release];
	[author release];
	[super dealloc];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		self.title = [decoder decodeObjectForKey:@"title"];
		self.author = [decoder decodeObjectForKey:@"author"];
		self.published = [decoder decodeBoolForKey:@"published"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:title forKey:@"time"];
	[encoder encodeObject:author forKey:@"author"];
	[encoder encodeBool:published forKey:@"published"];
}

@end
```

Pretty simple. All I did was add the `<NSCoding>` protocol delectation in the header file and `initWithCoder:` and `encodeWithCoder:` in the implementation. You use these methods to tell `NSCoder` how to encode your object into data. Notice how two of the variables are objects and one was a `BOOL`. You have to use different methods for non-objects. The [NSCoder documentation](http://developer.apple.com/mac/library/documentation/Cocoa/Reference/Foundation/Classes/NSCoder_Class/Reference/NSCoder.html) has the full list.

Remember, that you can use `NSCoder` to archive your object however whatever you want. It doesn't have to just be all of the instance variables in your object, although that's what you'll do 90% of the time.

#### Using the Archiver and Unarchiver

This part is also really easy. Let's say you have an array of notes that you want to put into `NSUserDefaults`, here's the code:

``` objective-c
// Given `notes` contains an array of Note objects
NSData *data = [NSKeyedArchiver archivedDataWithRootObject:notes];
[[NSUserDefaults standardUserDefaults] setObject:data forKey:@"notes"];
```

Unarchiving is just as easy:

``` objective-c
NSData *notesData = [[NSUserDefaults standardUserDefaults] objectForKey:@"notes"];
NSArray *notes = [NSKeyedUnarchiver unarchiveObjectWithData:notesData];
```
