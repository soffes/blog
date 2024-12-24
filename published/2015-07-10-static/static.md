---
cover_image: cover.jpg
tags:
- swift
- development
- ios
---

# Static

Today, we open sourced a framework for iOS we've been using a ton internally called [Static](https://github.com/venmo/Static). It's a Swift 2 framework for working with static table views. We use it to power tons of screens in an upcoming project. It's also made prototyping table view-based things super productive.

Static's goal is to separate model data from presentation. `Row`s and `Section`s are your “view models” for your cells. You simply specify a cell class to use and that handles all of the presentation. See the [Usage](https://github.com/venmo/Static/#usage) section below for details.

## Building

Static is written in Swift 2 so Xcode 7b3 is required. There aren't any dependencies besides system frameworks.

## Installation

[Carthage](https://github.com/carthage/carthage) is the recommended way to install Static. Add the following to your Cartfile:

``` ruby
github "venmo/Static"
```

For manual installation, it's recommended to add the project as a subproject to your project or workspace and adding the appropriate framework as a target dependency.

## Usage

An [example app](https://github.com/venmo/Static/blob/master/Example) is included demonstrating Static's functionality. Check that out first if you prefer to learn by example.

### Getting Started

To use Static, you need to define [`Row`s](https://github.com/venmo/Static/blob/master/Static/Row.swift) and [`Section`s](https://github.com/venmo/Static/blob/master/Static/Section.swift) to describe your data. Here's a simple example:

```swift
import Static

Section(rows: [
    Row(text: "Hello")
])
```

You can configure `Section`s and `Row`s for anything you want. Here's another example:

```swift
Section(header: "Money", rows: [
    Row(text: "Balance", detailText: "$12.00", accessory: .DisclosureIndicator, selection: {
        // Show statement
    }),
    Row(text: "Transfer to Bank…", cellClass: ButtonCell.self, selection: {
        // Show transfer to bank modal
    })
], footer: "Transfers usually arrive within 1-3 business days.")
```

Since this is Swift, we can provide instance methods instead of inline blocks for selections. This makes things really nice. You don't have to switch on index paths in a `tableView:didSelectRowAtIndexPath:` any more!

### Customizing Appearance

The `Row` never has access to the cell. This is by design. The `Row` shouldn't care about its appearance other specifying what will handle it. In practice, this has been really nice. Our cells have one responsibility.

There are several custom cells provided:

* `Value1Cell` — This is the default cell. It's a plain `UITableViewCell` with the `.Value1` style.
* `Value2Cell` — Plain `UITableViewCell` with the `.Value2` style.
* `SubtitleCell` — Plain `UITableViewCell` with the `.Subtitle` style.
* `ButtonCell` — Plain `UITableViewCell` with the `.Default` style. The `textLabel`'s `textColor` is set to the cell's `tintColor`.

All of these conform to [`CellType`](https://github.com/venmo/Static/blob/master/Static/CellType.swift). The gist of the protocol is one method:

```swift
func configure(row row: Row)
```

This gets called by [`DataSource`](https://github.com/venmo/Static/blob/master/Static/DataSource.swift) (which we'll look at more in a minute) to set the row on the cell. There is a default implementation provided by the protocol that simply sets the `Row`'s `text` on the cell's `textLabel`, etc. If you need to do custom things, this is a great place to hook in.

`Row` also has a `context` property. You can put whatever you want in here that the cell needs to know. You should try to use this as sparingly as possible.

### Custom Row Accessories

`Row` has an `accessory` property that is an `Accessory` enum. This has cases for all of `UITableViewCellAccessoryType`. Here's a row with a checkmark:

```swift
Row(text: "Buy milk", accessory: .Checkmark)
```

Easy enough. Some of the system accessory types are selectable (like that little *i* button with a circle around it). You can make those and handle the selection like this:

```swift
Row(text: "Sam Soffes", accessory: .DetailButton({
  // Show info about this contact
}))
```

Again, you could use whatever function here. Instance methods are great for this.

There is an additional case called `.View` that takes a custom view. Here's a `Row` with a custom accessory view:

```swift
Row(text: "My Profile", accessory: .View(someEditButton))
```

### Custom Section Header & Footer Views

`Section` has properties for `header` and `footer`. These take a `Section.Extremity`. This is an enum with `Title` and `View` cases. `Extremity` is `StringLiteralConvertible` you can simply specify strings if you want titles like we did the *Getting Started* section.

For a custom view, you can simply specify the `View` case:

```swift
Section(header: .View(yourView))
```

The height returned to the table view will be the view's `bounds.height` so be sure it's already sized properly.

### Working with the Data Source

To hook up your `Section`s and `Row`s to a table view, simply initialize a `DataSource`:

```swift
let dataSource = DataSource()
dataSource.sections = [
    Section(rows: [
        Row(text: "Hello")
    ])
]
```

Now assign your table view:

```swift
dataSource.tableView = tableView
```

Easy as that! If you modify your data source later, it will automatically update the table view for you. It is important that you don't change the table view's `dataSource` or `delegate`. The `DataSource` needs to be those so it can handle events correctly. The purpose of `Static` is to abstract all of that away from you.

### Wrapping Up

There is a provided [`TableViewController`](https://github.com/venmo/Static/blob/master/Static/TableViewController.swift) that sets up a `DataSource` for you. Here's a short example:

```swift
class SomeViewController: TableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.sections = [
            Section(rows: [
                Row(text: "Hi")
            ]),
            // ...
        ]
    }
}
```

Enjoy.
