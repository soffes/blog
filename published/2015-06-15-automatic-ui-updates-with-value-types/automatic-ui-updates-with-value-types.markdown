---
tags:
- engineering
- swift
---

# Automatic UI Updates with Value Types in Swift

[Value types](https://developer.apple.com/swift/blog/?id=10) are one of my favorite things in Swift. At first, I was resistant. It’s a much different way of thinking. Let’s look at a simple example that really shows the power.

I was recently working on a little control for entering in numbers on Apple Watch. Here's the code:

``` swift
public struct NumberPad: Printable {

    // MARK: - Properties

    public var value: Double

    public let decimalPlaces: UInt

    public var description: String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.maximumFractionDigits = Int(decimalPlaces)
        formatter.minimumFractionDigits = currencyFormatter.maximumFractionDigits
        return formatter.stringFromNumber(value)!
    }

    public var isEmpty: Bool {
        return value == 0.0
    }


    // MARK: - Initializers

    public init(value: Double = 0.0, decimalPlaces: UInt = 2) {
        self.value = value
        self.decimalPlaces = decimalPlaces
    }


    // MARK: - Manipulation

    public mutating func insert(place: Int) {
        let offset = pow(10.0, Double(decimalPlaces))
        var int = Int(value * offset)
        int *= 10
        int += place
        value = Double(int) / offset
    }

    public mutating func deleteBackwards() {
        let offset = pow(10.0, Double(decimalPlaces))
        var int = Int(value * offset)
        int /= 10
        value = Double(int) / offset
    }
}
```

It's really straight forward. There's a little bit of math to insert or delete numbers. It's not bad though. Here's how you use it:

``` swift
var pad = NumberPad()
pad.insert(7) // $0.07
pad.insert(5) // $0.75
pad.insert(0) // $7.50
pad.deleteBackwards() // $0.75
```

Easy enough. In my view controller, I use a button's action to call insert on my `NumberPad` that's an instance variable. Here's an action in the view controller:

``` swift
func one(sender: AnyObject?) {
    numberPad.insert(1)
}
```

Now we need to connect the number pad's label to the number pad's formatted value. Traditionally I would have reached for KVO or the delegate pattern.

==Here's the awesome part.== Swift's powerful support for value types makes this so easy. Let's look at the code in the view controller where we declare the `NumberPad` instance variable.

``` swift
private var numberPad = NumberPad(value: 0, decimalPlaces: 0) {
    didSet {
        amountLabel.setText(numberPad.description)
    }
}
```

That's it. ==Whenever the number pad changes, the label changes too!== Because it's a struct, which is a value type, `didSet` gets called whenever it changes. So simple.

If you look back at the implementation for `insert` and `deleteBackwards` in `NumberPad` above, you can see they both have the `mutating` keyword. I love how clear it is that calling those will cause `didSet` to get called.

Say we had the following:

``` swift
let pad = NumberPad()
pad.insert(1) // Error!
```

The second line is an error. Calling `insert` mutates the struct which isn't allowed since it was declared with `let`. If we change that to `var`, then it's totally fine. This is great if you need to have something mess with a struct and then send it to the background for processing. You could send an imutable copy (or mutable if you wanted) to the background for processing.

Hopefully this shows some of the power of value types in Swift. I highly recommend watching [Andy](http://2014.funswiftconf.com/speakers/andy.html) and [Justin](http://2014.funswiftconf.com/speakers/justin.html)’s talks from Functional Swift 2014. Those have been the most helpful things to me in my functional Swift learning.

I'd love to hear what you think about value types in Swift. I'm [@soffes](https://twitter.com/soffes). Say hi.
