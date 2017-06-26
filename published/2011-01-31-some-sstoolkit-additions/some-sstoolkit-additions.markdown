---
tags:
- development
- ios
- objective-c
---

# Some SSToolkit Additions

Over the weekend, I messed around and added some stuff to [SSToolkit](https://github.com/soffes/sstoolkit). The most useable thing I added was a simple badge view and cell that wraps it for shows simple badges like Mail.app in iOS. Here's a screenshot:

[![SSToolkit](1P1e2B2f3M2x2f3o2w12383U223I3L0Z.png)](https://github.com/soffes/sstoolkit)

Hopefully someone will find that useful. I also switched to LLVM 1.6 and increased the warning level to be more strict. Lately I've been a big fan of stricter warnings. I feel like I'm writing better code when it makes me check types, etc.

My buddy, [@hectorramos](http://twitter.com/hectorramos) helped me document the class and fixed a few bugs in [SSSwitch](https://github.com/soffes/sstoolkit/blob/master/SSToolkit/SSSwitch.h). It still needs documentation if you want to help :)
