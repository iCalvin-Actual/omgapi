# omgapi

A Swift package providing a client interface for the [omg.lol](https://omg.lol) API.

## Features

- Type-safe API client for omg.lol
- Codable-based request and response models
- Supports various omg.lol services:
  - Address lookup
  - Follower/following lists
  - Profile info
  - Statuslog
  - Pastebin and DNS (planned)

## Requirements

- Swift 5.9+
- iOS 15+ / macOS 12+ / watchOS 8+ / tvOS 15+

## Installation

### Swift Package Manager

Add the following to your `Package.swift`:

\`\`\`swift
dependencies: [
    .package(url: "https://github.com/calvinklugh/omgapi.git", from: "0.1.0")
]
///

## Usage

\`\`\`swift
import OMGAPI

let omg = OMGAPIClient()

Task {
    let profile = try await omg.fetchProfile(for: "calvin")
    print(profile.profile.bio)
}
\`\`\`

## Project Structure

- `OMGAPIClient.swift`: Core API client
- `Routes/`: Feature-specific endpoint groupings
- `Models/`: Codable structs for decoding responses
- `Mock/`: Testing mocks for endpoints
- `Errors.swift`: Error cases and decoding logic
- `OMGAPI+Extensions.swift`: Optional helpers

## Testing

\`\`\`sh
swift test
\`\`\`

## Documentation

Generate DocC with:

\`\`\`sh
xcodebuild docbuild \
  -scheme omgapi \
  -destination 'platform=iOS Simulator,name=iPhone 14'
\`\`\`

## License

MIT © Calvin Klugh
