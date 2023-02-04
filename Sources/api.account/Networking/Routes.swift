//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Foundation

extension APIURLConstructor {
    private var accountInfo: String      { "account/{email}/info/" }
    private var accountName: String      { "account/{email}/name/"}
    private var accountSettings: String  { "account/{email}/settings/" }
    private var accountAddresses: String { "account/{email}/addresses/" }
    
    public func accountInfo(emailAddress: String) -> URL {
        URL(string: replacingEmail(emailAddress, in: accountInfo), relativeTo: baseURL)!
    }
    
    public func accountName(emailAddress: String) -> URL {
        URL(string: replacingEmail(emailAddress, in: accountName), relativeTo: baseURL)!
    }
    
    public func accountSettings(emailAddress: String) -> URL {
        URL(string: replacingEmail(emailAddress, in: accountSettings), relativeTo: baseURL)!
    }
    
    public func accountAddresses(emailAddress: String) -> URL {
        URL(string: replacingEmail(emailAddress, in: accountAddresses), relativeTo: baseURL)!
    } 
}
