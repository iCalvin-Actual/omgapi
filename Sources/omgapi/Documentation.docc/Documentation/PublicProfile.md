#  ``Profile``

The core function of omg.lol is that if you register an address "MyAddress", you now have a webpage publically available at `https://MyAddress.omg.lol`.

This model contains the data that makes up that rendered page, from the theme, to custom HTML values, and especially the core markdown content string.

This model is only available for Authenticated addresses

## Topics

### Properties

- ``content``

### Metadata

- ``address``
- ``theme``
- ``head``
- ``css``

### Other Representations

This structure exposes that core functionality to the API. Rather than navigating to that web page one can fetch the HTML content via the ``api`` and present or inspect it however is most appropriate.

- ``Profile/Page``

### Relevant APIs

Use the ``api`` class to fetch a profile for a given ``AddressName`` 

```swift
let profile = try await client.publicProfile(targetAddress)
let html = profile.content
```

- ``api/profile(_:with:)``
- ``api/publicProfile(_:)``

### Posting

Get cozy with markdown

Update an address' profile page by creating a new ``Draft`` instance and passing it to the ``api``. 

**Note** the ``Draft/publish`` property of the `Draft`. When set to true, it will auto-publish the profile page and you'll see the results on `https://{address}.omg.lol` or from ``api/publicProfile(_:)``. When set to false it will not publish, but you will receive the new value from ``api/profile(_:with:)`` in the future.

- ``Draft``
- ``api/saveProfile(_:for:with:)``

## See Also

- ``APICredential``
- ``api/avatar(_:)``
- ``api/bio(for:)``
