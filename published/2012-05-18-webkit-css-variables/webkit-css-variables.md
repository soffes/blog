---
tags:
- development
- css
- web
---

# WebKit CSS Variables

CSS variables were just added to WebKit. This probably won't make it into a browser for awhile, but still really exciting.

The sad thing is the syntax is just horrendous.

``` html
<style>
  body {
    -webkit-var-foreground: green;
    -webkit-var-background: rgb(255, 255, 255);
    color: -webkit-var(foreground);
    background-color: red;
    background-color: -webkit-var(background);
  }
</style>

This text should be green on a white background. There should be no red visible.
```

Awhile back there was some discussion on the mailing list about copying how SCSS does it. It's a shame that didn't happen.
