//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/3/23.
//

import api_core
import Combine
import Foundation

extension OMGAPI {
    func getCompleteStatusLog() -> ResultPublisher<PublicLog> {
        let request = GETCompleteStatusLog()
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(PublicLog(statuses: response.statuses.map({ status in
                        Status(
                            id: status.id,
                            address: status.address,
                            created: status.createdDate,
                            content: status.content,
                            emoji: status.emoji,
                            externalURL: status.externalURL
                        )
                    })))
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getLatestStatusLog() -> ResultPublisher<PublicLog> {
        let request = GETLatestStatusLogs()
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(PublicLog(statuses: response.statuses.map({ status in
                        Status(
                            id: status.id,
                            address: status.address,
                            created: status.createdDate,
                            content: status.content,
                            emoji: status.emoji,
                            externalURL: status.externalURL
                        )
                    })))
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getAddressStatusLog(_ address: AddressName) -> ResultPublisher<StatusLog> {
        let logRequest = GETAddressStatuses(address)
        
        var logs: [Status] = []
        
        return publisher(for: logRequest)
            .flatMap({ result in
                switch result {
                case .success(let response):
                    logs = response.statuses.map({ status in
                        Status(
                            id: status.id,
                            address: status.address,
                            created: status.createdDate,
                            content: status.content,
                            emoji: status.emoji,
                            externalURL: status.externalURL
                        )
                    })
                    return self.getStatusLogBio(address)
                case .failure(let error):
                    return Just(.failure(error))
                        .eraseToAnyPublisher()
                }
            })
            .map { result in
                switch result {
                case .success(let response):
                    let status = StatusLog(address: address, bio: response, statuses: logs)
                    return .success(status)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getAddressStatus(_ status: String, for address: AddressName) -> ResultPublisher<Status> {
        let request = GETAddressStatus(status, from: address)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    let status = Status(id: response.status.id, address: response.status.address, created: response.status.createdDate, content: response.status.content, emoji: response.status.emoji, externalURL: response.status.externalURL)
                    return .success(status)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func postAddressStatus(_ draft: Status.Draft, for address: AddressName, with credentials: APICredentials) -> ResultPublisher<Status> {
        let request = SETAddressStatus(draft, from: address, with: credentials.authKey)
        return publisher(for: request)
            .flatMap { result in
                switch result {
                case .success(let response):
                    return self.getAddressStatus(response.id, for: address)
                case .failure(let error):
                    return Just(.failure(error))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func deleteAddressStatus(_ status: String, for address: AddressName, with credentials: APICredentials) -> ResultPublisher<None> {
        let request = DELETEAddressStatus(status, from: address, with: credentials.authKey)
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
    
    func getStatusLogBio(_ address: String) -> ResultPublisher<String> {
        let request = GETAddressStatusBio(address)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(response.bio ?? "")
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func updateStatusLogBio(_ draft: StatusLog.Bio.Draft, for address: AddressName, with credentials: APICredentials) -> ResultPublisher<StatusLog> {
        let request = SETAddressStatusBio(draft, for: address, authorization: credentials.authKey)
        return publisher(for: request)
            .flatMap { result in
                switch result {
                case .success:
                    return self.getAddressStatusLog(address)
                case .failure(let error):
                    return Just(.failure(error))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
