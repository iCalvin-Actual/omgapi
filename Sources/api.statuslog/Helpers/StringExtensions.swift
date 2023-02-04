//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

extension String {
    func replacingStatus(_ status: String) -> String {
        replacingOccurrences(of: "{status}", with: status)
    }
}
