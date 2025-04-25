# ``omgapi``

Swift wrapper to api.omg.lol

## What is omg.lol

[omg.lol](https://home.omg.lol/referred-by/app) offers personal web tools like profiles, status updates, now pages, and more — all tied to your unique address. Even if you don't have an address you can view public content from the omg.lol community from a web browser or any client app that uses the [omg.lol api](https://api.omg.lol).

## What is omgapi

This [Swift package](https://github.com/iCalvin-Actual/omgapi) allows convenient, type-safe access to omg.lol, making it easy to build native apps and tools around the service.

See omg.lol for more about the service. Please note that this is an unofficial third party SDK It could not have been possible without the documentation at api.omg.lol and Email/Discord support from the community, this API is officially not related to the omg.lol team and exists as a token of appreciation.

## Where does this data come from

Everything on `omg.lol` is owned/published by a paid Address on the service and hosted by omg.lol. All published resources can either be made public or private by the owner of that Address. omgapi allows access to public data, but also allows the client to request/provide an API Credential from omg.lol to view private data or post/edit content on the service. omgapi takes no responsibility for the content hosted by the omg.lol service.

## Who makes this

Hi! I'm [Calvin](https://calvin.status.lol). I made [an app client to omg.lol](https://app.omg.lol) and overoptimized this API Package, figured I might as well make it public. 

## Getting started

To start working with omgapi, all you need to do is create an instance of the ``api``. 
```
let client = api()
```
This API is stateless, and takes no parameters. You don't need to authenticate, just start making requests.
```
async let info = try client.serviceInfo()
```

All functions in the API are async and will throw an ``api/Error`` if it runs into an issue. Make sure to properly catch those expected cases as you go.
```
do {
  async let profile = try client.publicProfile(searchAddress)
  searchAddressExists = true
}
catch {
  switch error as? api.Error {

  // `api.Error` includ
es an .unexpected case so this should never happen
  case nil: throw error

  // Expected error case handled by the UI
  case .notFound: searchAddressExists = false
  
  // Handle defined errors cases with logs or alerts
  default:  displayError(error)
  }
}
```

## Topics

### Essentials

``api`` is the gateway to everything, start here to learn more about `omg.lol` and `omgapi`.

- ``api``
- ``api/Error``
- ``ServiceInfo``

### String Extensions

Many ``api`` functions accept simple String values which are represented using typealiases for clarity.

- ``APICredential``
- ``AddressName``
- ``Swift/String/addressDisplayString``

### Public Feeds

The `omg.lol` community it built on top of simple lists.

- ``AddressDirectory``
- ``NowGarden``

### Address Data

View public data for any AddressName.

- ``AddressInfo``
- ``PublicProfile``
- ``PicReel``
- ``PURLs``
- ``PasteBin``

### Acting on a user's behalf

Edit and post content. Access private data.

- <doc:Authentication>
- <doc:Posting>

### StatusLog

Statuses allow omg.lol addresses to share small posts attached to an emoji.

- <doc:Following>
- ``StatusLog``
- ``AddressBio``
- ``Status``

### Now Pages

Most relevant right now.

- ``Now``
- ``Now/Page``
- ``Now/Reference``

### Additional Address Content

Swift models to represent content about or posted by any Address on omg.lol.

- ``Theme``
- ``Pic``
- ``PURL``
- ``Paste``
