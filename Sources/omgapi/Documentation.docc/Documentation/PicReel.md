# ``PicReel``

Abstractly a `PicReel` is a simple typealias that wraps an array of `Pic` instances. 

More specifically though there are two primary PicReels

## Topics

### Public Feed

A window into the community.

If a ``Pic`` is published as public it will appear in the general `PicReel` returned from ``api/picsFeed()``. The items are returned with the most recent `Pic` first.

```swift
let feed = api().picsFeed()
```

- ``api/picsFeed()``

### User Feed

A curated feed from an ``AddressName``.

To get public `Pic` instances published by a specific address you'll make a similar call to the ``api/pics(from:)`` function. 

```swift
let appPics = api().pics(from: "app")
```

- ``api/pics(from:)``

## See Also

- ``Pic``
