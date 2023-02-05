//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

enum AccountPath: APIPath {
    private static let accountInfo = "account/{email}/info/"
    private static let accountName = "account/{email}/name/"
    private static let accountSettings = "account/{email}/settings/"
    private static let accountAddresses = "account/{email}/addresses/"
    
    case info       (_ emailAddress: String)
    case name       (_ emailAddress: String)
    case settings   (_ emailAddress: String)
    case addresses  (_ emailAddress: String)
    
    var string: String {
        switch self {
        case .info(let email):
            return Self.accountInfo.replacingEmail(email)
        case .name(let email):
            return Self.accountName.replacingEmail(email)
        case .settings(let email):
            return Self.accountSettings.replacingEmail(email)
        case .addresses(let email):
            return Self.accountAddresses.replacingEmail(email)
        }
    }
}
