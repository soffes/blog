---
title: Sync Your Fonts With Dropbox Tutorial
tags: [dropbox, font, sync, tutorial]
---

This is a bit technical, but designer friends have no fear.

I want my fonts on all of my computers. [Dropbox][] makes it easy to share files between computers. Why not put my fonts in [Dropbox][]?

> Disclaimer: Backup your stuff before doing this.

1. Go to your home folder in Finder.
2. Copy your `Library/Fonts` folder inside your home folder into your Dropbox folder. Be sure it all copied before moving on.
3. Open Terminal in `/Applications/Utilities`. Don't worry. This won't be hard.
4. Type `sudo rm -rf ~/Library/Fonts` and press enter. It will ask you for a password, type the password you use to login to your Mac.
5. Type `ln -s ~/Dropbox/Fonts ~/Library/Fonts` and you're done!

That was easy right? Repeat these steps on any other Macs you use. Just drag your fonts from this folder into your Dropbox fonts folder and do steps 3-4. Enjoy.

**Update:** Turns out that Photoshop doesn't like this, so it's probably pointless. I thought it was a cool idea though. ==Stupid Photoshop.==

[Dropbox]: https://www.dropbox.com/referrals/NTY3Nzk3OQ
