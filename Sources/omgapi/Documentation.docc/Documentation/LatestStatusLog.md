# ``api/latestStatuslog()``

The primary behavior of `statuslog` is to show no more than one `Status` per ``AddressName``.  the most recent `Status` instances shared on the statuslog, with no more than one `Status` per ``AddressName``. 

You'll see the `Status` posts shared by the 250 most recently active Addresses, consider this the best window into the `statuslog`.

```swift
guard let latest = client.latestStatusLog().first else { return }
print("\(latest.emoji) \(latest.content)")
```

## See Also

- ``Status``
- ``StatusLog``
- ``api/completeStatuslog()``
