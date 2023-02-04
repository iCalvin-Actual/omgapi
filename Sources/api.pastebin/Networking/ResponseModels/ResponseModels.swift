//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Foundation

struct PasteBinResponseModel: CommonAPIResponse {
    let message: String?
    let pastebin: [Paste]
}

struct PasteResponseModel: CommonAPIResponse {
    let message: String?
    let paste: Paste
}

struct NewPasteResponseModel: CommonAPIResponse {
    let message: String?
    let title: String
}


