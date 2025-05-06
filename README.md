# omgapi

A lightweight Swift wrapper for the [omg.lol API](https://api.omg.lol)

## Overview

omgapi is a Swift package that provides type-safe access to the omg.lol service, allowing apps to authenticate, read, and write omg.lol data like profiles, status updates, now pages, pastes, and more.

It supports both read-only access to public data and authenticated access for writing or managing private member content.

## Features

- ✅ Fetch and update member profiles
- ✅ Create and manage Now pages and pastes
- ✅ Post to and delete from the omg.lol statuslog
- ✅ Handle PURLs, bios, followers, and themes
- ✅ Lightweight `Draft` structs for posting content
- ✅ Errors wrapped in a consistent `APIError` enum

## Usage

Initialize an instance of `api` to access all supported endpoints:

```swift
import omgapi

let api = omgapi.api()
```

### Example: Get info about an address

```swift
let addressInfo = try await api.details("app")
```

### Example: Update a status

```swift
let draft = Status.Draft(content: "New post!", emoji: "🌀")
let updated = try await api.saveStatus(draft, to: "youraddress", credential: yourCredential)
```

## Authentication

Most endpoints support unauthenticated access to public data. Supports OAuth flow to write content or access private info.


```swift
var code: String? { didSet { exchange() } }

@Published
var credential: APICredential?

/// Presents a login prompt 
func promptForLogin() {
  let loginURL = api.authURL(with: Secrets.clientId, redirect)
  let authSession = ASWebAuthenticationSession(
    url: loginURL,
    callbackURLScheme: callback,
    completion: { self.code = handleRedirect($0) }
  )
  authSession.start()
}

func exchange() {
  guard let code else { return }
  credential = 
}

func handleRedirect(_ redirect: URL) -> String? {
  // decoding logic to pull code
  return code
}
 
```

## Installation

Use Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/your-username/omgapi", branch: "main")
]
```

## Documentation

Full Swift API documentation: [app.url.lol/swiftAPI](https://app.url.lol/swiftAPI)

Reference for the omg.lol web API: [api.omg.lol](https://api.omg.lol)

To build locally with SwiftPM:

```sh
swift package generate-documentation
```

Or build within Xcode using 'Build Documentation'

## License

MIT
