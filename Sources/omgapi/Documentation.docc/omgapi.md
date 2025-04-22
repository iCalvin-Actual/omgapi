# ``omgapi``

A lightweight Swift wrapper for the [omg.lol API](https://api.omg.lol)

## What is omg.lol and why does it need a Swift API?

[omg.lol](https://home.omg.lol/referred-by/app) offers personal web tools like profiles, status updates, now pages, and more — all tied to your unique address. This Swift wrapper provides convenient, type-safe access to [api.omg.lol](https://api.omg.lol), making it easy to build native apps and tools around the service.

## Topics

### Essentials

All access to api.omg.lol happens in `api`

- ``api``

### Authenticating

Authentication is not needed unless you intend to access non-public content or act on behalf of a member's account.

- <doc:Authentication>

### Posting Content

`omgapi` supports posting content using ``Draft`` structs your app can construct and submit via ``api`` methods.

- <doc:Posting>

### Handling Errors

All functions of ``api`` can throw. View documentation to familiarize yourself with the failure cases of omgapi.

- <doc:APIError>

### Core Models

- ``AddressName``
- ``APICredential``
- ``ServiceInfo``
- ``Address``
- ``Account``
- ``TimeStamp``

### Profile

Display content from the Address' main landing page.

- ``Profile``
- ``PublicProfile``
- ``Theme``

### Now Pages

/now pages are one of the most popular features of omg.lol. The following models are used to represent `/now` pages in different contexts.

- ``NowGarden``
- ``Now``
- ``NowGardenEntry``
- ``NowPage``

### Statuses

- ``StatusLog``
- ``Status``
- ``PublicLog``

### Additional Address Features

- ``PURL``
- ``Paste``
- ``PasteBin``
- ``Pic``



