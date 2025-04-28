# ``AddressAvailability``

## Puny code

If the desired ``AddressName`` is aviailable _but_ doesn't cleanly encode into a URL encoding, such as some special language characters and emoji characters, the `AddressAvailability` model will indicate availability but also include a reference to an associated Puny-code.

[Punycode](https://www.google.com/url?sa=t&source=web&rct=j&opi=89978449&url=https://en.wikipedia.org/wiki/Punycode&ved=2ahUKEwib6rHd4vmMAxUOFVkFHQSbLeAQFnoECAoQAQ&usg=AOvVaw0DVjGD2NIc915bU0UkY1We) is an alternate string encoding strategry that allows complex characters to be represented by more manageable ascii characters.

For more data about how Punycodes are used within omg.lol please see their documentation.

If a Punycode is provided that code and the proper `AddressName` `String` value can be used by the API interchangably if the Address is registered. The puny-code is only required when dealing with email or certain URL destination encoding cases.

## Topics

### Properties

- ``available``

### Puny code

- ``punyCode``

### Metadata

- ``address``

### api

Pass the desired ``AddressName`` `String` to ``api/availability(_:)`` and inspect the resulting model.

```swift
let availability = try await client.availability(desiredAddress)
guard availability.available else { return /* Show 'unavailable' message */ }
```

- ``api/availability(_:)``
