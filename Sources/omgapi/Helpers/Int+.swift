//
//  Int+.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

extension Int {
    var boolValue: Bool {
        switch self {
        case 0:
            return false
        default:
            return true
        }
    }
}
