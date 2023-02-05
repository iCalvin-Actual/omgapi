//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Combine
import Foundation

public extension OMGAPI {
    func getPURLs(for address: AddressName) -> ResultPublisher<[PURL]> {
        let request = GETAddressPURLs(address)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(response.purls.map({ PURL(address: address, name: $0.name, url: $0.url, counter: Int($0.counter ?? "") ?? 0, listed: $0.isPublic) }))
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getPURL(_ purl: String, for address: AddressName, credential: APICredentials) -> ResultPublisher<PURL> {
        let request = GETAddressPURL(purl, address: address, authorization: credential.authKey)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    let purl = PURL(address: address, name: response.purl.name, url: response.purl.url, counter: Int(response.purl.counter ?? "") ?? 0, listed: response.purl.isPublic)
                    return .success(purl)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func savePurl(_ draft: PURL.Draft, for address: AddressName, credential: APICredentials) -> ResultPublisher<PURL> {
        let request = SETAddressPURL(draft, address: address, authorization: credential.authKey)
        return publisher(for: request)
            .flatMap({ result in
                switch result {
                case .success(let response):
                    return self.getPURL(response.name, for: address, credential: credential)
                case .failure(let error):
                    return Just(.failure(error)).eraseToAnyPublisher()
                }
            })
            .eraseToAnyPublisher()
    }
    
    func deletePurl(_ title: String, from address: AddressName, credential: APICredentials) -> ResultPublisher<None> {
        let request = DELETEAddressPURL(title, address: address, authorization: credential.authKey)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success:
                    return .success(None.instance)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
