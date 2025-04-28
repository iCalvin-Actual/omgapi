#  Following

Find your corner of the omg.lol community

Public feeds and Directories are great for finding new Addresses, but to encourage self curation and encourage community development, omg.lol provides the ability for one ``AddressName`` to 'Follow' another.

## Using the Following list

The 'Follow' feature was developed for StatusLog, but there's no real reason you couldn't highlight and and all public content from addresses followed by a given `AddressName`.

Simply treat the Following `Directory` as a reference for `AddressName`s to act on, fetch desired data for each Address and compile it into a 'Following' feed for the user.

## Public

A follow is a public action, so you can fetch the followers and followed Addresses for any `AddressName` with ``api``. These functions will return a ``Directory`` of `AddressName` instances.

```swift
let followers = client.following(from: "app")
let following = client.following(from: "app")
```

- ``api/followers(for:)``
- ``api/following(from:)``

## Updating Following list

`omgapi` allows for authenticated updates to the 'Following' list for any account, simply provide a valid ``APICredential`` and the `AddressName` to follow.

```swift
do {
  client.follow("app", from: myAddress, credential: myCredential)
  client.unfollow("calvin", from: myAddress, credential: myCredential)
} catch {
  switch error as? api.Error {
  // Will throw if the credential is invalid
  case .unauthenticated: needsLogin = true
  // Throw unhandled errors
  default: throw error
  }
}
```

- ``api/follow(_:from:credential:)``
- ``api/unfollow(_:from:credential:)``

## See Also

- ``APICredential``


