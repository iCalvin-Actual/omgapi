//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation


public struct Account {
    private let owner: AccountOwner
    private let info: AccountInfo
    private let settings: AccountSettings
    
    internal init(owner: AccountOwner, info: AccountInfo, settings: AccountSettings) {
        self.owner = owner
        self.info = info
        self.settings = settings
    }
}

extension Account {
    public var emailAddress: String                         { info.email }
    public var name: String                                 { owner.name ?? "" }
    public var created: Date                                { info.created.date }
    public var communicationChoice: CommunicationPreference { settings.communication ?? .yesPlease }
}
