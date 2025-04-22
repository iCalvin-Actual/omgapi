# ``api``


## Topics

### Creating a new instance

`api` takes no parameters, is state-less, and can be constructed very simply.

- ``init()``

### omg.lol info

- ``serviceInfo()``
- ``availability(_:)``

### Authentication

Learn more about usage in <doc:Authentication>

- ``authURL(with:redirect:)``
- ``oAuthExchange(with:and:redirect:code:)``

### Working with Accounts

Credential required

- ``account(for:with:)``
- ``addresses(with:)``

### Private info about an Address

Credential required

- ``expirationDate(_:credentials:)``
- ``profile(_:with:)``

### Public directories

- ``addressDirectory()``
- ``nowGarden()``
- ``completeStatusLog()``
- ``latestStatusLog()``
- ``themes()``
- ``getPicsFeed()``

### Public info about an Address

- ``details(_:)``
- ``bio(for:)``
- ``following(from:)``
- ``followers(for:)``
- ``publicProfile(_:)``
- ``nowWebpage(for:)``
- ``now(for:credential:)``
- ``pasteBin(for:credential:)``
- ``purls(from:credential:)``
- ``statusLog(from:)``
- ``logs(for:)``
- ``getAddressPics(_:)``

### Get a specific resource

- ``paste(_:from:credential:)``
- ``purl(_:for:credential:)``
- ``purlContent(_:for:credential:)``
- ``status(_:from:)``
- ``getAddressPic(_:id:)``
- ``getPicData(_:id:ext:)``

### Managing an Address

Credential required

- ``saveProfile(_:for:with:)``
- ``saveNow(for:content:credential:)``
- ``follow(_:from:credential:)``
- ``unfollow(_:from:credential:)``

### Publishing content

Credential required. For more details see <doc:Posting>

- ``savePURL(_:to:credential:)``
- ``savePaste(_:to:credential:)``
- ``saveStatus(_:to:credential:)``
- ``uploadPic(_:info:_:credential:)``
- ``updatePicDetails(draft:_:id:credential:)``

### Deleting address resources

Credential required

- ``deletePURL(_:for:credential:)``
- ``deletePaste(_:for:credential:)``
- ``deleteStatus(_:from:credential:)``

