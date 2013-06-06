---
title: UITableViewCell Silly Magic
tags: [development, uikit]
---

Ever had a `UITableViewCell`'s `imageView` not update when you set it's `image` in a callback or block? It's amazingly frustrating. I usually end up going over and over the code to make sure it sets it on the main thread, the image isn't `nil`, the image view is on the screen, etc, etc.

### The Problem

`UITableViewCell`s don't update when you set the `imageView`'s `image`. `UITableViewCell`'s `imageView` is magical and stupid. If you don't have an image in the `imageView`, it will nil it out and remove it from the `contentView`. When you set the image, it will cache it and do some silliness so your updates don't work.

### The Solution

==Make your own image view.== Easy as that. Don't use the `imageView` property unless you want it to work exactly the way Apple uses it in Music.app for albums. For anything else, just make your own and add it to the `contentView`.

Trust me, you'll save yourself hours of frustration.
