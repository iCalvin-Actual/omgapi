//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import Foundation

/// Should be extended by the various modules with the URL routes needed
struct URLConstructor {
    private let baseAPIString: String = "https://api.omg.lol"
    var baseURL: URL { URL(string: baseAPIString)! }
    
    func replacingEmail(_ address: String, in path: String) -> String {
        path.replacingOccurrences(of: "{email}", with: address)
    }
}
