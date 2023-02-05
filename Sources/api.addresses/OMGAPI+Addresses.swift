//
//  File.swift
//  
//
//  Created by Calvin Chestnut on 2/2/23.
//

import api_core
import Combine
import Foundation

public extension OMGAPI {
    func getAddressDirectory() -> ResultPublisher<[AddressName]> {
        let directoryRequest = GETAddressDirectoryRequest()
        return publisher(for: directoryRequest)
            .map { result in
                switch result {
                case .success(let response):
                    return .success(response.directory)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getAvailability(for address: String) -> ResultPublisher<Availability> {
        let request = GETAddressAvailabilityRequest(for: address)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    let availability = Availability(address: response.address, available: response.available, punyCode: response.punyCode)
                    return .success(availability)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getDetails(for address: String) -> ResultPublisher<Address> {
        let request = GETAddressInfoRequest(for: address)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    let address = Address(name: response.address, registered: response.registration, expired: response.expiration.expired, verified: response.verification.verified)
                    return .success(address)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getExpirationDate(for address: String, with credentials: APICredentials) -> ResultPublisher<Date> {
        let request = GETAddressInfoRequest(for: address, authorization: credentials.authKey)
        return publisher(for: request)
            .map { result in
                switch result {
                case .success(let response):
                    let date = Date(timeIntervalSince1970: Double(response.expiration.unixEpochTime ?? "") ?? 0)
                    return .success(date)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
