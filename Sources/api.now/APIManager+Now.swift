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
    func getNowGarden() -> ResultPublisher<NowGarden> {
        let request = GETNowGardenRequest()
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(response.garden.map({ NowGardenEntry(address: $0.address, url: $0.url, updated: $0.updated) }))
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getNow(for address: AddressName) -> ResultPublisher<Now> {
        let request = GETAddressNowRequest(for: address)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(Now(address: address, content: response.now.content, listed: response.now.listed.boolValue, updated: response.now.updatedAt))
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func updateNow(_ draft: Now.Draft, for address: AddressName, credentials: APICredentials) -> ResultPublisher<Now> {
        let request = SETAddressNowRequest(draft, for: address, authorization: credentials.authKey)
        return publisher(for: request)
            .flatMap({ result in
                switch result {
                case .success:
                    return self.getNow(for: address)
                case .failure(let error):
                    return Just(.failure(error))
                        .eraseToAnyPublisher()
                }
            })
            .eraseToAnyPublisher()
    }
}
