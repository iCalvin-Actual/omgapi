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
 Auth: Yes
 Body: None
 Response: [
   message: String?
   purls: [AddressPURL]
 ]
*/
    /*
     POST
     Auth: Yes
     Body: [
       name: String
       url: String
     ]
     Response: [
       message: String?
       name: String
       url: String
     ]
    */
    /*
     GET
     Auth: Yes
     Body: None
     Response: [
       message: String?
       purl: AddressPurl
     ]
     
     DELETE
     Auth: Yes
     Body: None
     Response: BasicResponse
    */

extension APIManager {
    
    func getPURLs(from address: String) -> APIResultPublisher<GetPURLsResponseModel> {
        let request = requestConstructor.getPurls(for: address)
        return requestPublisher(request)
    }
    
    func createPurl(for address: String, draft: DraftPURL) -> APIResultPublisher<AccountPURL> {
        let request = requestConstructor.createPurl(name: draft.name, url: draft.url, for: address)
        return requestPublisher(request)
    }
    
    func getPurl(purl: String, for address: String) -> APIResultPublisher<GetPURLResponseModel> {
        let request = requestConstructor.getPurl(purl: purl, from: address)
        return requestPublisher(request)
    }
    
    func updatePurl(purl: String, for address: String, with draft: DraftPURL) -> APIResultPublisher<UpdatePURLResponseModel> {
        let request = requestConstructor.updatePurl(purl: purl, name: draft.name, url: draft.url, from: address)
        return requestPublisher(request)
    }
    
    func deletePurl(purl: String, from address: String) -> APIResultPublisher<BasicResponse> {
        let request = requestConstructor.deletePurl(purl: purl, from: address)
        return requestPublisher(request)
    }
}
