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
    func getPasteBin(for address: AddressName) -> ResultPublisher<PasteBin> {
        let request = GETAddressPasteBin(address)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(response.pastebin.map({ Paste(title: $0.title, author: address, content: $0.content, modifiedOn: $0.updated, listed: $0.listed.boolValue) }))
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getPaste(title: String, from address: AddressName) -> ResultPublisher<Paste> {
        let request = GETAddressPaste(title, from: address)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    let paste = Paste(title: response.paste.title, author: address, content: response.paste.content, modifiedOn: response.paste.updated, listed: response.paste.listed.boolValue)
                    return .success(paste)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func savePaste(_ draft: Paste.Draft, to address: AddressName, credential: APICredentials) -> ResultPublisher<Paste> {
        let request = SETAddressPaste(draft: draft, from: address, authorization: credential.authKey)
        return publisher(for: request)
            .flatMap { result in
                switch result {
                case .success(let response):
                    return self.getPaste(title: response.title, from: address)
                case .failure(let error):
                    return Just(.failure(error))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func deletePaste(_ title: String, from address: AddressName, with credential: APICredentials) -> ResultPublisher<None> {
        let request = DELETEAddressPaste(title, from: address, authorization: credential.authKey)
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
