#  ``PasteBin``

For more about `Paste` instances and how to act on them see the ``Paste`` page.

## Public

There is no public feed to expose PURL instances, to discover a `PURLs` set you must fetch provide an ``AddressName`` to retrieve publically exposed PURLs using the ``api/pasteBin(for:credential:)`` function. You can provide a `nil` credential or leave it out and allow it to use the `nil` default.

```swift
let bin = client.pasteBin(for: someAddress)
```

## Private

If an account owner chooses not to make an given `Paste` public it will not be returned in the ``api/pasteBin(for:credential:)`` request without providing a non-nil and valid ``APICredential`` for that ``AddressName``.

```swift
let public = client.pasteBin(for: someAddress)
let all = client.pasteBin(for: someAddress, apiCredential: someAddressCredential)
if all.count > public.count {
  // address has some private Pastes
}
```

## Topics

### Relevant APIs

- ``api/pasteBin(for:credential:)``

## See Also

- ``Paste``
- ``PURLs``
- ``PicReel``

