//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Combine
import Foundation


extension APIManager {
    func getNow(_ address: String) -> APIResultPublisher<AddressNowResponseModel> {
        let request = requestConstructor.fetchNow(for: address)
        return requestPublisher(request)
    }
    
    func updateNow(for address: String, content: String, listed: Bool = false) -> APIResultPublisher<BasicResponse> {
        let request = requestConstructor.updateNow(for: address, content: content, listed: listed)
        return requestPublisher(request)
    }
    
    func getNowGarden() -> APIResultPublisher<NowGarden> {
        let request = requestConstructor.getNowGarden()
        return requestPublisher(request)
    }
}
