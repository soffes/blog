---
title: Introducing SSPullToRefresh
categories: ios development objective-c
---

There are tons of pull to refresh views for iOS on GitHub. Every time I need to add pull to refresh to a project, I end up hacking one of them to pieces. This is silly. I wrote a better one: [SSPullToRefresh](http://github.com/soffes/sspulltorefresh).

## Customizable

SSPullToRefresh is highly customizable. There is a `contentView` property that allows you to set the view that shows when the user pulls. This is really great because you can simply make a view conforms to the `SSPullToRefreshContentView` protocol you're good to go. You don't have to hack up the pulling logic.

By default, a basic content view is set if you don't provide one. See the [readme](https://github.com/soffes/sspulltorefresh#readme) for the full details on customizing).


## Clean API

You don't have to implement all of the `UIScrollViewDelegate` methods and forward them. This is silly. SSPullToRefresh uses [KVO](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html) to track the scrolling. This is all you have to do to add it your scroll view:

``` objective-c
[[SSPullToRefreshView alloc] initWithScrollView:self.tableView delegate:self];
```

That's it. It will automatically add all of the necessary KVO, set its frame, and add itself as a subview at the right spot.

## Flexible

You can easily change the height of the view when it's fully expanded by setting the `expandedHeight` property. Easy as that.

Every pull to refresh view I've ever used doesn't take into account that you may want to change the content inset on your own as well. When you initialize `SSPullToRefreshView` with a scroll view, it will detect any content inset and make all changes relative to that. If you need to update it later, just set `defaultContentInset ` on your pull to refresh view. Assuming you set it as a property in your view controller, here's what that looks like:

``` objective-c
self.pullToRefreshView.defaultContentInset = newContentInset;
```

## Enjoy

I'm using this in [Cheddar](http://cheddarapp.com) and several other apps. Not having to hack the internals of a poorly implemented pull to refresh view is really refreshing.

The full source code is [on GitHub](https://github.com/soffes/sspulltorefresh). Enjoy.
