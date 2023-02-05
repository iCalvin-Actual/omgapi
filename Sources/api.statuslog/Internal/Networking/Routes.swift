//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

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
