---
tags:
- engineering
- apple
---

# Apple Developer Tools

Recently, my friend, [Brian Minor](https://twitter.com/brianminor), [pointed out](https://twitter.com/brianminor/status/458611937539272704) that only iTunes Connect and iAd Gallery are the only two Apple iPhone apps that haven’t been updated to iOS 7 yet. Sure, we complain about Apple developer tools all the time. Let’s take a closer look.

## The Good

Compared to the Android tools, Xcode is fantastic. I plan on doing a more in-depth comparison on Android & iOS soonish. Anyway, if you look at any of the other tools, Xcode is fantastic. It’s pretty, generally works well, and is overall a joy to use. Imagine if we had to do all of this with Makefiles and Terminal.

iTunes Connect let’s you publish to the store. You can upload your app right from Xcode. We have team management in the developer portal. We can make certs whenever we want. There’s a lot there.

==Let’s not forget the documentation.== That’s probably Apple’s best developer resource.

## The Bad

Xcode is terrible. iTunes Connect is terrible. The developer portal is terrible.

Not quite. We like to just complain about the bad stuff though. Xcode does a lot of really dumb stuff. Provisioning profiles from Xcode are a joke. iTunes Connect is hard to use unless you’ve learned where everything is already. It has definitely improved, but it’s still not great.

That’s how I’d describe all of the Apple developer tools: ==Overall everything is good, but not great.== Look at the level of polish on the rest of Apple’s apps. The developer tools are definitely second class citizens.

## The Why

There is a simple explanation for this: ==Apple developers don’t use most of the Apple developer tools.==

You’re not allowed to have your own apps in the App Store if you work at Apple. Surely some people have to use iTunes Connect (maybe?). I’d wager everyone that works on iTunes Connect doesn’t use it and never will because they’re not allowed to have a real use for it.

The same goes for provisioning. Apple employees don’t really need to worry about this. Same for the Developer portal, etc.

Xcode gets the most love since they use that internally, but it definitely doesn’t get a much love as other tools Apple makes that normal people will use. I understand that. It just sucks.

## The Fix

Financially, it doesn’t make sense for Apple to go nuts and make all of this stuff amazing. Polish is expensive and most of this stuff people won’t see. If that’s where we leave it, that’s fine. I still love the iOS platform and will continue to write software for it with the tools we have.

Imagine if Tim Cook decided to learn how to code and wanted to publish an iOS app on the store. Things would change.

---

Another example: bug reporter. Internally, they use a Mac app for radars. We get to use the awful web version. I wonder how much better things would be if we had an easy way to report issues and communicate with Apple. Thanks [Matt Zanchelli](https://twitter.com/mdznr) for pointing it out!
