---
tags:
- development
- ios
---

# Image Optimization on iOS

Recently in [IncrediBooth](http://incredibooth.com/), I greatly decreased the size of the IPA we send to Apple. ==We were around 70MB before everything and ended up at 31MB==. It was honestly really easy to shave that much off the app.

IncrediBooth is a universal iPad/iPhone app. With the last update, we added support for the new iPad's retina display. This made our bundle huge. IncrediBooth has a ton of full screen textures to help illustrate the physical metaphor. These images as 2048 x 1536 PNGs are just massive. Converting some of these to JPEGs saved a ton of space. It's unfortunate they don't load as quickly, but some PNGs that were 10MB+ were ~200Kb. This was a good first step.

Even after converting as much of the big textures as I could to JPEGs, I was still over the 50MB limit. My goal was to be under 20MB so older devices could download it without WiFi. I turned to my Twitter friends and found [ImageOptim](http://imageoptim.com/).

Next, I converted as many images to PNG8 as possible. In Photoshop, you can Save For Web as PNG8 instead of PNG24 for images that would work well as GIFs. Even though it doesn't support variable alpha, it's great for simple images.

ImageOptim is fantastic. Just give it all of your images and it will crank away on them. It runs your images through a series of tools to compress them as much as possible without reducing the quality. Even though I had saved-for-web all of the images, ==ImageOptim was able to compress most of them over 50%==. Some got as high as 90% savings. Amazing!

I ran all of the images through ImageOptim twice. The second time was able to compress some images even more. Remember ==this is all lossless compression==. Everything still looked great, but was way smaller. Really great stuff.

The last thing I tried to make things even smaller was [ImageAlpha](http://pngmini.com/) (by the creators of ImageOptim). It's a tool that lets you ==create PNG8 images with variable alpha==! This will save tons of space. It's a way more manual process than ImageOptim, but works well for larger images with alpha that don't have a lot of colors.

Note: Be sure to [disable Xcode's image optimization](http://imageoptim.com/xcode.html) or it will undo all of your hard work when it creates your bundle.

## Conclusion

I've heard mixed thoughts on these tools. Some Twitter friends said it caused issues for them. Personally, I haven't had any issues with these tools. Everything works amazingly well. ==If you're trying to shrink your bundle size, I highly recommend these tools.==

> If you want even crazier compression, checkout [Scribd's fork of AdvanceCOMP](https://github.com/scribd/advancecomp) by [John Englehart](https://github.com/johnezang) (the creator of JSONKit). It's a little too hardcore for my taste, but you may want to give it a try.
