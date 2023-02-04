//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

extension APIRequestConstructor {
    func request() -> URLRequest {
        request(with: urlConstructor.baseURL)
    }
}
