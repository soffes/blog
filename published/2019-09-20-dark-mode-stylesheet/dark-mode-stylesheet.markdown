# Dark Mode Stylesheet

With iOS 13 coming out yesterday, there are a lot more folks are experiencing system-wide Dark Mode for the first time. As you navigate around the system apps in Dark Mode, it’s really nice to see everything be dark. The moment you open up an app that doesn’t support Dark Mode, it can be really jarring. Websites in Safari are one of the biggest offenders for me. We can fix this though.

I recently made my [personal website](https://soff.es) and [blog](https://soffes.blog) support a dark theme if the user’s device has dark mode enabled. This is really easy to achieve with a relative new features in CSS, [custom properties](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties) (aka CSS variables). They are already [widely supported](https://caniuse.com/#feat=css-variables) too!

Here’s how to define variables:

```css
/* Define variables for Light Mode in this selector */
:root {
  /* Variables must to start with `--` */
  --body-foreground: #111;

  /* You can name these variables whatever you want */
  --body-background: #fff;
}
```

You can override them in a media query for Dark Mode:

```css
/* This media query matches Dark Mode */
@media (prefers-color-scheme: dark) {
  :root {
    /* Override the Light Mode values */
    --body-foreground: #eee;
    --body-background: #111;
  }
}
```

Here’s how to use the variable:

```css
body {
  color: var(--body-foreground);
  background-color: var(--body-background);
}
```

Now your site will automatically switch colors when the user toggles their system setting. You can try it right now to see it in action on this post.

I think taking the time to adjust your website to support Dark Mode is a really nice touch that someone seeing mostly dark UI will really appreciate when they run across it.
