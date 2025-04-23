//
//  Requests.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

// MARK: - Service

/// Retrieves serviceinfo information.
class GETServiceInfoAPIRequest: APIRequest<None, ServiceInfoResponse> {
    /// - Parameters:
    init() {
        super.init(path: CommonPath.service)
    }
}

// MARK: - Account

/// Initiates an OAuth authorization exchange.
class OAuthRequest: APIRequest<None, OAuthResponse> {
    /// - Parameters:
    ///   - clientId: Description for `clientId`.
    ///   - clientSecret: Description for `clientSecret`.
    ///   - redirect: Description for `redirect`.
    ///   - accessCode: Description for `accessCode`.
    init(with clientId: String, and clientSecret: String, redirect: String, accessCode: String) {
        super.init(
            path: AccountPath.oauth(clientId, clientSecret, redirect, accessCode)
        )
    }
}

/// Retrieves accountinfo information.
class GETAccountInfoAPIRequest: APIRequest<None, AccountInfo> {
    /// - Parameters:
    ///   - emailAddress: Description for `emailAddress`.
    ///   - authorization: Description for `authorization`.
    init(for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.info(emailAddress)
        )
    }
}

/// Fetches data for `GETAccountNameAPIRequest`.
class GETAccountNameAPIRequest: APIRequest<None, AccountOwner> {
    /// - Parameters:
    ///   - emailAddress: Description for `emailAddress`.
    ///   - authorization: Description for `authorization`.
    init(for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.name(emailAddress)
        )
    }
}

/// Creates or updates data for `SETAccountNameAPIRequest`.
class SETAccountNameAPIRequest: APIRequest<SETAccountNameAPIRequest.Parameters, AccountOwner> {
    struct Parameters: RequestBody {
        let name: String
    }
    /// - Parameters:
    ///   - newValue: Description for `newValue`.
    ///   - emailAddress: Description for `emailAddress`.
    ///   - authorization: Description for `authorization`.
    init(newValue: String, for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: AccountPath.name(emailAddress),
            body: Parameters(name: newValue)
        )
    }
}

/// Fetches data for `GETAddresses`.
class GETAddresses: APIRequest<None, AddressCollection> {
    /// - Parameters:
    ///   - authorization: Description for `authorization`.
    init(authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.addresses
        )
    }
}

/// Fetches data for `GETAddressesForEmailAPIRequest`.
class GETAddressesForEmailAPIRequest: APIRequest<None, AddressCollection> {
    /// - Parameters:
    ///   - emailAddress: Description for `emailAddress`.
    ///   - authorization: Description for `authorization`.
    init(for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.emailAddresses(emailAddress)
        )
    }
}

// MARK: - Addresses

/// Fetches a directory listing.
class GETAddressDirectoryRequest: APIRequest<None, AddressDirectoryResponse> {
    /// - Parameters:
    init() {
        super.init(path: AddressPath.directory)
    }
}

/// Checks for availability.
class GETAddressAvailabilityRequest: APIRequest<None, AddressAvailabilityResponse> {
    /// - Parameters:
    ///   - address: Description for `address`.
    init(for address: String) {
        super.init(path: AddressPath.availability(address))
    }
}

/// Retrieves addressinforequest information.
class GETAddressInfoRequest: APIRequest<None, AddressInfoResponse> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(for address: String, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: AddressPath.info(address)
        )
    }
}

/// Fetches data for `GETAddressExpirationRequest`.
class GETAddressExpirationRequest: APIRequest<None, AddressInfoResponse.Expiration> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(for address: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AddressPath.expiration(address)
        )
    }
}

// MARK: - Now

/// Retrieves Now page or status information.
class GETNowGardenRequest: APIRequest<None, NowGardenResponse> {
    /// - Parameters:
    init() {
        super.init(
            path: NowPath.garden
        )
    }
}

/// Retrieves Now page or status information.
class GETAddressNowPageRequest: APIRequest<None, String> {
    /// - Parameters:
    ///   - address: Description for `address`.
    init(_ address: AddressName) {
        super.init(
            path: NowPagePath.nowPage(address: address)
        )
    }
}

/// Retrieves Now page or status information.
class GETAddressNowRequest: APIRequest<None, AddressNowResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(for address: AddressName, authorization: APICredential?) {
        super.init(
            authorization: authorization,
            path: NowPath.now(address: address)
        )
    }
}

/// Creates or updates data for `SETAddressNowRequest`.
class SETAddressNowRequest: APIRequest<Now.Draft, BasicResponse> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - draft: Description for `draft`.
    ///   - authorization: Description for `authorization`.
    init(for address: AddressName, draft: Now.Draft, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: NowPath.now(address: address),
            body: draft
        )
    }
}

// MARK: - PasteBin

/// Retrieves pastebin contents.
class GETAddressPasteBin: APIRequest<None, PasteBinResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PasteBinPath.pastes(address)
        )
    }
}

/// Retrieves pastebin contents.
class GETAddressPaste: APIRequest<None, PasteResponseModel> {
    /// - Parameters:
    ///   - title: Description for `title`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ title: String, from address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PasteBinPath.paste(title, address: address)
        )
    }
}

/// Deletes a resource related to `DELETEAddressPasteContent`.
class DELETEAddressPasteContent: APIRequest<None, BasicResponse> {
    /// - Parameters:
    ///   - paste: Description for `paste`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(paste: String, address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: PasteBinPath.managePaste(paste, address: address)
        )
    }
}

/// Creates or updates data for `SETAddressPaste`.
class SETAddressPaste: APIRequest<Paste.Draft, SavePasteResponseModel> {
    /// - Parameters:
    ///   - draft: Description for `draft`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ draft: Paste.Draft, to address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: PasteBinPath.pastes(address),
            body: draft
        )
    }
}

// MARK: - PURL

/// Retrieves PURL data.
class GETAddressPURLs: APIRequest<None, PURLsResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PURLPath.purls(address)
        )
    }
}

/// Retrieves PURL data.
class GETAddressPURL: APIRequest<None, PURLResponseModel> {
    /// - Parameters:
    ///   - purl: Description for `purl`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ purl: String, address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PURLPath.managePurl(purl, address: address)
        )
    }
}

/// Retrieves PURL data.
class GETAddressPURLContent: APIRequest<None, String> {
    /// - Parameters:
    ///   - purl: Description for `purl`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(purl: String, address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PublicPath.purl(address, purl: purl)
        )
    }
}

/// Deletes a resource related to `DELETEAddressPURLContent`.
class DELETEAddressPURLContent: APIRequest<None, BasicResponse> {
    /// - Parameters:
    ///   - purl: Description for `purl`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(purl: String, address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: PURLPath.managePurl(purl, address: address)
        )
    }
}

/// Creates or updates data for `SETAddressPURL`.
class SETAddressPURL: APIRequest<PURL.Draft, BasicResponse> {
    /// - Parameters:
    ///   - draft: Description for `draft`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ draft: PURL.Draft, address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: PURLPath.managePurl(draft.name, address: address),
            body: draft
        )
    }
}

// MARK: - Profile

/// Fetches data for `GETPublicProfile`.
class GETPublicProfile: APIRequest<None, String> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ address: AddressName, with authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PublicPath.profile(address)
        )
    }
}

/// Fetches data for `GETProfile`.
class GETProfile: APIRequest<None, ProfileResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ address: AddressName, with authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: ProfilePath.profile(address)
        )
    }
}

/// Creates or updates data for `SETProfile`.
class SETProfile: APIRequest<Profile.Draft, BasicResponse> {
    /// - Parameters:
    ///   - draft: Description for `draft`.
    ///   - address: Description for `address`.
    ///   - credential: Description for `credential`.
    init(_ draft: Profile.Draft, from address: AddressName, with credential: APICredential) {
        super.init(
            authorization: credential,
            method: .POST,
            path: ProfilePath.profile(address),
            body: draft
        )
    }
}

// MARK: - StatusLog

/// Fetches data for `GETCompleteStatusLog`.
class GETCompleteStatusLog: APIRequest<None, StatusLogResponseModel> {
    /// - Parameters:
    init() {
        super.init(path: StatusPath.completeLog)
    }
}

/// Fetches data for `GETLatestStatusLogs`.
class GETLatestStatusLogs: APIRequest<None, StatusLogResponseModel> {
    /// - Parameters:
    init() {
        super.init(path: StatusPath.latestLogs)
    }
}

/// Fetches data for `GETAddressStatuses`.
class GETAddressStatuses: APIRequest<None, StatusLogResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressLog(address))
    }
}

/// Fetches data for `GETAddressStatusBio`.
class GETAddressStatusBio: APIRequest<None, StatusLogBioResponseModel> {
    /// - Parameters:
    ///   - address: Description for `address`.
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressBio(address))
    }
}
/// Retrieves the list of addresses followed by the given address.
/// - Parameter address: The omg.lol address whose follow list should be fetched.
class GETAddressFollowing: APIRequest<None, StatusLogFollowingModel> {
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressFollowing(address))
    }
}

/// Retrieves the list of followers for the given address.
/// - Parameter address: The omg.lol address whose followers should be fetched.
class GETAddressFollowers: APIRequest<None, StatusLogFollowersModel> {
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressFollowers(address))
    }
}

/// Submits a request for an address to follow another address.
/// - Parameters:
///   - address: The address initiating the follow.
///   - target: The address to follow.
///   - authorization: API credential of the follower.
class SETAddressFollowing: APIRequest<None, BasicResponse> {
    init(_ address: AddressName, _ target: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: StatusPath.addressFollow(address, target)
        )
    }
}

/// Unfollows a target address on behalf of another.
/// - Parameters:
///   - address: The address initiating the unfollow.
///   - target: The address to unfollow.
///   - authorization: API credential of the unfollower.
class DELETEAddressFollowing: APIRequest<None, BasicResponse> {
    init(_ address: AddressName, _ target: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: StatusPath.addressFollow(address, target)
        )
    }
}

/// Retrieves a specific status by ID for the given address.
/// - Parameters:
///   - status: The status ID.
///   - address: The omg.lol address owning the status.
class GETAddressStatus: APIRequest<None, StatusResponseModel> {
    /// - Parameters:
    ///   - status: Description for `status`.
    ///   - address: Description for `address`.
    init(_ status: String, from address: AddressName) {
        super.init(path: StatusPath.addressStatus(status, address))
    }
}

/// Deletes a resource related to `DELETEAddressStatus`.
class DELETEAddressStatus: APIRequest<Status.Draft, BasicResponse> {
    /// - Parameters:
    ///   - draft: Description for `draft`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ draft: Status.Draft, from address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .DELETE,
            path: StatusPath.addressLog(address),
            body: draft
        )
    }
}

/// Creates or updates data for `SETAddressStatus`.
class SETAddressStatus: APIRequest<Status.Draft, NewStatusResponseModel> {
    /// - Parameters:
    ///   - draft: Description for `draft`.
    ///   - address: Description for `address`.
    ///   - authorization: Description for `authorization`.
    init(_ draft: Status.Draft, with address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: StatusPath.addressLog(address),
            body: draft
        )
    }
}

// MARK: - Themes

/// Fetches available themes.
class GETThemes: APIRequest<None, ThemesResponseModel> {
    /// - Parameters:
    init() {
        super.init(path: ThemePath.themes)
    }
}

// MARK: - Pics

/// Retrieves the global omg.lol Pics feed.
class GETPicsFeed: APIRequest<None, PicsResponseModel> {
    init() {
        super.init(path: PicsPath.picsFeed)
    }
}

/// Retrieves all Pics for the specified omg.lol address.
/// - Parameter address: The address whose Pics should be fetched.
class GETAddressPics: APIRequest<None, PicsResponseModel> {
    init(_ address: String) {
        super.init(path: PicsPath.addressPics(address))
    }
}

/// Retrieves a specific Pic by name for the given address.
/// - Parameters:
///   - address: The address that owns the Pic.
///   - target: The Pic's filename or identifier.
class GETAddressPic: APIRequest<None, PicResponseModel> {
    init(_ address: String, target: String) {
        super.init(path: PicsPath.addressPic(address, target))
    }
}

/// Updates the metadata for an existing Pic.
/// - Parameters:
///   - draft: The updated description and tags.
///   - address: The address that owns the Pic.
///   - target: The Pic identifier to update.
///   - credential: API credential with permission to modify the Pic.
class PATCHAddressPic: APIRequest<Pic.Draft, BasicResponse> {
    init(draft: Pic.Draft, _ address: String, target: String, credential: APICredential) {
        super.init(
            authorization: credential,
            method: .PATCH,
            path: PicsPath.addressPic(address, target),
            body: draft
        )
    }
}

/// Uploads a new Pic to the specified address.
/// - Parameters:
///   - image: The raw image data to upload.
///   - address: The address to associate the Pic with.
///   - credential: API credential for authorization.
class POSTAddressPic: APIRequest<Data, PicResponseModel> {
    init(image: Data, _ address: String, credential: APICredential) {
        super.init(
            authorization: credential,
            method: .POST,
            path: PicsPath.upload(address),
            body: image,
            multipartBody: true
        )
    }
}

/// Deletes a Pic from the specified address.
/// - Parameters:
///   - address: The address that owns the Pic.
///   - target: The Pic to delete.
///   - credential: API credential with deletion rights.
class DELETEAddressPic: APIRequest<None, BasicResponse> {
    init(_ address: String, target: String, credential: APICredential) {
        super.init(
            authorization: credential,
            method: .DELETE,
            path: PicsPath.addressPic(address, target)
        )
    }
}

/// Retrieves raw image data for a specific Pic.
/// - Parameters:
///   - address: The address that owns the Pic.
///   - target: The Pic identifier.
///   - ext: The image file extension (e.g. "jpg", "png").
class GETPicData: APIRequest<None, Data> {
    init(_ address: String, target: String, ext: String) {
        super.init(path: CDNPath.pic(address, target, ext))
    }
}
