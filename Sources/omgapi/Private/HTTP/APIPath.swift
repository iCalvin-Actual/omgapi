//
//  APIPath.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

// MARK: Protocols

/// A protocol representing a resolvable path to a URL.
protocol Path {
    /// The string representation of the path (e.g., "https://api.omg.lol").
    var string: String  { get }

    /// The base URL to which this path is relative, or `nil` if absolute.
    var baseUrl: URL?   { get }

    /// The resolved URL constructed from `string` and `baseUrl`.
    var url: URL        { get }
}

/// A marker protocol for paths intended to resolve to web URLs.
protocol WebPath: Path {
}

extension WebPath {
    /// Default implementation returns `nil`, indicating an absolute URL.
    var baseUrl: URL? {
        nil
    }
}

protocol LocalPath: Path {
}

extension LocalPath {
    var baseUrl: URL? {
        nil
    }
}

/// A marker protocol for paths intended to resolve to omg.lol API URLs.
protocol APIPath: Path {
}

extension APIPath {
    /// Default API base URL is `CommonPath.api.url`.
    var baseUrl: URL? {
        CommonPath.api.url
    }
}

extension Path {
    /// Computes the resolved URL from the path string and base URL.
    var url: URL { URL(string: string, relativeTo: baseUrl)! }
}

// MARK: -

/// Common base endpoints for general API access.
enum CommonPath: APIPath {
    private static let baseAPIString = "https://api.omg.lol"
    private static let serviceInfo = "service/info/"
    
    /// Base omg.lol API root URL.
    case api
    /// Endpoint for service info metadata.
    case service
    
    var string: String {
        switch self {
        case .api:
            return Self.baseAPIString
        case .service:
            return Self.serviceInfo
        }
    }
    
    var url: URL {
        switch self {
        case .api:
            return URL(string: string)!
        default:
            return URL(string: string, relativeTo: Self.api.url)!
        }
    }
}

// MARK: -

/// API endpoints for managing accounts, authentication, and related resources.
enum AccountPath: APIPath {
    
    private static let oAuthExchange = "/oauth/?client_id={id}&client_secret={secret}&redirect_uri={redirect}&code={accessCode}&scope=everything"
    private static let accountInfo = "account/{email}/info/"
    private static let accountName = "account/{email}/name/"
    private static let accountSettings = "account/{email}/settings/"
    private static let accountAddresses = "account/application/addresses/"
    private static let emailAddresses = "account/{email}/addresses/"
    
    /// OAuth exchange endpoint using client credentials and access code.
    case oauth          (
        _ clientId: String,
        _ clientSecret: String,
        _ redirect: String,
        _ accessCode: String
    )
    /// Returns the addresses associated with the application.
    case addresses
    /// Fetches account info for the given email.
    case info           (_ emailAddress: String)
    /// Fetches or updates the display name for the given email.
    case name           (_ emailAddress: String)
    /// Fetches or updates settings for the given email.
    case settings       (_ emailAddress: String)
    /// Lists all addresses linked to the given email.
    case emailAddresses (_ emailAddress: String)
    
    var string: String {
        switch self {
        case .oauth(let clientId, let clientSecret, let redirect, let accessCode):
            return Self.oAuthExchange
                .replacingOccurrences(of: "{id}", with: clientId)
                .replacingOccurrences(of: "{secret}", with: clientSecret)
                .replacingOccurrences(of: "{redirect}", with: redirect)
                .replacingOccurrences(of: "{accessCode}", with: accessCode)
        case .addresses:
            return Self.accountAddresses
        case .info(let email):
            return Self.accountInfo.replacingEmail(email)
        case .name(let email):
            return Self.accountName.replacingEmail(email)
        case .settings(let email):
            return Self.accountSettings.replacingEmail(email)
        case .emailAddresses(let email):
            return Self.emailAddresses.replacingEmail(email)
        }
    }
}

// MARK: -

/// API endpoints related to address metadata, availability, and registration.
enum AddressPath: APIPath {
    private static let addressDirectory = "directory/"
    private static let addressAvailability = "address/{address}/availability/"
    private static let addressExpiration = "address/{address}/expiration/"
    private static let addressInfo = "address/{address}/info/"
    private static let addressAvatar = "{address}/picture"
    
    /// Public directory listing of addresses.
    case directory
    /// Checks availability of a specific address.
    case availability   (_ address: String)
    /// Gets expiration info for an address.
    case expiration     (_ address: String)
    /// Gets metadata for an address.
    case info           (_ address: String)
    case avatar         (_ address: String)
    
    var baseUrl: URL? {
        switch self {
        case .avatar:
            return URL(string: "https://profiles.cache.lol")
        default:
            return CommonPath.api.url
        }
    }
    
    var string: String {
        switch self {
        case .directory:
            return Self.addressDirectory
        case .availability(let address):
            return Self.addressAvailability.replacingAddress(address)
        case .expiration(let address):
            return Self.addressExpiration.replacingAddress(address)
        case .info(let address):
            return Self.addressInfo.replacingAddress(address)
        case .avatar(let address):
            return Self.addressAvatar.replacingAddress(address)
        }
    }
}

// MARK: -

enum NowPagePath: WebPath {
    private static let addressNowPage = "https://{address}.omg.lol/now"
    
    case nowPage(address: AddressName)
    
    var string: String {
        switch self {
        case .nowPage(let address):
            return Self.addressNowPage.replacingAddress(address)
        }
    }
}

/// API endpoints for Now pages and the Now Garden.
enum NowPath: APIPath {
    private static let addressNow = "address/{address}/now/"
    private static let nowGarden = "now/garden/"
    
    /// The Now Garden directory.
    case garden
    /// Fetches the Now entry for an address.
    case now(address: AddressName)
    
    var string: String {
        switch self {
        case .garden:
            return Self.nowGarden
        case .now(let address):
            return Self.addressNow.replacingAddress(address)
        }
    }
}


// MARK: -

/// API endpoints for managing address-based Pastebin entries.
enum PasteBinPath: APIPath {
    private static let addressPastes = "address/{address}/pastebin/"
    private static let addressPaste = "address/{address}/pastebin/{paste}/"
    private static let managePaste = "address/{address}/pastebin/{paste}"
    
    /// Retrieves a specific paste.
    case paste(_ title: String, address: AddressName)
    /// Lists all pastes for an address.
    case pastes(_ address: AddressName)
    /// Endpoint for updating or deleting a paste.
    case managePaste(_ paste: String, address: AddressName)
    
    var string: String {
        switch self {
        case .paste(let title, address: let address):
            return Self.addressPaste.replacingPaste(title).replacingAddress(address)
        case .pastes(let address):
            return Self.addressPastes.replacingAddress(address)
        case .managePaste(let title, address: let address):
            return Self.managePaste.replacingPaste(title).replacingAddress(address)
        }
    }
}

// MARK: -

/// API endpoints for managing profile content.
enum ProfilePath: APIPath {
    private static let webpage = "address/{address}/web"
    
    /// Retrieves or updates the profile content.
    case profile(_ address: AddressName)
    
    var string: String {
        switch self {
        case .profile(let address):
            return Self.webpage.replacingAddress(address)
        }
    }
}

enum PublicPath: WebPath {
    private static let addressProfile = "https://{address}.omg.lol"
    private static let addressPhoto = "address/{address}/pfp"
    private static let addressPurl = "https://{address}.url.lol/{purl}"
    
    /// Public profile page URL.
    case profile(_ address: AddressName)
    /// Profile photo endpoint.
    case photo(_ address: AddressName)
    /// Public-facing PURL redirect.
    case purl(_ address: AddressName, purl: String)
    
    var string: String {
        switch self {
        case .profile(let address):
            return Self.addressProfile
                .replacingAddress(address)
        case .photo(let address):
            return Self.addressPhoto
                .replacingAddress(address)
        case .purl(let address, let purl):
            return Self.addressPurl
                .replacingAddress(address)
                .replacingPURL(purl)
        }
    }
}

// MARK: -

/// API endpoints for managing Persistent URLs (PURLs).
enum PURLPath: APIPath {
    private static let addressPURLs = "address/{address}/purls/"
    private static let createPURL = "address/{address}/purl"
    private static let managePURL = "address/{address}/purl/{purl}"
    
    /// Lists all PURLs for the address.
    case purls(_ address: AddressName)
    /// Creates a new PURL.
    case createPurl(_ address: AddressName)
    /// Updates or deletes a specific PURL.
    case managePurl(_ purl: String, address: AddressName)
    
    var string: String {
        switch self {
        case .purls(let address):
            return Self.addressPURLs.replacingAddress(address)
        case .createPurl(let address):
            return Self.createPURL.replacingAddress(address)
        case .managePurl(let purl, address: let address):
            return Self.managePURL.replacingPURL(purl).replacingAddress(address)
        }
    }
}

// MARK: -

/// API endpoints for working with statuslog posts, bios, and social graphs.
enum StatusPath: APIPath {
    private static let statusLog = "statuslog/"
    private static let latestLog = "statuslog/latest/"
    private static let addressStatuses = "address/{address}/statuses"
    private static let addressStatus = "address/{address}/statuses/{status}"
    private static let addressLogBio = "address/{address}/statuses/bio"
    private static let addressFollowing = "address/{address}/statuses/following"
    private static let addressFollowers = "address/{address}/statuses/followers"
    private static let addressFollow = "address/{address}/statuses/follow/{target}"
    
    /// Fetches the complete public status log.
    case completeLog
    /// Fetches the latest status entries.
    case latestLogs
    /// Lists all statuses for an address.
    case addressLog(_ address: AddressName)
    /// Fetches a specific status by ID.
    case addressStatus(_ status: String, _ address: AddressName)
    /// Retrieves statuslog bio for an address.
    case addressBio(_ address: String)
    /// Lists addresses followed by an address.
    case addressFollowing(_ address: String)
    /// Lists followers of an address.
    case addressFollowers(_ address: String)
    /// Follows a target address.
    case addressFollow(_ address: String, _ target: String)
    
    var string: String {
        switch self {
        case .completeLog:
            return Self.statusLog
        case .latestLogs:
            return Self.latestLog
        case .addressLog(let address):
            return Self.addressStatuses.replacingAddress(address)
        case .addressStatus(let status, let address):
            return Self.addressStatus.replacingAddress(address).replacingStatus(status)
        case .addressBio(let address):
            return Self.addressLogBio.replacingAddress(address)
        case .addressFollowing(let address):
            return Self.addressFollowing.replacingAddress(address)
        case .addressFollowers(let address):
            return Self.addressFollowers.replacingAddress(address)
        case .addressFollow(let address, let target):
            return Self.addressFollow.replacingAddress(address).replacingTarget(target)
        }
    }
}

// MARK: -

/// API endpoints for querying available omg.lol themes.
enum ThemePath: APIPath {
    private static let themesList: String = "theme/list"
    private static let theme: String = "theme/{id}/info"
    
    /// Lists all available omg.lol themes.
    case themes
    /// Retrieves detailed info for a specific theme.
    case theme(_ id: String)
    
    var string: String {
        switch self {
        case .theme(let id):
            return Self.theme.replacingOccurrences(of: "{id}", with: id)
        case .themes:
            return Self.themesList
        }
    }
}

// Mark: - Pics

/// API endpoints for managing omg.lol Pics uploads and metadata.
enum PicsPath: APIPath {
    private static let picFeed: String = "pics"
    private static let upload: String = "address/{address}/pics/upload"
    private static let addressPics: String = "address/{address}/pics"
    private static let addressPic: String = "address/{address}/pics/{target}"
    
    /// Public feed of all omg.lol Pics.
    case picsFeed
    /// Upload endpoint for a given address.
    case upload(_ address: String)
    /// Fetch all Pics uploaded by a specific address.
    case addressPics(_ address: String)
    /// Fetch metadata for a specific Pic by filename.
    case addressPic(_ address: String, _ target: String)
    
    var string: String {
        switch self {
        case .picsFeed:
            return Self.picFeed
        case .upload(let address):
            return Self.upload.replacingAddress(address)
        case .addressPics(let address):
            return Self.addressPics.replacingAddress(address)
        case .addressPic(let address, let target):
            return Self.addressPic.replacingAddress(address).replacingTarget(target)
        }
    }
}

/// Paths for accessing CDN-hosted images.
enum CDNPath: WebPath {
    private static let cdnPic = "https://cdn.some.pics/{address}/{target}{extension}"

    /// CDN image path for a Pic.
    case pic(_ address: String, _ target: String, _ extension: String)

    var string: String {
        switch self {
        case .pic(let address, let target, let ext):
            return Self.cdnPic.replacingAddress(address).replacingTarget(target).replacingExtension(ext)
        }
    }
}
