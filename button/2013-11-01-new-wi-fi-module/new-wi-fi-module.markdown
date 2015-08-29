---
cover_image: cover.png
tags:
- button
---

# New Wi-Fi Module

At first, I had planned to use [electric imp](http://electricimp.com/) for WiFi in Button. There’s a few things that I really don’t like about electric imp (one being their name is actually all lower case).

The biggest drawbacks are you have to do a “BlinkUp” to give it the WiFi credentials. This requires you to hold your phone up to the actual WiFi card and have the screen flash a bunch. This is really error prone. The user could accidentally move the phone and bad lighting conditions are the biggest two. This also requires part of the card is exposed to the outside of the case.

I really wanted to use Bluetooth to setup Button. They said the only work around is to connect something to where the light sensor connects and send my own data (which is also error prone).

The other thing is electric imp can’t make local network requests. This is a big deal to me. This prevents users from controlling stuff like [Sonos](http://sonos.com) or [Hue](http://meethue.com) easily.


## Solution

I was talking with [Lockitron](http://lockitron.com/) on the phone to get help setting up my Lockitron. They use electric imp (which is actually where I heard about it). I asked him how he liked it and if they were going to work around the BlinkUp. He said they didn’t plan on it because electric imp told them they couldn’t.

In passing, he mentioned the Texas Instruments CC3000 chip as an alternative. After doing a quick Google, I ordered one.

Here’s a demo right after I got it working:

<iframe src="https://player.vimeo.com/video/78311996?color=0a9afa&amp;title=0&amp;byline=0&amp;portrait=0" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

Not too exciting, but yay it works. I thought I’d see if I could control Sonos with the new chip (since that was the whole point). After a little playing around with my sonos gem, I finally got it going! Here’s a demo:

<iframe src="https://player.vimeo.com/video/78323160?color=0a9afa&amp;title=0&amp;byline=0&amp;portrait=0" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>


## Onward

This is super exciting to me! I’m probably going to stick with this chip unless anything comes up. In my testing it’s been pretty great. I still need to figure out power management stuff, but hopefully that’s not too hard.

Next, I’m working on getting a prototype in an inclosure with a proper button. Hopefully my Bluetooth LE stuff comes soon so the app integration can get going.

Thanks for listening. Follow [@thebuttonco](https://twitter.com/thebuttonco) for more updates or [@soffes](https://twitter.com/soffes) if you just want the important stuff.
