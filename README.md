# api.lol

A Swift Package that provides access to the [omg.lol API](https://api.omg.lol)

____

## Current Status

### Features

<details>
<summary>
Supported + Validated
</summary>

- Address Directory
- Address Profile
- Status Log
    - Global
    - Recent
    - Address
- Now
    - Garden
    - Address Now
- PURL from address
- Pastebin from address

</details>

<details>
<summary>
Needs Validation
</summary>

- Service Info
- Authentication
- Posting
    - Status
    - Profile
    - Now
    - Paste
    - PURL

</detail>

<details>
<summary>
Future
</summary>

- Weblog

</details>


### Authentication

Supports authentication given an API Key, but that will return an error if you try to fetch any information about a Public account not authorized by the API Key. I need to clean that up so we don't accept credentials anywhere they wouldn't be necessary.

Also, the expected authentication method for the API is OAUTH, but obviously that wasn't the initial development flow. Next big update for this package will be support for kicking off the OAUTH flow, and then adding support for the apparently undocumented ability to fetch addresses given only an API Key, rather than an explicit email address. 

### Posting

In theory posting requests work, but I have yet to actually hook up and run through them outside of tests, and I know I ran into plenty of issues with fetching, I'm sure posting will present new challenges.



