//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import Foundation

extension String {
    func replacingPaste(_ paste: String) -> String {
        replacingOccurrences(of: "{paste}", with: paste)
    }
}
