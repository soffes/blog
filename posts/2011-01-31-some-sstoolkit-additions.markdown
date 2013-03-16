---
title: Some SSToolkit Additions
tags: [cocoa, development, ios]
---

Over the weekend, I messed around and added some stuff to [SSToolkit](http://sstoolk.it). The most useable thing I added was a simple badge view and cell that wraps it for shows simple badges like Mail.app in iOS. Here's a screenshot:

[![SSToolkit](http://assets.samsoff.es/posts/some-sstoolkit-additions/badgeview.png)](http://sstoolk.it)

Hopefully someone will find that useful. I also switched to LLVM 1.6 and increased the warning level to be more strict. Lately I've been a big fan of stricter warnings. I feel like I'm writing better code when it makes me check types, etc.

My buddy, [@hectorramos](http://twitter.com/hectorramos) helped me document the class and fixed a few bugs in [SSSwitch](https://github.com/samsoffes/sstoolkit/blob/master/SSToolkit/SSSwitch.h). It still needs documentation if you want to help :)
