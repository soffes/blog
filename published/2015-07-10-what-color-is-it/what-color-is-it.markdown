---
title: What Color Is It
cover_image: cover.png
categories: development swift screensaver
---

One of my coworkers shared [What Colour Is It](http://whatcolourisit.scn9a.org/) in our design Slack channel the other day. It works by taking the current time as 6 digits and making that a [hex color](https://en.wikipedia.org/wiki/Web_colors#Hex_triplet). For example, in the header it's `#172952`. That's 5:29pm and 52 seconds. Kinda neat. I thought it was super cool so I decided to make it a screensaver.

**You can download the screensaver [here](https://github.com/soffes/WhatColorIsIt#readme).**

It's [less than 100 lines of code](https://github.com/soffes/WhatColorIsIt/blob/master/What%20Color%20Is%20It/View.swift). Give it a look if you're interested. I'm particularly fond of the font. I'm using new Swift 2 runtime checking:


```swift
if #available(OSX 10.11, *) {
    font = NSFont.systemFontOfSize(fontSize, weight: NSFontWeightThin)
} else {
    font = NSFont(name: "HelveticaNeue-Thin", size: fontSize)!
}
```

If it's El Capitan, San Francisco is used. Otherwise, Helvetica is used. The `weight` parameter is new in 10.11 so the check is necessary. Another cool thing is the numbers are monospace so it doesn't look funny as it ticks.

```swift
let fontDescriptor = font.fontDescriptor.fontDescriptorByAddingAttributes([
    NSFontFeatureSettingsAttribute: [
        [
            NSFontFeatureTypeIdentifierKey: kNumberSpacingType,
            NSFontFeatureSelectorIdentifierKey: kMonospacedNumbersSelector
        ]
    ]
])
```

The font descriptor API is pretty ugly, but you can do really neat things with it. You can get a font out of a font descriptor like this:

```swift
NSFont(descriptor: fontDescriptor, size: fontSize)
```

Anyway, enjoy the screensaver. I'd love to hear what you think of it. Hit me up [on Twitter](https://twitter.com/soffes).
