# ``APIError``

All requests from the ``api`` can throw. This may indicate a simple usage error like sending an invalid resource name or requesting a public profile from a private address. It also may indicate an internal issue encoding data to/from the APIRequst.

Best practice is to always catch errors thrown from the API and check the Error case to determine how best to fall back or retry.

```swift
do {
   let profile = try await api.publicProfile("PrivateAddress")
} catch {
   switch error as? APIError {
   case .notFound:
     // Handle private profile
   default:
     throw error
   }
}
```

## Topics

### Permissions

- ``notFound``
- ``unauthenticated``

### Encoding

- ``badBody``
- ``badResponseEncoding``

### Other errors 

- ``unhandled(_:message:)``
- ``inconceivable``
