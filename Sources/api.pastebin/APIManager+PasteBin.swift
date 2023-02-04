//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Combine
import Foundation

/*
 GET
 Auth: Yes/No
 Body: None
 Response: [
 message: String?
 pastebin: [AddressPaste]
 ]
 
 POST
 Auth: Yes
 Body: [
 title: String
 content: String
 ]
 Response: [
 message: String?
 title: String
 ]
 */

/*
GET
Auth: No
Body: None
Resposne: [
message: String?
paste: AddressPsate
]

DELETE
Auth: Yes
Body: None
Response: BasicResponse
*/
extension APIManager {
    func getPasteBin(for address: String) -> APIResultPublisher<PasteBinResponseModel> {
        let request = requestConstructor.getPastes(from: address)
        return requestPublisher(request)
    }
    
    func postPaste(draft: DraftPaste, with address: String) -> APIResultPublisher<NewPasteResponseModel> {
        let request = requestConstructor.newPaste(from: address, title: draft.title, content: draft.content)
        return requestPublisher(request)
    }
    
    func getPaste(title: String, from address: String) -> APIResultPublisher<PasteResponseModel> {
        let request = requestConstructor.getPaste(title: title, from: address)
        return requestPublisher(request)
    }
    
    func deletePaste(title: String, from address: String) -> APIResultPublisher<BasicResponse> {
        let request = requestConstructor.deletePaste(title: title, from: address)
        return requestPublisher(request)
    }
}
