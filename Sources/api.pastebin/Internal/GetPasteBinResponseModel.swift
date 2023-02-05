//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/4/23.
//

import api_core
import Foundation


struct PasteBinResponseModel: CommonAPIResponse {
    let message: String?
    let pastebin: [PasteResponseModel.Paste]
}
