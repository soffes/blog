---
tags:
- development
- swift
---

# Network Testing in Swift with DVR

Networking testing is hard. There’s a few approaches. The most common I’ve seen is stubbing requests. [OCMock](https://github.com/erikdoe/ocmock) is a [common approach](http://ashfurrow.com/blog/your-first-objective-c-unit-test-with-ocmock/).

Personally, I’ve never been a fan of [mocks and stubs](https://en.wikipedia.org/wiki/Mock_object). At some point you just end up testing your mocks and stubs instead of your real code. When it comes to testing, I want unit tests to test logic and integration tests to test compositions.

I think focusing on testing everything in isolation isn’t great. If you have stuff that is hard to test in isolation, either it should be redesigned to more encapsulated or due to the nature of it, you need to test it at a higher level.

## Testing Strategies

I think network testing is best done at a broader level. When you’re building an API wrapper (or whatever else that talks to the networking), the core responsibility of the object is to create requests and handle responses—so that’s what we need to test.

In the best session of WWDC 2015, [Protocol-Oriented Programming in Swift](https://developer.apple.com/videos/wwdc/2015/?id=408), they showed the power lots of new Swift features. At one point, Dave Abrahams had a great quote:

> This kind of testing is really similar to what you get with mocks, **but it’s so much better**. ==Mocks are inherently fragile.== You have to couple your testing code with the implementation details of your test.

He goes on to talk about how you can make interchangeable objects with the new protocols stuff in Swift 2 instead of stubbing. This is similar to the classic [dependency injection](https://en.wikipedia.org/wiki/Dependency_injection) approach. I think this it the best way to test networking.

## API Design

We're going to look at [my Mixpanel library](https://github.com/soffes/Mixpanel) as an example for the rest of this. It's a really simply library for sending events to [Mixpanel](http://mixpanel.com).

Let's talk about designing your network client's API. I use plain `NSURLSession` as much as possible. Unfortunately, [AFNetworking](https://github.com/AFNetworking/AFNetworking) and [Alamofire](https://github.com/alamofire/alamofire) don't allow you to initialize a manager with a custom session. Maybe, they'll add that at some point down the road. Personally, I'm a fan of one less dependency. (AFNetworking and Alamofire are great though.)

Here's the initializer for my Mixpanel client:

```swift
public let URLSession: NSURLSession

public init(token: String, URLSession: NSURLSession = NSURLSession.sharedSession()) {
    self.token = token
    self.URLSession = URLSession
}
```

There is a `URLSession` parameter that defaults to the shared session. This is handy since most of the time you won't have to change this. Internally, it uses this instance to do all of its networking.

This is great because ==we can easily inject other sessions== instead of the regular shared session.

## Disabling Networking

Mixpanel has a property called `enabled` that defaults to `true`. You can set this to `false` to easily disable tracking in development. Testing this is pretty easy with dependency injection. First, let's make an `NSURLSession` subclass:

```swift
class DisabledSession: NSURLSession {
    override func dataTaskWithRequest(request: NSURLRequest, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionDataTask? {
        XCTFail("Networking disabled")
        return nil
    }
}
```

Now we can write a test to ensure we don't do any networking:

```swift
func testDisabling() {
    let expectation = expectationWithDescription("Completion")

    var client = Mixpanel(token: "asdf1234", URLSession: DisabledSession())
    client.enabled = false
    client.track("foo") { success in
        XCTAssertFalse(success)
        expectation.fulfill()
    }

    waitForExpectationsWithTimeout(1, handler: nil)
}
```

This passes because out assertions in our test pass and the call to `XCTFail` is never hit. Great! Let's move onto the main event.

## Introducing DVR

[DVR](https://github.com/venmo/dvr) is a project I recently wrote [at work](https://venmo.com). It’s heavily inspired by [VCR](https://github.com/vcr/vcr) for Ruby. There’s a few key differences though.

Unlike VCR or other [Objective-C implementations](https://github.com/dstnbrkr/VCRURLConnection), doesn't have any global state and doesn't swizzle or monkey-path things to get in place. It's intended to by used by dependency injection.

DVR provides an [`NSURLSession` subclass](https://github.com/venmo/DVR/blob/master/DVR/Session.swift). When you try to make a request with the session, it will look for a prerecorded session. If one is found, it will play it back. If not, it will record it and then let you know you need to add the recording to your project. We'll look at this more in detail in a minute. Here's an example:

```swift
func testTracking() {
    let expectation = expectationWithDescription("Completion")

    let client = Mixpanel(token: "mytoken", URLSession: Session(cassetteName: "tracking"))
    client.track("test1", time: NSDate(timeIntervalSince1970: 1434954974)) { success in
        XCTAssertTrue(success)
        expectation.fulfill()
    }

    waitForExpectationsWithTimeout(1, handler: nil)
}
```

Easy as that! No real network requests were made since I had [a cassette named "tracking"](https://github.com/soffes/Mixpanel/blob/master/Mixpanel/Tests/Fixtures/tracking.json) in my test bundle. DVR simply plays back the request.

## Playback

The playback is actually very simple. DVR adds private extensions to [NSURLRequest](https://github.com/venmo/DVR/blob/master/DVR/URLRequest.swift) and [NSURLResponse](https://github.com/venmo/DVR/blob/master/DVR/URLResponse.swift) for serialization and deserialization. When a request is recorded, it serializes the request and response and saves it to disk. When a request is played back, it simple reads the request and response from disk, deserializes it, and calls the completion callback on the `NSURLSessionTask` with the exact same inputs as it did when it recorded.

I'm a big fan of this approach for network testing. As far as your network client is concerned, the actually networking doesn't matter. It just cares about requests as inputs and responses as outputs. Whatever transforms requests to responses is opaque to the client. Using custom sessions with dependency injection here is a perfect fit.

I'd love to hear what you think of this approach! I'm [@soffes](https://twitter.com/soffes) on Twitter—say hi!
