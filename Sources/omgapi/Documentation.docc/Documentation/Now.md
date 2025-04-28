# ``Now``

The `Now` model contains the raw Markdown content of an ``AddressName``. For the HTML content of the` /now` page see ``Now/Page``. Some other `api` responses may return a ``Now/Reference`` to an Address' `/now` page, which doesn't contain the content but does contain metadata about the entry. For more see ``NowGarden``.

## Topics

### Content

- ``Now/content``

### Metadata

- ``Now/address``
- ``Now/updated``
- ``Now/listed``

### Other representations

More structures within `omeapi` that reference a particular `/now` page.

- ``Now/Page``
- ``Now/Reference``

### api

Relevant `api` functionality.

- ``api/nowWebpage(for:)``
- ``api/now(for:credential:)``

### Posting

Send new /now content right from the API.

Simply create a new instance of ``Now/Draft`` and provide it to the ``api`` via the ``api/saveNow(_:for:credential:)`` function.

```
let draft = nowForm.createDraft()
let posted = client.saveNow(draft, for: myAddress, credential: myCredential)
```

- ``Now/Draft``
- ``api/saveNow(_:for:credential:)``

## See Also

- <doc:Posting>
