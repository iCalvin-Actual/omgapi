# ``api/Error``

All requests from the ``api`` can throw. This may indicate a simple usage error like sending an invalid resource name or requesting a public profile from a private address. It also may indicate an internal issue encoding data to/from the APIRequst.

Best practice is to always catch errors thrown from the API and check the Error case to determine how best to fall back or retry.

```swift
do {
  async let profile = try client.publicProfile(searchAddress)
  searchAddressExists = true
}
catch {
  switch error as? api.Error {

  // `api.Error` includes an .unexpected case so this should never happen
  case nil: throw error

  // Expected error case handled by the UI
  case .notFound: searchAddressExists = false
  
  // Handle defined errors cases with logs or alerts
  default:  displayError(error)
  }
}
```

## Topics

### Permissions

Requested resource is private or requires authentication.

- ``notFound``
- ``unauthenticated``

### Encoding

Not expected in general use, models are encoded/decoded internally, but provided for completeness.

- ``badBody``
- ``badResponse``

### Other errors 

Unhandled error cases that may be thrown from the API.

- ``unhandled(_:message:)``
- ``inconceivable``
