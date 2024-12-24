---
tags:
- development
---

# SSToolkit 2.0

Today, I released [SSToolkit 2.0](https://github.com/soffes/sstoolkit). The first commit was September 9, 2009, but there are classes in SSToolkit that even predate that. Some of the code in there I wrote before the App Store even came out. ==This junk is old.==

After some major frustration last year with [CocoaPods](http://cocoapods.org), I decided to remove support for CocoaPods from SSToolkit. The maintainers of CocoaPods couldn’t write a podspec that actually worked for SSToolkit and I was tired of fighting with it. I really like CocoaPods, but there have been plenty of bumps along the way.

[I decided](https://github.com/soffes/sstoolkit/issues/189) to break SSToolkit into several libraries. This came with the support from the CocoaPods folks, so I got going about 8 months ago.

Today, I woke up to someone and the CocoaPods creator going back and forth about SSToolkit and what needed to be done. I decided to just release SSToolkit version 2.0 which replaces the all of the previous stuff.

==This doesn’t come lightly.== SSToolkit is my most popular piece of open source software. Currently there are 2,258 stars and 433 forks. It’s among the top Objective-C libraries on GitHub. I know a ton of people use it and I realize this will break a lot of things.

Hopefully it isn’t too painful to move to all of the new libraries. Honestly, I don’t think people should actually use SSToolkit. Just using parts of it you need is a much better approach.

Here’s everything that’s included in SSToolkit 2.0.0:

* [SAMAddressBar](https://github.com/soffes/SAMAddressBar) — Clone of Safari's address bar from iOS 6.
* [SAMBadgeView](https://github.com/soffes/SAMBadgeView) — Simple badge view.
* [SAMGradientView](https://github.com/soffes/SAMGradientView) — Easy gradients in UIKit.
* [SAMHUDView](https://github.com/soffes/SAMHUDView) — Kinda okay HUD.
* [SAMLabel](https://github.com/soffes/SAMLabel) — UILabel with vertical alignment and text insets.
* [SAMLoadingView](https://github.com/soffes/SAMLoadingView) — Simple loading view.
* [SAMCircleProgressView](https://github.com/soffes/SAMCircleProgressView) — Determinate, circular progress view.
* [SAMRateLimit](https://github.com/soffes/SAMRateLimit) — Simple utility for only executing code every so often.
* [SAMTextField](https://github.com/soffes/SAMTextField) — Handy UITextField additions like insetting text.
* [SAMTextView](https://github.com/soffes/SAMTextView) — Add a placeholder to UITextView.
* [SAMWebView](https://github.com/soffes/SAMWebView) — Push UIWebView to its limits.
* [SAMCategories](https://github.com/soffes/SAMCategories) — A collection of useful Foundation and UIKit categories.

Several of these libraries have had big improvements since their abstraction from SSToolkit.

Onward.
