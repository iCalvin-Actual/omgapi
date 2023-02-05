//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation


public struct Account {
    public struct Address {
        let name: String
        let registered: TimeStamp
    }
    
    private let owner: AccountOwner
    private let info: AccountInfo
    private let settings: AccountSettings
    private let addresses: [Address]
    
    internal init(owner: AccountOwner, info: AccountInfo, settings: AccountSettings, addresses: [Address]) {
        self.owner = owner
        self.info = info
        self.settings = settings
        self.addresses = addresses
    }
}

extension Account {
    public var emailAddress: String                         { info.email }
    public var name: String                                 { owner.name ?? "" }
    public var created: Date                                { info.created.date }
    public var communicationChoice: CommunicationPreference { settings.communication ?? .yesPlease }
}
