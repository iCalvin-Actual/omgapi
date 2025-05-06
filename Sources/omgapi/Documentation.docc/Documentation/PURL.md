# ``PURL``

## Topics

### Properties

- ``name``
- ``url``

### Metadata

- ``address``
- ``listed``
- ``counter``

### Relevant APIs

- ``api/purls(from:credential:)``
- ``api/purlContent(_:for:credential:)``
- ``api/purl(_:for:credential:)``
- ``api/deletePURL(_:for:credential:)``

### Posting

Send people all over the web.

Save a `PURL` by creating a new ``Draft`` instance and passing it to the ``api``. 

```swift
let draft = purlForm.createDraft()
async let purlResult = try client.savePURL(draft, to: someAddress, credential: someCredential)
```

Use the name of an existing `PURL` in the `Draft` to update an existing PURL, rather than create one.

**Note** the ``Draft/listed`` property of the `Draft`. When set to true, it will be available via ``api/purls(from:credential:)`` without an `APICredential`, and from any other app that uses `api.omg.lol`. When set to false it will only be visible when an appropriate ``APICredential`` is provided.

In either case the `PURL` can be hit directly by making an HTTP Request to the URL `{addressName}.url.lol/{purlName}` and the redirect will be processed regardless of whether or not it is publicly listed.

- ``Draft``
- ``api/savePURL(_:to:credential:)``

## See Also

- ``APICredential``
