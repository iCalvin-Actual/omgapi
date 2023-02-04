//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation

public enum CommunicationPreference: String, Response, Encodable {
    case noThankYou = "email_not_ok"
    case yesPlease = "email_ok"
}
