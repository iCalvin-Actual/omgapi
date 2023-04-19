//
//  Requests.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

// MARK: - Service

class GETServiceInfoAPIRequest: APIRequest<None, ServiceInfoResponse> {
    init() {
        super.init(path: CommonPath.service)
    }
}

// MARK: - Account

class OAuthRequest: APIRequest<None, OAuthResponse> {
    init(with clientId: String, and clientSecret: String, redirect: String, accessCode: String) {
        super.init(
            path: AccountPath.oauth(clientId, clientSecret, redirect, accessCode)
        )
    }
}

class GETAccountInfoAPIRequest: APIRequest<None, AccountInfo> {
    init(for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.info(emailAddress)
        )
    }
}

class GETAccountNameAPIRequest: APIRequest<None, AccountOwner> {
    init(for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.name(emailAddress)
        )
    }
}

class SETAccountNameAPIRequest: APIRequest<SETAccountNameAPIRequest.Parameters, AccountOwner> {
    struct Parameters: RequestBody {
        let name: String
    }
    init(newValue: String, for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: AccountPath.name(emailAddress),
            body: Parameters(name: newValue)
        )
    }
}

class GETAddresses: APIRequest<None, AddressCollection> {
    init(authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.addresses
        )
    }
}

class GETAddressesForEmailAPIRequest: APIRequest<None, AddressCollection> {
    init(for emailAddress: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AccountPath.emailAddresses(emailAddress)
        )
    }
}

// MARK: - Addresses

class GETAddressDirectoryRequest: APIRequest<None, AddressDirectoryResponse> {
    init() {
        super.init(path: AddressPath.directory)
    }
}

class GETAddressAvailabilityRequest: APIRequest<None, AddressAvailabilityResponse> {
    init(for address: String) {
        super.init(path: AddressPath.availability(address))
    }
}

class GETAddressInfoRequest: APIRequest<None, AddressInfoResponse> {
    init(for address: String, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: AddressPath.info(address)
        )
    }
}

class GETAddressExpirationRequest: APIRequest<None, AddressInfoResponse.Expiration> {
    init(for address: String, authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: AddressPath.expiration(address)
        )
    }
}

// MARK: - Now

class GETNowGardenRequest: APIRequest<None, NowGardenResponse> {
    init() {
        super.init(
            path: NowPath.garden
        )
    }
}

class GETAddressNowRequest: APIRequest<None, AddressNowResponseModel> {
    init(for address: AddressName, authorization: APICredential?) {
        super.init(
            authorization: authorization,
            path: NowPath.now(address: address)
        )
    }
}

class SETAddressNowRequest: APIRequest<Now.Draft, BasicResponse> {
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

class GETAddressPasteBin: APIRequest<None, PasteBinResponseModel> {
    init(_ address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PasteBinPath.pastes(address)
        )
    }
}

class GETAddressPaste: APIRequest<None, PasteResponseModel> {
    init(_ title: String, from address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PasteBinPath.paste(title, address: address)
        )
    }
}

class SETAddressPaste: APIRequest<Paste.Draft, SavePasteResponseModel> {
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

class GETAddressPURLs: APIRequest<None, GETPURLsResponseModel> {
    init(_ address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PURLPath.purls(address)
        )
    }
}

class GETAddressPURL: APIRequest<None, GETPURLResponseModel> {
    init(_ purl: String, address: AddressName, authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PURLPath.managePurl(purl, address: address)
        )
    }
}

class SETAddressPURL: APIRequest<PURL.Draft, BasicResponse> {
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

class GETPublicProfile: APIRequest<None, String> {
    init(_ address: AddressName, with authorization: APICredential? = nil) {
        super.init(
            authorization: authorization,
            path: PublicPath.profile(address)
        )
    }
}

class GETProfile: APIRequest<None, ProfileResponseModel> {
    init(_ address: AddressName, with authorization: APICredential) {
        super.init(
            authorization: authorization,
            path: ProfilePath.profile(address)
        )
    }
}

class SETProfile: APIRequest<Profile.Draft, BasicResponse> {
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

class GETCompleteStatusLog: APIRequest<None, StatusLogResponseModel> {
    init() {
        super.init(path: StatusPath.completeLog)
    }
}

class GETLatestStatusLogs: APIRequest<None, StatusLogResponseModel> {
    init() {
        super.init(path: StatusPath.latestLogs)
    }
}

class GETAddressStatuses: APIRequest<None, StatusLogResponseModel> {
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressLog(address))
    }
}

class GETAddressStatusBio: APIRequest<None, StatusLogBioResponseModel> {
    init(_ address: AddressName) {
        super.init(path: StatusPath.addressBio(address))
    }
}

class GETAddressStatus: APIRequest<None, StatusResponseModel> {
    init(_ status: String, from address: AddressName) {
        super.init(path: StatusPath.addressStatus(status, address))
    }
}

class SETAddressStatus: APIRequest<Status.Draft, NewStatusResponseModel> {
    init(_ draft: Status.Draft, with address: AddressName, authorization: APICredential) {
        super.init(
            authorization: authorization,
            method: .POST,
            path: StatusPath.addressLog(address),
            body: draft
        )
    }
}
