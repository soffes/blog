---
tags:
- web
- development
- css
---

# Unjarring The Responsive Web

[Responsive web design](http://en.wikipedia.org/wiki/Responsive_Web_Design) is what all the cool kids are up to these days. Basically a "responsive" site uses [CSS media queries](http://www.w3.org/TR/css3-mediaqueries/) to change the page based on certain parameters. ([This article](http://www.alistapart.com/articles/responsive-web-design/) a good place to start if you're new to the topic.) Usually this is `width`. The designer can change the appearance of the page based on the width of the browser. ==This allows the same design to be used on iPhone, iPad, and the desktop with minimal work instead of three different designs.==

## Jarring Jerry

==Most responsive sites are really jarring== when they jump between media query sizes. Elements start jumping around and if you were reading something, your spot may or may not still be on the screen. I really wish people would take the time to improve this. It's not hard.

Here's a concrete example. Let's say you have a header on a website and want it to be smaller on mobile. This is easy with the following media query:

``` css
/* By default, the header has a 3em margin on the top and bottom */
body > header {
  margin: 3em auto;
}

/* For windows greater than 640px, use the following styles */
@media all and (min-width: 640px) {
  body > header {
    /* Use a 5em margin on the top and a 4em margin on the bottom */
    margin: 5em auto 4em;
  }
}
```

The comments in the code block explain each part. If you were to have this on a page and resized the window less than 640px, you would see the entire page jump up `2em`. This is less jarring than a lot of stuff I've seen, but this is a simple example.

==Simple solution: use a transition.== Transitions are easy. Let's update our code from earlier:

``` css
body > header {
  /* Same margin code from the previous example */
  margin: 3em auto;

  /* Transition anytime the margin changes */
  -webkit-transition-property: margin;
  -moz-transition-property: margin;
  -ms-transition-property: margin;
  -o-transition-property: margin;
  transition-property: margin;

  /* Animate for 0.2 seconds */
  -webkit-transition-duration: 0.2s;
  -moz-transition-duration: 0.2s;
  -ms-transition-duration: 0.2s;
  -o-transition-duration: 0.2s;
  transition-duration: 0.2s
}

/* Exactly the same as before */
@media all and (min-width: 640px) {
  body > header {
    margin: 5em auto 4em;
  }
}
```

Easy! Now if you resize the window, the header will animate to it's new position instead of jumping. ==Try it right now.== This is all taken from my blog's stylesheet.

One thing to note, all of those vendor prefixes are really annoying. I highly recommend using [Compass](http://compass-style.org). You can replace all of that with just two lines:

``` scss
body > header {
  margin:3em auto;
  @include transition-property(margin);
  @include transition-duration(0.2s);
}

/* The media query is unchanged */
```

I'd love to see this technique used more. If you want to hide an element, instead of `display: block` and `display: none`, ==try using opacity and animating things in and out==. (I realize this isn't always possible.) This makes responsive sites feel immensely more professional instead of hacky and jarring.

Of course the best thing to do when making a responsive site is ==avoid media queries as much as possible==.
