//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation

public enum DatePreference: String, Codable {
    case iso_8601
    case dmy
    case mdy
}
