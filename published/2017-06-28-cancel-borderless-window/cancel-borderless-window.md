---
tags:
  - development
  - mac
---

# Cancel Borderless Window

I just spent the last hour trying to figure out why `cancelOperation` wasn’t getting called in an `NSWindowController` subclass. At first I tried `performKeyEquivalent` in the window controller or in a custom `NSWindow` subclass. That didn’t work. I then resorted to `keyDown` in the window subclass and that wasn’t getting called.

After a long while, I figured out that my window wasn’t becoming key even after I called `makeKeyAndOrderFront`. It turns out windows with `borderless` in the `styleMask` cannot become key by default. You can solve this with a tiny amount of code in a window subclass:

```swift
class MyWindow: NSWindow {
    override var canBecomeKey: Bool {
        return true
    }
}
```

So ya. Frustrating. This is actually documented, but it took me a really long time to realize the window wasn’t becoming key and then why.

When you present your window, you’ll need to make sure your app is active. In this case, I have `LSUIElement` set to `YES` (this hides the app from the doc so it isn’t ever active by default) so I had to explicitly make my app active like this:

```swift
NSApp.activate(ignoringOtherApps: true)
window.makeKeyAndOrderFront(nil)
```

So now, all I want to do is let you press escape in the window and have it close the window from the window controller. Turns out `cancelOperation` isn’t called in the window controller for some reason. It looks to call `cancel` instead. This isn’t a method on `NSResponder` or anything. So weird.

Anyway, add this to your window controller subclass:

```swift
func cancel(_ sender: Any?) {
    window?.orderOut(sender)
}
```

And there you go. Now you can press escape to dismiss a borderless window. There goes my night. Hopefully this will save you some time.
