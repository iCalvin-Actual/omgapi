//
//  APIPath.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

// MARK: Protocols

protocol Path {
    var string: String  { get }
    var baseUrl: URL?   { get }
    var url: URL        { get }
}

protocol WebPath: Path {
}

extension WebPath {
    var baseUrl: URL? {
        nil
    }
}

protocol APIPath: Path {
}

extension APIPath {
    var baseUrl: URL? {
        CommonPath.api.url
    }
}

extension Path {
    var url: URL { URL(string: string, relativeTo: baseUrl)! }
}

// MARK: -

enum CommonPath: APIPath {
    private static let baseAPIString = "https://api.omg.lol"
    private static let serviceInfo = "service/info/"
    
    case api
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

enum AccountPath: APIPath {
    
    private static let oAuthExchange = "/oauth/?client_id={id}&client_secret={secret}&redirect_uri={redirect}&code={accessCode}&scope=everything"
    private static let accountInfo = "account/{email}/info/"
    private static let accountName = "account/{email}/name/"
    private static let accountSettings = "account/{email}/settings/"
    private static let accountAddresses = "account/application/addresses/"
    private static let emailAddresses = "account/{email}/addresses/"
    
    case oauth          (
        _ clientId: String,
        _ clientSecret: String,
        _ redirect: String,
        _ accessCode: String
    )
    case addresses
    case info           (_ emailAddress: String)
    case name           (_ emailAddress: String)
    case settings       (_ emailAddress: String)
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

enum AddressPath: APIPath {
    private static let addressDirectory = "directory/"
    private static let addressAvailability = "address/{address}/availability/"
    private static let addressExpiration = "address/{address}/expiration/"
    private static let addressInfo = "address/{address}/info/"
    
    case directory
    case availability   (_ address: String)
    case expiration     (_ address: String)
    case info           (_ address: String)
    
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
        }
    }
}

// MARK: -

enum NowPath: APIPath {
    private static let addressNow = "address/{address}/now/"
    private static let nowGarden = "now/garden/"
    
    case garden
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

enum PasteBinPath: APIPath {
    private static let addressPastes = "address/{address}/pastebin/"
    private static let addressPaste = "address/{address}/pastebin/{paste}/"
    
    case paste(_ title: String, address: AddressName)
    case pastes(_ address: AddressName)
    
    var string: String {
        switch self {
        case .paste(let title, address: let address):
            return Self.addressPaste.replacingPaste(title).replacingAddress(address)
        case .pastes(let address):
            return Self.addressPastes.replacingAddress(address)
            
        }
    }
}

// MARK: -

enum ProfilePath: WebPath {
    private static let addressProfile = "https://{address}.omg.lol"
    private static let addressPhoto = "address/{address}/pfp"
    
    case profile(_ address: AddressName)
    case photo(_ address: AddressName)
    
    var string: String {
        switch self {
        case .profile(let address):
            return Self.addressProfile.replacingAddress(address)
        case .photo(let address):
            return Self.addressPhoto.replacingAddress(address)
        }
    }
}

// MARK: -

enum PURLPath: APIPath {
    private static let addressPURLs = "address/{address}/purls/"
    private static let createPURL = "address/{address}/purl"
    private static let managePURL = "address/{address}/purl/{purl}"
    
    case purls(_ address: AddressName)
    case createPurl(_ address: AddressName)
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

enum StatusPath: APIPath {
    private static let statusLog = "statuslog/"
    private static let latestLog = "statuslog/latest/"
    private static let addressStatuses = "address/{address}/statuses"
    private static let addressStatus = "address/{address}/statuses/{status}"
    private static let addressLogBio = "address/{address}/statuses/bio"
    
    case completeLog
    case latestLogs
    case addressLog(_ address: AddressName)
    case addressStatus(_ status: String, _ address: AddressName)
    case addressBio(_ address: String)
    
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
        }
    }
}
