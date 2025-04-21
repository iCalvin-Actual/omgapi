//
//  api.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Combine
import Foundation


// MARK: - Internal

/// The main client interface for interacting with omg.lol's API.
///
/// Provides async methods and Combine publishers to perform authenticated and unauthenticated
/// network operations such as fetching profiles, posting status updates, managing pastes, and more.
public actor api {
    static let decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
    
    let requestConstructor = APIRequestConstructor()
    
    let urlSession: URLSession = .shared
    
    public init() {
    }
    
    /// Performs an async API call and decodes the response into a typed result.
    ///
    /// - Parameters:
    ///   - request: The APIRequest object describing the endpoint and body.
    ///   - priorityDecoding: An optional closure to decode the response before falling back to normal decoding.
    /// - Returns: A decoded value of type `R`.
    /// - Throws: `APIError` if the request fails or decoding is unsuccessful.
    func apiResponse<B, R>(for request: APIRequest<B, R>, priorityDecoding: ((Data) -> R?)? = nil) async throws -> R {
        let urlRequest: URLRequest
        switch request.multipartBody {
        case true:
            urlRequest = APIRequestConstructor.multipartUrlRequest(from: request)
        case false:
            urlRequest = APIRequestConstructor.urlRequest(from: request)
        }
        
        let (data, _) = try await urlSession.data(for: urlRequest)
        do {
            if let result = priorityDecoding?(data) {
                return result
            } else {
                let apiResponse = try api.decoder.decode(APIResponse<R>.self, from: data)
                guard apiResponse.request.success else {
                    throw APIError.unhandled(apiResponse.request.statusCode, message: "Request \(request.path) in failed state")
                }
                
                guard let result = apiResponse.result else {
                    throw APIError.badResponseEncoding
                }
                return result
            }
        }
        catch {
            if let errorMessageResponse: APIResponse<BasicResponse> = try? api.decoder.decode(APIResponse.self, from: data) {
                throw APIError.create(from: errorMessageResponse)
            }
            throw APIError.badResponseEncoding
        }
    }
}

public extension api {
    // MARK: - Service
    
    /// Retrieves high-level information about the omg.lol service (member count, profile count, etc.).
    func serviceInfo() async throws -> ServiceInfo {
        let request = GETServiceInfoAPIRequest()
        let response = try await apiResponse(for: request)
        
        let info = ServiceInfo(summary: response.message ?? "", members: Int(response.members) ?? 0, addresses: Int(response.addresses) ?? 0, profiles: Int(response.profiles) ?? 0)
        
        return info
    }
    
    // MARK: - Account
    
    /// Constructs the authorization URL for beginning an OAuth flow.
    ///
    /// - Parameters:
    ///   - clientId: The OAuth client ID registered with omg.lol.
    ///   - redirect: The redirect URI that will receive the authorization code.
    /// - Returns: The full authorization URL.
    nonisolated
    func authURL(with clientId: String, redirect: String) -> URL? {
        URL(string: "https://home.omg.lol/oauth/authorize?client_id=\(clientId)&scope=everything&redirect_uri=\(redirect)&response_type=code")
    }
    
    /// Exchanges an OAuth authorization code for an API credential.
    ///
    /// - Parameters:
    ///   - clientId: The OAuth client ID.
    ///   - clientSecret: The OAuth client secret.
    ///   - redirect: The redirect URI that was used during auth.
    ///   - code: The authorization code received after login.
    /// - Returns: The API credential (bearer token) if successful.
    func oAuthExchange(with clientId: String, and clientSecret: String, redirect: String, code: String) async throws -> APICredential? {
        let oAuthRequest = OAuthRequest(with: clientId, and: clientSecret, redirect: redirect, accessCode: code)
        
        let response = try await self.apiResponse(for: oAuthRequest, priorityDecoding: { data in
            try? api.decoder.decode(OAuthResponse.self, from: data)
        })
        
        return response.accessToken
    }
    
    /// Retrieves a list of omg.lol addresses associated with the authenticated account.
    ///
    /// - Parameter credentials: The API credential used to authenticate.
    /// - Returns: An array of `AddressName`.
    func addresses(with credentials: APICredential) async throws -> [AddressName] {
        let request = GETAddresses(authorization: credentials)
        
        let response = try await self.apiResponse(for: request)
        
        return response.map({ $0.address })
    }
    
    /// Fetches the current account metadata for a specific email address.
    ///
    /// - Parameters:
    ///   - emailAddress: The email address to fetch.
    ///   - credentials: API credential with access to the account.
    /// - Returns: The parsed `Account` object.
    func account(for emailAddress: String, with credentials: APICredential) async throws -> Account {
        let infoRequest = GETAccountInfoAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        let info = try await self.apiResponse(for: infoRequest)
        
        return Account(
            info: info
        )
    }
    
    // MARK: - Addresses
    
    /// Fetches the full public omg.lol address directory.
    /// - Returns: An array of all visible omg.lol addresses.
    func addressDirectory() async throws -> [AddressName] {
        let request = GETAddressDirectoryRequest()
        let response = try await apiResponse(for: request)
        return response.directory
    }
    
    /// Checks whether a specific omg.lol address is available for registration.
    ///
    /// - Parameter address: The desired omg.lol address.
    /// - Returns: Availability info including punycode, if applicable.
    func availability(_ address: AddressName) async throws -> Address.Availability {
        let request = GETAddressAvailabilityRequest(for: address)
        let response = try await apiResponse(for: request)
        return Address.Availability(
            address: response.address,
            available: response.available,
            punyCode: response.punyCode
        )
    }
    
    /// Retrieves detailed metadata about an omg.lol address (verification, expiration, etc.).
    ///
    /// - Parameter address: The omg.lol address to query.
    /// - Returns: An `Address` object with expanded detail.
    func details(_ address: AddressName) async throws -> Address {
        let request = GETAddressInfoRequest(for: address)
        let response = try await apiResponse(for: request)
        return Address(
            name: response.address,
            registered: response.registration,
            expired: response.expiration.expired,
            verified: response.verification.verified
        )
    }
    
    /// Returns the expiration date of a specific address.
    ///
    /// - Parameters:
    ///   - address: The omg.lol address.
    ///   - credentials: API credential with permission to access expiration info.
    /// - Returns: A `Date` object representing expiration.
    func expirationDate(_ address: AddressName, credentials: APICredential) async throws -> Date {
        let request = GETAddressInfoRequest(for: address, authorization: credentials)
        let response = try await apiResponse(for: request)
        let date = Date(timeIntervalSince1970: Double(response.expiration.unixEpochTime ?? "") ?? 0)
        return date
    }
    
    // MARK: - Now
    
    /// Retrieves the public Now Garden, a directory of all listed Now pages.
    /// - Returns: An array of `NowGardenEntry` values.
    func nowGarden() async throws -> NowGarden {
        let request = GETNowGardenRequest()
        let response = try await apiResponse(for: request)
        return response.garden
            .map { NowGardenEntry(
                address: $0.address,
                url: $0.url,
                updated: $0.updated
            )}
    }
    
    /// Retrieves the raw HTML content of a Now page for a specific address.
    /// - Parameter address: The omg.lol address to retrieve.
    /// - Returns: A `NowPage` object containing HTML content.
    func nowWebpage(for address: AddressName) async throws -> NowPage {
        let request = GETAddressNowPageRequest(address)
        let response = try await apiResponse(for: request) { data in
            String(data: data, encoding: .utf8)
        }
        return NowPage(
            address: address,
            content: response
        )
    }
    
    /// Fetches the Now entry content for an address.
    /// - Parameters:
    ///   - address: The omg.lol address to query.
    ///   - credential: Optional API credential for authenticated access.
    /// - Returns: A `Now` model with metadata.
    func now(for address: AddressName, credential: APICredential? = nil) async throws -> Now {
        let request = GETAddressNowRequest(for: address, authorization: credential)
        let response = try await apiResponse(for: request)
        return Now(
            address: address,
            content: response.now.content,
            listed: response.now.listed.boolValue,
            updated: response.now.updatedAt
        )
    }
    
    /// Saves or updates a Now entry for the given address.
    /// - Parameters:
    ///   - address: The omg.lol address to update.
    ///   - content: The text content of the Now entry.
    ///   - credential: API credential with write access.
    /// - Returns: The updated `Now` entry.
    func saveNow(for address: AddressName, content: String, credential: APICredential) async throws -> Now? {
        let draft = Now.Draft(content: content, listed: true)
        let request = SETAddressNowRequest(for: address, draft: draft, authorization: credential)
        let _ = try await apiResponse(for: request)
        return try await now(for: address, credential: credential)
    }
    // MARK: - PasteBin
    
    /// Retrieves the full pastebin listing for a specific omg.lol address.
    /// - Parameters:
    ///   - address: The omg.lol address to query.
    ///   - credential: Optional API credential for private pastes.
    /// - Returns: A `PasteBin` array.
    func pasteBin(for address: AddressName, credential: APICredential?) async throws -> PasteBin {
        let request = GETAddressPasteBin(address, authorization: credential)
        let response = try await apiResponse(for: request)
        return response.pastebin.map { paste in
            Paste(
                title: paste.title,
                author: address,
                content: paste.content,
                modifiedOn: paste.updated,
                listed: paste.isPublic
            )
        }
    }
    
    /// Retrieves a single paste by title from an address's pastebin.
    /// - Parameters:
    ///   - title: The title of the paste.
    ///   - address: The omg.lol address to fetch from.
    ///   - credential: Optional API credential for private access.
    /// - Returns: A `Paste` if found, or `nil`.
    func paste(_ title: String, from address: AddressName, credential: APICredential?) async throws -> Paste? {
        let request = GETAddressPaste(title, from: address)
        do {
            let response = try await apiResponse(for: request)
            let paste = response.paste
            return Paste(
                title: paste.title,
                author: address,
                content: paste.content,
                modifiedOn: paste.updated,
                listed: paste.isPublic
            )
        } catch let error as APIError {
            switch error {
            case .notFound:
                return nil
            default:
                throw error
            }
        }
    }
    
    /// Deletes a paste from the given address.
    /// - Parameters:
    ///   - name: The paste name or title.
    ///   - address: The omg.lol address to remove from.
    ///   - credential: The API credential with write permissions.
    func deletePaste(_ name: String, for address: AddressName, credential: APICredential) async throws {
        let request = DELETEAddressPasteContent(paste: name, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    /// Saves a new or updated paste for an address.
    /// - Parameters:
    ///   - draft: The draft content and metadata.
    ///   - address: The omg.lol address to save to.
    ///   - credential: The API credential for write access.
    /// - Returns: The updated or newly saved `Paste`, if successful.
    func savePaste(_ draft: Paste.Draft, to address: AddressName, credential: APICredential) async throws -> Paste? {
        let request = SETAddressPaste(draft, to: address, authorization: credential)
        let response = try await apiResponse(for: request)
        return try await paste(response.title, from: address, credential: credential)
    }
    
    // MARK: - PURL
    
    /// Retrieves all PURLs associated with the given address.
    /// - Parameters:
    ///   - address: The omg.lol address to query.
    ///   - credential: Optional API credential for authentication.
    /// - Returns: An array of `PURL` objects.
    func purls(from address: AddressName, credential: APICredential?) async throws -> [PURL] {
        let request = GETAddressPURLs(address)
        let response = try await apiResponse(for: request)
        return response.purls.map({ purl in
            PURL(
                address: address,
                name: purl.name,
                url: purl.url,
                counter: purl.counter ?? 0,
                listed: purl.isPublic
            )
        })
    }
    
    /// Retrieves a specific PURL by name.
    /// - Parameters:
    ///   - name: The name of the PURL.
    ///   - address: The omg.lol address that owns the PURL.
    ///   - credential: Optional API credential for authentication.
    /// - Returns: The `PURL` object.
    func purl(_ name: String, for address: AddressName, credential: APICredential?) async throws -> PURL {
        let request = GETAddressPURL(
            name,
            address: address,
            authorization: credential
        )
        do {
            let response = try await apiResponse(for: request)
            return PURL(
                address: address,
                name: response.purl.name,
                url: response.purl.url,
                counter: response.purl.counter ?? 0,
                listed: true
            )
        } catch {
            throw error
        }
    }
    
    /// Retrieves the raw content associated with a PURL.
    /// - Parameters:
    ///   - name: The name of the PURL.
    ///   - address: The omg.lol address that owns the PURL.
    ///   - credential: Optional API credential.
    /// - Returns: A `String` containing the content, or `nil` if decoding fails.
    func purlContent(_ name: String, for address: AddressName, credential: APICredential?) async throws -> String? {
        let request = GETAddressPURLContent(purl: name, address: address, authorization: credential)
        do {
            let response = try await apiResponse(for: request, priorityDecoding: { String(data: $0, encoding: .utf8) })
            return response
        } catch {
            throw error
        }
    }
    
    /// Deletes a PURL from the specified address.
    /// - Parameters:
    ///   - name: The PURL name.
    ///   - address: The omg.lol address to delete from.
    ///   - credential: API credential with deletion rights.
    func deletePURL(_ name: String, for address: AddressName, credential: APICredential) async throws {
        let request = DELETEAddressPURLContent(purl: name, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    /// Creates or updates a PURL for the given address.
    /// - Parameters:
    ///   - draft: The draft data including name and URL.
    ///   - address: The omg.lol address to associate with the PURL.
    ///   - credential: API credential for write access.
    /// - Returns: The created or updated `PURL`, if successful.
    func savePURL(_ draft: PURL.Draft, to address: AddressName, credential: APICredential) async throws -> PURL? {
        let request = SETAddressPURL(draft, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
        return try await purl(draft.name, for: address, credential: credential)
    }
    
    // MARK: - Profile
    
    /// Retrieves the public profile HTML content for a specific address.
    /// - Parameter address: The omg.lol address to fetch.
    /// - Returns: A `PublicProfile` object containing rendered profile content.
    func publicProfile(_ address: AddressName) async throws -> PublicProfile {
        let request = GETPublicProfile(address)
        let response = try await apiResponse(for: request, priorityDecoding: { data in
            String(data: data, encoding: .utf8)
        })
        return PublicProfile(
            address: address,
            content: response
        )
    }
    
    /// Retrieves the profile content and metadata for a given address.
    /// - Parameters:
    ///   - address: The omg.lol address.
    ///   - credential: API credential with read access.
    /// - Returns: A `Profile` object.
    func profile(_ address: AddressName, with credential: APICredential) async throws -> Profile {
        let request = GETProfile(address, with: credential)
        let response = try await apiResponse(for: request)
        return Profile(
            address: address,
            content: response.content ?? "",
            theme: response.theme ?? "",
            head: response.head,
            css: response.css
        )
    }
    
    /// Saves or updates the profile content for an address.
    /// - Parameters:
    ///   - content: The new profile content (usually markdown).
    ///   - address: The omg.lol address to update.
    ///   - credential: API credential with write access.
    /// - Returns: The updated `Profile` object.
    func saveProfile(_ content: String, for address: AddressName, with credential: APICredential) async throws -> Profile {
        let request = SETProfile(.init(content: content, publish: true), from: address, with: credential)
        let _ = try await apiResponse(for: request)
        return try await profile(address, with: credential)
    }
    
    // MARK: - Status
    
    /// Retrieves the complete public statuslog feed from omg.lol.
    /// - Returns: A `PublicLog` containing all recent statuses.
    func completeStatusLog() async throws -> PublicLog {
        let request = GETCompleteStatusLog()
        let response = try await apiResponse(for: request)
        let statuses = response.statuses ?? []
        return PublicLog(statuses: statuses.map { status in
            Status(
                id: status.id,
                address: status.address,
                created: status.createdDate,
                content: status.content,
                emoji: status.emoji,
                externalURL: status.externalURL
            )
        })
    }
    
    /// Retrieves the latest entries in the public statuslog feed.
    /// - Returns: A `PublicLog` of recent statuses.
    func latestStatusLog() async throws -> PublicLog {
        let request = GETLatestStatusLogs()
        let response = try await apiResponse(for: request)
        let statuses = response.statuses ?? []
        return PublicLog(statuses: statuses.map { status in
            Status(
                id: status.id,
                address: status.address,
                created: status.createdDate,
                content: status.content,
                emoji: status.emoji,
                externalURL: status.externalURL
            )
        })
    }
    
    /// Combines the statuslog bio and posts for a single omg.lol address.
    /// - Parameter address: The omg.lol address.
    /// - Returns: A `StatusLog` containing metadata and statuses.
    func statusLog(from address: AddressName) async throws -> StatusLog {
        let logs = try await logs(for: address)
        let bio = try await bio(for: address)
        
        return StatusLog(
            address: address,
            bio: bio,
            statuses: logs
        )
    }
    
    /// Retrieves all statuses posted by a specific omg.lol address.
    /// - Parameter address: The omg.lol address.
    /// - Returns: An array of `Status` entries.
    func logs(for address: String) async throws -> [Status] {
        guard !address.isEmpty else {
            return []
        }
        let request = GETAddressStatuses(address)
        let response = try await apiResponse(for: request)
        let statuses = response.statuses ?? []
        return statuses.map { status in
            Status(
                id: status.id,
                address: status.address,
                created: status.createdDate,
                content: status.content,
                emoji: status.emoji,
                externalURL: status.externalURL
            )
        }
    }
    
    /// Retrieves the bio text for a statuslog, if set.
    /// - Parameter address: The omg.lol address.
    /// - Returns: A `StatusLog.Bio` object.
    func bio(for address: String) async throws -> StatusLog.Bio {
        let request = GETAddressStatusBio(address)
        let response = try await apiResponse(for: request, priorityDecoding: { data in
            if let response = try? api.decoder.decode(APIResponse<StatusLogBioResponseModel>.self, from: data) {
                if response.result?.message?.lowercased().hasPrefix("couldn’t find a statuslog bio for") ?? false {
                    return response.result
                }
            }
            return nil
        })
        return .init(content: response.bio ?? "")
    }
    
    /// Fetches the list of addresses following a given omg.lol address.
    /// - Parameter address: The omg.lol address.
    /// - Returns: An array of follower addresses.
    func followers(for address: AddressName) async throws -> [AddressName] {
        let request = GETAddressFollowers(address)
        let response = try await apiResponse(for: request)
        return response.followers
    }
    
    /// Fetches the list of addresses followed by a given omg.lol address.
    /// - Parameter address: The omg.lol address.
    /// - Returns: An array of followed addresses.
    func following(from address: AddressName) async throws -> [AddressName] {
        let request = GETAddressFollowing(address)
        let response = try await apiResponse(for: request)
        return response.following
    }
    
    /// Submits a request for one omg.lol address to follow another.
    /// - Parameters:
    ///   - target: The address to follow.
    ///   - address: The address initiating the follow.
    ///   - credential: API credential with permission.
    func follow(_ target: AddressName, from address: AddressName, credential: APICredential) async throws {
        let request = SETAddressFollowing(address, target, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    /// Unfollows a target address on behalf of another.
    /// - Parameters:
    ///   - target: The address to unfollow.
    ///   - address: The address initiating the unfollow.
    ///   - credential: API credential with permission.
    func unfollow(_ target: AddressName, from address: AddressName, credential: APICredential) async throws {
        let request = DELETEAddressFollowing(address, target, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    /// Fetches a specific status entry by ID.
    /// - Parameters:
    ///   - status: The status ID.
    ///   - address: The omg.lol address that owns the status.
    /// - Returns: A `Status` object.
    func status(_ status: String, from address: AddressName) async throws -> Status {
        let request = GETAddressStatus(status, from: address)
        let response = try await apiResponse(for: request)
        return Status(
            id: response.status.id,
            address: response.status.address,
            created: response.status.createdDate,
            content: response.status.content,
            emoji: response.status.emoji,
            externalURL: response.status.externalURL
        )
    }
    
    /// Deletes a specific status and returns the removed content.
    /// - Parameters:
    ///   - status: A draft containing the ID of the status to delete.
    ///   - address: The omg.lol address that owns the status.
    ///   - credential: API credential with permission to delete.
    /// - Returns: The deleted `Status` for reference.
    func deleteStatus(_ status: Status.Draft, from address: AddressName, credential: APICredential) async throws -> Status? {
        guard let id = status.id else {
            return nil
        }
        let request = DELETEAddressStatus(status, from: address, authorization: credential)
        let backup = try await self.status(id, from: address)
        let _ = try await apiResponse(for: request)
        return backup
    }
    
    /// Creates or updates a status entry.
    /// - Parameters:
    ///   - draft: The status content and optional metadata.
    ///   - address: The omg.lol address to post to.
    ///   - credential: API credential for write access.
    /// - Returns: The newly created or updated `Status`.
    func saveStatus(_ draft: Status.Draft, to address: AddressName, credential: APICredential) async throws -> Status {
        let request = SETAddressStatus(draft, with: address, authorization: credential)
        let response = try await apiResponse(for: request)
        return try await status(response.id, from: address)
    }
    
    /// Retrieves the full list of available omg.lol themes.
    /// - Returns: An array of `Theme` objects.
    func themes() async throws -> [Theme] {
        let request = GETThemes()
        let response = try await apiResponse(for: request)
        let themes = response.themes.values.map({ model in
            Theme(
                id: model.id,
                name: model.name,
                created: model.created,
                updated: model.updated,
                author: model.author,
                authorUrl: model.authorUrl,
                version: model.version,
                license: model.license,
                description: model.description,
                previewCss: model.previewCss
            )
        })
        return themes
    }
    
    /// Retrieves the global public omg.lol Pics feed.
    /// - Returns: An array of `Pic` objects.
    func getPicsFeed() async throws -> [Pic] {
        let request = GETPicsFeed()
        let response = try await apiResponse(for: request)
        let pics = response.pics.map({ model in
            Pic(
                id: model.id,
                address: model.address,
                created: .init(timeIntervalSince1970: Double(model.created) ?? 0),
                size: Double(model.size) ?? 0,
                mime: model.mime,
                exif: model.exif,
                description: model.description
            )
        })
        return pics
    }
    
    /// Retrieves all Pics uploaded by a specific address.
    /// - Parameter address: The omg.lol address.
    /// - Returns: An array of `Pic` objects.
    func getAddressPics(_ address: AddressName) async throws -> [Pic] {
        let request = GETAddressPics(address)
        let response = try await apiResponse(for: request)
        let pics = response.pics.map({ model in
            Pic(
                id: model.id,
                address: model.address,
                created: .init(timeIntervalSince1970: Double(model.created) ?? 0),
                size: Double(model.size) ?? 0,
                mime: model.mime,
                exif: model.exif,
                description: model.description
            )
        })
        return pics
    }
    
    /// Retrieves a specific Pic by ID from an address.
    /// - Parameters:
    ///   - address: The omg.lol address.
    ///   - id: The Pic identifier.
    /// - Returns: A `Pic` object.
    func getAddressPic(_ address: AddressName, id: String) async throws -> Pic {
        let request = GETAddressPic(address, target: id)
        let response = try await apiResponse(for: request)
        let pic = Pic(
            id: response.pic.id,
            address: response.pic.address,
            created: .init(timeIntervalSince1970: Double(response.pic.created) ?? 0),
            size: Double(response.pic.size) ?? 0,
            mime: response.pic.mime,
            exif: response.pic.exif,
            description: response.pic.description
        )
        return pic
    }
    
    /// Uploads a new Pic and applies metadata.
    /// - Parameters:
    ///   - data: Raw image data.
    ///   - info: Metadata including description and tags.
    ///   - address: The omg.lol address to upload to.
    ///   - credential: API credential with permission to upload.
    /// - Returns: A fully populated `Pic` object.
    func uploadPic(_ data: Data, info: Pic.Draft, _ address: AddressName, credential: APICredential) async throws -> Pic {
        let request = POSTAddressPic(image: data, address, credential: credential)
        let response = try await apiResponse(for: request)
        let id = response.pic.id
        return try await updatePicDetails(draft: info, address, id: id, credential: credential)
    }
    
    /// Updates metadata for an existing Pic.
    /// - Parameters:
    ///   - draft: New metadata values.
    ///   - address: The omg.lol address that owns the Pic.
    ///   - id: The Pic identifier.
    ///   - credential: API credential for edit permissions.
    /// - Returns: The updated `Pic` object.
    func updatePicDetails(draft: Pic.Draft, _ address: AddressName, id: String, credential: APICredential) async throws -> Pic {
        let request = PATCHAddressPic(draft: draft, address, target: id, credential: credential)
        let _ = try await apiResponse(for: request)
        return try await getAddressPic(address, id: id)
    }
    
    /// Downloads raw image data for a Pic.
    /// - Parameters:
    ///   - address: The omg.lol address.
    ///   - id: The Pic identifier.
    ///   - ext: The file extension (e.g., jpg, png).
    /// - Returns: The image data.
    func getPicData(_ address: AddressName, id: String, ext: String) async throws -> Data {
        let request = GETPicData(address, target: id, ext: ext)
        let response = try await apiResponse(for: request)
        return response
    }
}
