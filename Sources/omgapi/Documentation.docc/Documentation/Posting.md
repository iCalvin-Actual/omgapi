# Posting

Creating and editing content with omgapi

## Working with Drafts

The omgapi library provides a set of `Draft` types that allow you to create or update content across omg.lol services like Now pages, Pastes, Profiles, Statuses, PURLs, and more.

Each `Draft` struct mirrors a supported resource on omg.lol and contains the fields required to create or update that content. To update existing content, simply pass a `Draft` with the same `id` or `name` as the original post — most API endpoints treat this as an edit operation.

### Example: Updating a Status

````swift
let draft = Status.Draft(
    id: "abcd1234",
    content: "Updated content with new emoji!",
    emoji: "✨"
)

let updatedStatus = try await api.saveStatus(draft, to: "youraddress", credential: credential)
````

### Example: Creating a new Paste

````swift
let draft = Paste.Draft(
    title: "New Paste Title",
    content: "Here's a code snippet or some notes.",
    listed: true
)

let paste = try await api.savePaste(draft, to: "youraddress", credential: credential)
````

### Example: Editing a Profile

````swift
let draft = Profile.Draft(
    content: "# Welcome\nHere's some updated Markdown.",
    publish: true
)

let profile = try await api.saveProfile(draft.content, for: "youraddress", with: credential)
````

## Draft Types

Each content type has its own `Draft` struct:
- ``Status`` — post or edit statuslog entries
- ``Now`` — manage Now page content
- ``Paste`` — create or update Pastebin items
- ``Profile`` — edit the profile page content
- ``PURL`` — configure PURL redirects
- ``StatusLog`` — Bio struct supports Draft
- ``Pic`` — attach metadata to a Pic image

All of these are `Sendable` so they can be passed directly to the corresponding ``api`` save/update methods.

## Topics

- ``api``
