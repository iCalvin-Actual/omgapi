#  ``api/completeStatuslog()``


To get a more complete picture of recent activity `api.completeStatusLog()` will return the 100 most recent `Status` instances, with no other filter or check.

This is the best way to see who is most actively posting new Statuses, but has a smaller total number of statuses returned. 

```swift
let posts: [AddressName: Int] = client.completeStatuslog().reduce(into: [:]) {
  // Count up the number of recent posts from each Address
  var nxt = $0
  let cnt = $0[$1.address] ?? 0
  nxt[$1.address] = cnt + 1
  return nxt
}
```

## See Also

- ``Status``
- ``StatusLog``
- ``api/latestStatuslog()``

