---
tags:
- development
- swift
---

# String Homogeneousness Algorithms

Today, I [tweeted](https://twitter.com/soffes/status/614877572388630528) the following code while I was working on [Whiskey](http://usewhiskey.com):

```swift
import Foundation

extension String {
  var isHomogeneous: Bool {
    var homogeneous = true
    var character: NSString?
    enumerateSubstringsInRange(Range(start: startIndex, end: endIndex), options: [.ByComposedCharacterSequences]) { substring, _, _, stop in
      if let character = character {
        if character != substring {
          homogeneous = false
          stop = true
        }
      } else {
        character = substring
      }
    }

    return homogeneous
  }
}
```

It just checks to see if all of the characters in a string are all the same. Here's the test:

```swift
import XCTest

class StringExtensionTests: XCTestCase {
  func testHomogeneous() {
    XCTAssertTrue("~~~".isHomogeneous)
    XCTAssertTrue("aaa".isHomogeneous)
    XCTAssertTrue("😎😎".isHomogeneous)
    XCTAssertTrue("😎".isHomogeneous)
    XCTAssertTrue("".isHomogeneous)

    XCTAssertFalse("as".isHomogeneous)
    XCTAssertFalse(" ~~~".isHomogeneous)
}
```

It seemed like there would be a better solution. [Terry Lewis](https://twitter.com/TLewisII) and several others suggessted putting the characters in a set and counting the set. Here's Terry's solution ([Kelly Sutton](https://twitter.com/kellysutton) [suggested](https://twitter.com/KellySutton/status/614882186542452736) making it more consice):

```swift
extension String {
    var isHomogeneous: Bool {
        return Set(characters).count <= 1
    }
}
```

At first, I was all about this. No Foundation dependency is great. It's also way less code. [Ayaka Nonaka](https://twitter.com/ayanonagon) [suggested](https://twitter.com/ayanonagon/status/614880711820992512) comparing their performance. I benchmarked them and they were basically equal. This makes sense. Either way, it has to iterate over all of the characters and then compare them.

The one benefit to my approach is bailing out early. Let's think about the following test:

```swift
XCTAssertFalse("👍😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎😎 ".isHomogeneous)
```

For 1,000 iterations, my first approach took 0.013 seconds. The set approach took 2.932 second! Crazy. Totally makes sense though. It doesn't bother getting the rest of the characters if there is a mismatch anywhere.

Next, the great [Nate Cook](https://twitter.com/nnnnnnnn) [suggested](https://twitter.com/nnnnnnnn/status/614893914474967040) doing it all in Swift:

```swift
extension String {
    var isHomogeneous: Bool {
        if let firstChar = characters.first {
            for char in dropFirst(characters) where char != firstChar {
                return false
            }
        }
        return true
    }
}
```

Fantastic.
