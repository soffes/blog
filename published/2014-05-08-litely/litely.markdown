# Litely

For the last 5 months, I’ve been working on [Litely for iOS](https://itunes.apple.com/app/litely/id850707754?mt=8&amp;uo=4&amp;at=1l3vmtU). It’s a photo app for iOS designed by my friend [Cole Rise](https://twitter.com/colerise) that I had the pleasure of building. Litely is available for iPhone and iPad, in 14 languages, starting today!

## Connecting with Litely

Cole is an amazing photographer and designer. I’ve been following Cole since 2010 when I saw some of [his photography](http://colerise.com) as my friend’s iPad background. I immediately bought his [Litely](http://lite.ly) presets for Lightroom when they were released. (By the way, you should follow Cole [on Instagram](https://instagram.com/colerise).)

Litely started as a set of photo presets for Lightroom, Aperture, Photoshop, and Adobe Camera Raw. They are very subtle effects that make a huge difference. I bugged him on Twitter one day to make Litely for iPhone and he was into the idea. A few weeks later, he hired me to start working on it.

## Building Litely

Last night, we were reflecting about the process and Cole had a really good quote that sums it up well:

> My taste plus your engineering made something really great.
>
> — Cole Rise

Cole’s designs for this app are amazing. It’s definitely the most beautiful app I’ve worked on. We spent a lot of time polishing the design for every detail of the app together. It was a blast implementing all of the nuance of it.

==Having the ability to propose ideas or just run with something to see how it turned out made this a really enjoyable project to work on.== That’s the key to my enjoyment of freelance work. Having the sense of some ownership of the end product’s direction is a great feeling.

## Neat Things

There’s a bunch of stuff I’m proud of in this app. I’m just going to point out a few of them from a design or engineering perspective. (It’s not going to get too nerdy so stay with me.)

### Parallax Everywhere

Everywhere an image appears (with the exception of the grid because that would be overwhelming) it parallaxes if it doesn’t fit on screen. My favorite way to try this out is loading up a panorama and heading over to adjustments. ==I didn’t use the built-in motion effects to make this. I rolled my own so everything would be silky smooth.==

### Smart Adjustments

This is a really great example of Cole’s amazing taste in color and some clever engineering. ==All of the adjustments aren’t simply what they say. They’re smart.==

For example, exposure is a smart exposure. If you did a plain exposure adjust, it starts to look bad as you get too high or too low. We do a bunch of clever things to make sure your photo stays looking great all the time. Same for the rest of them. Vignette is my favorite. There’s some really neat magic at work.

### Compare View

The compare view is probably my favorite thing. Cole posted this photo during the development of the app:

![Unknown](https://roon-media.s3.amazonaws.com/blogs/1/1r0B3p350Z023Z020R303B0O0D133u3r/giant.jpg)

I thought it would be awesome to show this in the store for the sample images. I proposed that holding would animate in the before view masked. Cole was into running with the idea and it turned out really well. Here’s the final version in the app:

![iOS Simulator Screen shot May 7, 2014, 10,52,36 PM](https://roon-media.s3.amazonaws.com/blogs/1/070L1p0o361z2d2k3Y1V3o3k1t3R110Z/giant.png)

==I implemented this all using layer animations and masks.== It’s probably my new favorite thing in iOS development. It’s been there since the beginning, but I’ve found a bunch of really great uses for masks lately. I use masks a bunch of other places throughout the app.

There’s a bunch of other neat stuff in the app like a file format I made specifically for storing Litely colors, all non-destructive editing, tons of custom transitions, and some clever localization techniques. I hope you enjoy the magic.

### Open Source

I used a bunch of open source stuff in the app. Here’s the [Podfile](https://gist.github.com/soffes/965622a80351e11c67f9) if you’re curious. All of them are stuff I’ve written except for [CMDAwesomeButton](https://github.com/calebd/CMDAwesomeButton) and [SVProgressHUD](https://github.com/samvermette/SVProgressHUD). Thanks [Caleb](https://twitter.com/calebd) and [Sam](https://twitter.com/samvermette)!

## In Closing

This was a really fun app to work on. We both have a lot we want to add to it. I’m excited to see what happens with it. It was really great working with such a great designer as a client.

I really hope you like the app. Checkout [Litely in the App Store](https://itunes.apple.com/app/litely/id850707754?mt=8&amp;uo=4&amp;at=1l3vmtU) and let me know what you think [on Twitter](https://twitter.com/soffes)! Also give the exclusive [Engadget story](http://www.engadget.com/2014/05/08/litely-ios-hands-on/) a look if you want to hear a little from Cole about the app.

Also, in these last 5 months, I've also spent a ton of time on a few other projects. Hoping to announce more on those soonish.

<span style="color:#999">Special thanks to  [Caleb](https://twitter.com/calebd) for helping me with some nuts math to make the crop stuff work.</span>
