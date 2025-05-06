# ``Status``

For more about working with sets of Status posts, see ``StatusLog``.

## Topics

### Metadata

Before we get to the good stuff, some basics.

- ``Status/id``
- ``Status/address``
- ``Status/created``

### Content

Markdown and Emoji can each communicate a lot.

Posts consist primarily of two strings.

``Status/emoji`` is intended to be displayed prominently, it's the 'vibe' of the message or the punchline to a joke.

``Status/content`` contains the primary content. Note that because this is markdown text, it may contains headings, image tags, maybe even raw html. Make sure to display the content however is most appropriate for your platform.

- ``Status/emoji``
- ``Status/content``

### Mastodon

Do a toot.

`Status` posts from a given address [can be configured to cross-post](https://home.omg.lol/info/mastodon) to a Mastodon instance to be shared with a wider audiance. 

If that happens, the `Status` is accompanied by an ``Status/externalURL`` that points to the URL for the post on the appropriate Mastodon instance. Once there a user may interact with the status or reply, assuming they also have a Mastodon account.

- ``Status/externalURL``

### Relevant APIs

Relevant `api` functionality.

- ``api/status(_:from:)``
- ``api/deleteStatus(_:from:credential:)``

### Posting

Share a moment, or a meme, with the world.

Simply create a new instance of ``Status/Draft`` and provide it to the ``api``.``api/saveStatus(_:to:credential:)`` function to post save a Status.

```swift
let draft = statusForm.createDraft()
let posted = client.saveStatus(draft, to: myAddress, credential: myCredential)
```

If the draft's ``Status/Draft/id`` property is not `nil`, the status will be applied as a update to an existing , rather than a new status.

- ``Status/Draft``
- ``api/saveStatus(_:to:credential:)``

## See Also

- <doc:Posting>
