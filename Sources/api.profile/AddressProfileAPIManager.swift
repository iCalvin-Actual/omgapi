//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Combine
import Foundation

extension APIManager {
    func getProfile(_ address: String) -> APIResultPublisher<AddressProfileResponseModel> {
        let request = requestConstructor.getAddressProfile(address)
        return APIManager().requestPublisher(request)
    }
    
    func updateProfile(_ address: String, newContent: String, publish: Bool = false) -> APIResultPublisher<BasicResponse> {
        let request = requestConstructor.udpateAddressProfile(address, newContent: newContent, publish: publish)
        return requestPublisher(request)
    }
    
    func updateProfilePhoto(_ address: String, data: Data) -> APIResultPublisher<BasicResponse> {
        let request = requestConstructor.updatePhoto(address, data: data)
        return requestPublisher(request)
    }
}
