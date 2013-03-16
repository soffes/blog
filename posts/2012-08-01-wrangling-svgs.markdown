---
title: Wrangling SVGs
tags: [development, svg, web]
---

[Cheddar](http://cheddarapp.com) uses SVG ([Scalable Vector Graphics](http://en.wikipedia.org/wiki/Scalable_Vector_Graphics)) a lot. One of the big wins for using SVGs is they are vector, so they look great on Retina displays without you having to do any work.

Since I use [Grater](http://github.com/samsoffes/grater), everything looks great on iPhone, iPad, and desktops. I was using SVGs a few weeks before the Retina MacBook Pro came out. Since I had already optimized for the Retina mobile displays, I didn't have to do anything for the new MacBook Pro!

Anyway, I wanted everything to look crisp and was having trouble at first. After seeing [GitHub do it so well](https://github.com/blog/1135-the-making-of-octicons), I asked [a friend](http://twitter.com/jbrewer) how to do it and spent the time to make them great. It's actually very easy.

Abobe Illustrator CS6 is my tool of choice for editing SVGs. I've spent years in Photoshop, but my Illustrator skills are pretty weak. All of this will sound totally stupid if you're familiar with Illustrator.

1. Set your artboard to be the size you plan on displaying the image.

    > Click Document Setup > Edit Artboards

    If you're doing it at multiple sizes, do it at the most common. If you really want things to be crisp, duplicated it and follow the steps for each size.

2. Make sure your artboard's origin is on a whole point. You can edit this in the same place.

3. Scale your content to fit exactly in the bounds of your artboard

4. *Make sure all of your anchor points align to whole points.* This is key. For complex shapes, this may not be possible. For any straight lines, it is really important to line them up.

    Phil Coffman has [a great video on how to do this in Photoshop](http://methodandcraft.com/videos/pixel-hinting-vectors-in-photoshop) that's worth watching. It works the same way in Illustrator.

That's it. It took me about an hour to do all of Cheddar's SVGs. A few times I'd get everything all nice, realize I did it at a different size than it's displayed, scale it, and do it all over again.

Here's [before](http://soff.me/ISQj) and [after](http://soff.me/IRwn).

Using SVGs can save you a lot of time. It's worth checking out.
