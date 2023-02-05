//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Combine
import Foundation

extension OMGAPI {
    
    func getPublicProfile(_ address: AddressName) -> ResultPublisher<PublicProfile> {
        let request = GETAddressProfile(address)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    let profile = PublicProfile(address: address, content: response.html)
                    return .success(profile)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getProfile(_ address: AddressName, with credential: APICredentials) -> ResultPublisher<Profile> {
        let request = GETAddressProfile(address, with: credential.authKey)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    let profile = Profile(address: address, content: response.content ?? "", theme: response.theme ?? "", head: response.head, css: response.css)
                    return .success(profile)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func updateProfile(_ draft: PublicProfile.Draft, for address: AddressName, with credential: APICredentials) -> ResultPublisher<Profile> {
        let request = SETAddressProfile(draft, for: address, with: credential.authKey)
        return publisher(for: request)
            .flatMap { result in
                switch result {
                case .success:
                    return self.getProfile(address, with: credential)
                case .failure(let error):
                    return Just(.failure(error))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getAddressPhoto(_ address: AddressName, with credential: APICredentials) -> ResultPublisher<None> {
        let request = GETAddressProfile(address, with: credential.authKey)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(None.instance)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func updateAddressPhoto(_ photo: ProfilePhoto, for address: AddressName, with credential: APICredentials) -> ResultPublisher<None> {
        let request = SETAddressPhoto(photo, for: address, with: credential.authKey)
        return publisher(forMultiPart: request)
            .flatMap { result in
                switch result {
                case .success(let response):
                    return self.getAddressPhoto(address, with: credential)
                case .failure(let error):
                    return Just(.failure(error))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
