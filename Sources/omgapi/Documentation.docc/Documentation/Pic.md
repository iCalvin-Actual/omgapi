# ``Pic``

`Pic` works slightly differently with the API than other Core Models, becuse the `Pic` model itself doesn't house the actual image data, just the identifiers and metadata associated with it.

Once you've gotten an image `Pic` reference, there's a second api call to fetch the actual image data.

```swift
let pic = try await client.addressPic("app", "icon")
let imageData = try await client.getPicData("app", id: pic.id, ext: pic.mime.split(by: "/").last)
```

Once you have the image data you are able to present the complete `Pic` in your client.

## Topics

### Properties

- ``id``
- ``description``

### Metadata

- ``address``
- ``created``
- ``size``
- ``mime``
- ``exif``

### Relevant APIs

- ``api/addressPic(_:id:)``
- ``api/getPicData(_:id:ext:)``

### Posting

Like other models, start with a ``Draft``.

Use a unique id to post a new `Pic`, or use an existing id to update an existing model.

Note that there are two methods to publish a `Pic.Draft`. `uploadPic(_:info:_:credentials:)` allows the client to provide the image data being uploaded, whereas `updatePicDetails(draft:_:id:credential)` only updates the image metadata contained in the `Draft`.

- ``Draft``
- ``api/uploadPic(_:info:_:credential:)``
- ``api/updatePicDetails(draft:_:id:credential:)``
