#  ``AddressName``

Simple typealias around `String` to let us be more clear about when we're expecting an Address' name value as a parameter and allow for convenience methods.

For instance the following helper method to prepare Address for display in the UI. If self begins with the character `"@"` it will return self, otherwise it will prepend `"@"` to the beginning of self.

```swift
print("calvin".addressDisplayString)
// prints "@calvin"
```

