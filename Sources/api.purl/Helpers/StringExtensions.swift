//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/5/23.
//

import Foundation

extension String {
    func replacingPURL(_ purl: String) -> String {
        replacingOccurrences(of: "{purl}", with: purl)
    }
}
