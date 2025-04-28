#  ``APICredential``

Typically an API Key or OAuth bearer token

A simple typealias around `String` lets the API be more clear when requesting a credential string in a parameter.

If a request doesn't have permission to perform the desired action with the given `Credential` value the API will throw ``api/Error/unauthenticated`` to the callsite.

## Authenticating your account

If the need is not for general user login, you can get an API Key for your omg.lol ``Account`` on [the website](https://home.omg.lol).

After logging in, go to the Account page and find the API Key section at the very bottom of the page. That key will work as an ``APICredential`` for any Address registered by your Account, so keep it safe.

```swift
let profile = try? await api.profile("app", with: SecretStore.apiKey)
```

## Authenticating another `omg.lol` Account

[`api.omg.lol`](https://api.omg.lol/#token-get-oauth-exchange-an-authorization-code-for-an-access-token) uses a standard OAuth flow to access an account. Users do not need to provide the app or omgapi any credentials or APIKeys, they simply will log in via the website and after choosing to enable API access for the app client.

Everything is built around a simple `String` typealias ``APICredential``. After performing a simple OAuth handshake the API provides the client with an `APICredential` and the client should pass that credential for any authenticated requests going forward.

To support optional authentication complete the following steps.

### Step 0: Register your client

Before you'll be able to authenticate on behalf of an omg.lol account, you'll first need to register your client application with omg.lol.

This is entirely outside of the scope of this API, I (Calvin) and the API itself have no ability to help you out here. Start with emailing [help@omg.lol](mailto:help@omg.lol) with an introduction to your project, make sure to include the following info.

1. The name of your application
2. A support contact, including name, email, and url
3. A redirect URL for the OAuth flow to call upon completion

[See omg.lol API Help for more](https://home.omg.lol/info/api)

Once your application is regestered you'll receive a clientID and clientSecret. Save these values somewhere secure.

### Step 1: Present OAuth Flow

Once you have your `clientID` you'll be able to call `api.authURL(with:redirect:)` to construct the root login URL. You'll want to give the user an oppertunity to login to their omg.lol account by presenting a webpage with that URL, making sure to provide a redirect URL that will be called upon successful authentication.

```swift
let clientID: String = Secrets.omgClientID
let loginURL: URL? = api.authURL(with: clientID, redirect: "app://")
```

If you're building on Apple platforms you may have access to the `AuthenticationServices` framework, which provides convenience functions to perform an OAuth flow in-app. Otherwise you'll need to manually listen for the OAuth callback to receive the OAuth authorization code.

```swift
import AuthenticationServices

let webSession = ASWebAuthenticationSession(
  url: loginURL,
  callbackURLScheme: "app://"
) { (callbackUrl, error) in
  guard let callbackUrl = callbackUrl else {
    return
  }
  let components = URLComponents(url: callbackUrl, resolvingAgainstBaseURL: true)

  guard let authCode = components?.queryItems?.filter ({ $0.name == "code" }).first?.value else {
    return
  }
}
webSession?.presentationContextProvider = self
webSession?.start()
```

### Exchange token for APICredential

Once you've received an authentication code from the callback URL you'll need to exchange that code for a useful ``APICredential``.

```swift
let clientID = Secrets.omgClientID
let clientSecret = Secrets.omgClientSecret
let credential = api.oAuthExchange(with: clientID, and: clientSecret, redirect: "app://", code: authCode)
```

Once you have that ``APICredential`` you're all set, you can store that value for the duration of the login session and use it to perform authenticated requests.

```swift
let profile = try? await api.profile("app", with: apiCredential)
```

## Topics

### api

- ``api/authURL(with:redirect:)``
- ``api/oAuthExchange(with:and:redirect:code:)``

## See Also

- ``Account``
- ``Profile``
- <doc:Posting>

