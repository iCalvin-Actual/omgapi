#  ``Directory``

Reading public address data from omg.lol address directory.

In the API `Directory` is defined as a simple type alias to clean up references to arrays of ``AddressName`` values.

More broadly, the Directory is the public reference of all listed Addresses on the omg.lol service. If a user doesn't choose to make their Address unlisted, it will appear by default in the Directory.

These resources will tell you more about working with the Address Directory and getting public data about an address.

Recent public user activity is also highlighted in the ``NowGarden``, ``StatusLog``, and ``PicReel``

## Topics

### Relevant APIs

Simply request the array of names in the Directory.

Use any of these addresses to fetch data published by that ``AddressName``.

```swift
let directory = api().directory()
```

- ``api/directory()``

