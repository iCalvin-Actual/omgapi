//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

extension String {
    func replacingEntry(_ entry: String) -> String {
        replacingOccurrences(of: "{entry}", with: entry)
    }
}
