---
tags:
- development
- mac
---

# Developer ID, Mountain Lion, and the Keychain

Recently, I released a [Cheddar for Mac](http://cheddarapp.com/mac) beta. Since it's a beta I'm distributing on the [Cheddar](http://cheddarapp.com) website, I'm signing it with [Developer ID](https://developer.apple.com/resources/developer-id/). Basically, if you're running Mountain Lion with the default settings and try to open an app that isn't signed with Developer ID or downloaded from the Mac App Store, it won't let you open it.

I'm all for Developer ID. I'm really glad Apple spent the time to make it. There is one problem though. If you are using Mountain Lion, it's totally broken. You can't reliably use the Keychain if you build with Mountain Lion. Writes work alright, but every read gives a `–25293` ("Authorization/Authentication failed.").

I have read lots on this topic in the two days I spent trying to solve this. Most of them said use 10.7 or 10.8.1. Since I was already on 10.8, I tried 10.8.1, but it don't work for me. I tried the release of Xcode and the latest developer preview. Both didn't work on 10.8 and 10.8.1. Finally, I resorted to installing 10.7 on an external hard drive and booting from that, and that worked!

If you're like me, installing 10.7 is difficult since there is no physical media for it. If you are on a device that has Thunderbolt on it, you can easily get a copy though. Simply hold Command-Option-R while booting to start internet recovery. This will download the recovery partition for 10.7 from the internet. You can now install it on an external hard drive and boot from that.

Simply downloading Xcode from the App Store and building with no settings changed or anything fixed the problem. I really hope Apple fixes this. I've heard it's fixed in the 10.8.2 seed, but I haven't tried it or can comment on NDA'd releases.

Anyway, if you run into this issue, the easiest way is to just get an external and install 10.7 so you can get on with real development instead of fighting with this stupidness for a day.

By the way, I use [SSKeychain](http://github.com/soffes/sskeychain) to access the Keychain. It's a simple Objective-C wrapper with documentation, tests, and everything! I'd love to hear what you think of SSKeychain or Cheddar for Mac. Let me know [on Twitter](http://twitter.com/soffes).
