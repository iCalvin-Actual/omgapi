# ``Bio``

A bit of personality to display alongside some given `Address` content.

## Topics

### Properties

- ``content``

### Relevant APIs

```
let bio = client.bio(for: someAddress)
let markdown = bio.content
```

To fetch a bio, simply pass an ``AddressName`` to the proper ``api`` request.

- ``api/bio(for:)``

### Posting

```
let draft: Bio.Draft = .init(content: markdownContent)
try await client.saveBio(draft, for: someAddress, credential: someCredential)
```

If you have the proper ``APICredential`` you can provide a new markdown biography for a desired `AddressName` by creating a ``Draft`` model.

- ``Draft``
- ``api/saveBio(_:for:credential:)``

## See Also

- <doc:Posting>



