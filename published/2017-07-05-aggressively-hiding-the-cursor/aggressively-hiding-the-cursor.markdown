---
tags:
- development
- Mac
---

# Aggressively Hiding the Cursor

I’m working on a Mac app that has a color picker in it. Here’s a screenshot:

![Loupe](loupe.png)

For this to work, I hide the cursor and have a custom view track your mouse movements. (When I say *cursor* I mean the pointer on screen you control with your mouse, and when I say mouse I mean your physical input device.) I use a full screen, borderless window and `NSTrackingArea` to do this. Nothing too crazy there. I do this to avoid dealing with custom a `NSCursor` since that was a lot more work.

When I show this fullscreen window, I simply call `NSCursor.hide()` and call `NSCursor.unhide()` when the window gets dismissed or loses focus. Easy enough.

==Here’s the catch.== If you violently move your mouse the cursor would come back. This took me awhile to figure out. If the system makes your cursor giant then it comes back. You never actually see it get giant though. This kinda seems like a bug. I know using `NSCursor` `hide` and `unhide` isn’t super reliable unless you control everything. I though having a full screen window was enough control. Oh well.

There was a simply solution though:

```swift
override func mouseMoved(with event: NSEvent) {
    // Whatever work I would normally do here

    // Workaround macOS making the cursor huge and unhiding it when you wiggle it violently
    NSCursor.hide()
}
```

Easy enough. Maybe I should use a custom cursor instead of this craziness?