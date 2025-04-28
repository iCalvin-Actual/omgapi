#  ``PURLs``

For more about Permanent URL Resources and how to act on them see the ``PURL`` page.

## Public

There is no public feed to expose PURL instances, to discover a `PURLs` set you must fetch provide an ``AddressName`` to retrieve publically exposed PURLs using the ``api/purls(from:credential:)`` function. You can provide a `nil` credential or leave it out and allow it to use the `nil` default.

```swift
let purls = client.purls(from: someAddress)
```

## Private

If an account owner chooses not to make an given `PURL` public it will not be returned in the ``api/purls(from:credential:)`` request without providing a non-nil and valid ``APICredential`` for that ``AddressName``.

```swift
let public = client.purls(from: someAddress)
let all = client.purls(from: someAddress, apiCredential: someAddressCredential)
if all.count > public.count {
  // address has some private PURLs
}
```

## Topics

### api

- ``api/purls(from:credential:)``

## See Also

- ``PURL``
- ``PasteBin``
- ``PicReel``

