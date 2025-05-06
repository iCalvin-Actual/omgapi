# ``Paste``

## Topics

### Properties

- ``title``
- ``content``

### Metadata

- ``author``
- ``listed``
- ``modifiedOn``

### Relevant APIs

- ``api/paste(_:from:credential:)``
- ``api/deletePaste(_:for:credential:)``

### Posting

Say a lot with less

Save a `Paste` by creating a new ``Draft`` instance and passing it to the ``api``. 

```swift
let draft = pasteForm.createDraft()
async let pasteResult = try client.savePaste(draft, to: someAddress, credential: someCredential)
```

Use the name of an existing `Paste` in the `Draft` to update an existing Paste, rather than create one.

**Note** the ``Draft/listed`` property of the `Draft`. When set to true, it will be available via ``api/pasteBin(for:credential:)`` without an `APICredential`, and from any other app that uses `api.omg.lol`. When set to false it will only be visible when an appropriate ``APICredential`` is provided.

In either case the `Paste` can be hit directly by making an HTTP Request to the URL `{addressName}.paste.lol/{pasteTitle}` and the text content will be visible regardless of whether or not it is publicly listed.

- ``Draft``
- ``api/savePaste(_:to:credential:)``


## See Also

- ``APICredential``
