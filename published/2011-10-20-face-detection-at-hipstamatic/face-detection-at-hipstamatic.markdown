---
cover_image: cover.jpg
---

# Face Detection at Hipstamatic

Since I joined the ranks at Hipstamatic [a few months ago](/hey-synthetic), I've been working on a lot of different things (including some really exciting new stuff I'll be able to show off in a few weeks).

### HipstaProcessor

My first big project here was refactoring all of our image processing from [Hipstamatic](http://hipstamatic.com), [IncrediBooth](http://incredibooth.com), and some upcoming stuff into a library that we can reuse called HipstaProcessor.

This has been a great project. HipstaProcessor runs on iOS and Mac (which I was pretty proud of). This gives us the ability to test out effects quickly as we build them instead of the tedious  process of change the effects, putting a build on the device, and testing with whatever images are on the device.

Also, having all of our image processing code in one place makes for lots of reuse of tested and solid code instead of recreating the wheel every time we need to process an image in an app (which is kinda our thing).

### Face Detection

Apple added [`CIDetector`](http://developer.apple.com/library/ios/#documentation/CoreImage/Reference/CIDetector_Ref/Reference/Reference.html) in iOS 5, which is really fantastic. It allows you to find faces in images. Here's a really basic example:

``` objective-c
// Use high quality detection
NSDictionary *detectorOptions = [NSDictionary dictionaryWithObjectsAndKeys:
  CIDetectorAccuracyHigh, CIDetectorAccuracy,
  nil];

// Create the detector
CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace context:ciContext options:detectorOptions];

// Loop through all of the faces it found
for (CIFeature *feature in [detector featuresInImage:ciImage]) {
  // Simply draw a solid color in the face's rect
  // Obviously you could do something much more interesting
  CGContextFillRect(context, feature.bounds);
}
```

It's actually a lot easier than I thought it would be. It works by finding two eyes and other face features. For people with hair that covers one eye, it won't see them. It also does a pretty poor job at finding people with darker skin, especially in low light.

Since we already had HipstaProcessor going in IncrediBooth, it was easy to simply add face detection to HipstaProcessor and then get it in IncrediBooth instantly. Pretty great stuff.

### Haus O' Haunt

<a href="http://itunes.apple.com/app/incredibooth/id378754705?mt=8" rel="external nofollow"><img src="result.jpg" alt="Haus O' Haunt Sample" style="float:left;padding:0.25em 1em 1em 0" /></a> In [IncrediBooth 1.3](http://itunes.apple.com/app/incredibooth/id378754705?mt=8) (which comes out October 21st) ==we added a new booth called Haus O' Haunt== that features face detection (among some other new fun effects). This is our Halloween booth, and we went crazy making some spooky effects. It was a really fun time, and I think the effects turned out really great!

The first setting in the booth, called Markup, randomly finds some of the faces and chooses a random marker stroke to place over the face. It's really fun to watch it in action!

So [checkout IncrediBooth](http://itunes.apple.com/app/incredibooth/id378754705?mt=8) to see Haus O' Haunt and all of the other new fun effects!

### The Future

It's pretty nuts how easy this is now. I remember thinking that face detection is forever away and super hard to do unless you have tons of engineers. It's amazing that Apple has opened this up to everyone. I'm really excited about things to come!

~~By the way, we're hiring at Hipstamatic. Email me if you want to make some cool iOS or Rails awesomeness: [sam@synth.tc](mailto:sam@synth.tc)~~
