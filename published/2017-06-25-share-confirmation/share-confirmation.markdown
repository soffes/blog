---
tags:
- development
- swift
- ios
---

# Share Confirmation

Recently, I added some visual confirmation what something was shared with the system share sheet on iOS. For things like copy or save to camera roll, there isn't visual confirmation that it worked from the system.

At first I considered making my own share actions for this and disabling the system ones but that seemed like a lot of work for adding a simple “it worked” to the screen. Then I had this idea:

```swift
func share(_ sender: UIView) {
  let viewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
  viewController.completionWithItemsHandler = { [weak self] type, completed, _, _ in
    guard completed, let title = type?.rawValue else { return }

    // Check share type and show confirmation
    if title == "com.apple.UIKit.activity.CopyToPasteboard" {
      SVProgressHUD.showSuccess(withStatus: "Copied!")
      SVProgressHUD.dismiss(withDelay: 1)
    } else if title == "com.apple.UIKit.activity.SaveToCameraRoll" {
      SVProgressHUD.showSuccess(withStatus: "Saved!")
      SVProgressHUD.dismiss(withDelay: 1)
    }
  }

  if let presentationController = viewController.popoverPresentationController {
    presentationController.sourceView = sender
  }

  present(viewController, animated: true)
}
```

Pretty simple! This uses [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) to show some visual feedback that it worked. This was really easy to add. I think this is a really welcome addition. You could obviously do this for any other type that you want. I didn’t want to do it for every type since some types (like share to Twitter) are really obvious when they work or are canceled.
