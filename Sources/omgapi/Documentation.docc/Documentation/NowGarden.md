# ``NowGarden``

The NowGarden collects the most recently updated ``Now`` entries across all ome.lol Addresses.

See ``Now`` to learn more about Now pages and how to work with the content from individual Addresses. 

## Topics

### Relevant APIs

Fetch the Now Garden with ``api`` and receive an array of ``Now/Reference`` instances sorted by most recently updated. 

```swift
do {
  let garden = try await client.nowGarden()
  let latest = garden.first
} catch { handleError(error) }
```

**Note** that only public pages will be returned in this feed.

- ``api/nowGarden()``

### Now Reference

Minimal model of a /now page

**Note** that each ``Now/Reference`` will not contain the actual content of the `Now` page, only data that allows you to reference the Now page with the context of an update date.

For instance, you can use the ``AddressName`` property of the reference to fetch an avatar to display 

```swift
do {
  let garden = try await client.nowGarden()
  let avatarURL = garden.first?.address.addressIconURL
} catch { handleError(error) }
```

## See Also

- ``Now``
