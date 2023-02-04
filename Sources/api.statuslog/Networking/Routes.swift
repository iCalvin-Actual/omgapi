//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

extension APIURLConstructor {
    private var statusLog: String       { "statuslog/" }
    private var statusLatest: String    { "statuslog/latest/" }
    private var getStatus: String          { "address/{address}/statuses/{status}" }
    private var statuses: String        { "address/{address}/statuses" }
    private var bio: String             { "address/{address}/statuses/bio/" }
    
    public func completeStatusLog() -> URL {
        URL(string: statusLog, relativeTo: baseURL)!
    }
    
    public func statusLogLatest() -> URL {
        URL(string: statusLatest, relativeTo: baseURL)!
    }
    
    public func status(_ status: String, from address: String) -> URL {
        URL(string: replacingAddress(address, in: replacingStatus(status, in: getStatus)), relativeTo: baseURL)!
    }
    
    public func statuses(for address: String) -> URL {
        URL(string: replacingAddress(address, in: statuses), relativeTo: baseURL)!
    }
    
    public func bio(for address: String) -> URL {
        URL(string: replacingAddress(address, in: bio), relativeTo: baseURL)!
    }
}
