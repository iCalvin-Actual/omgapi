//
//  api.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Combine
import Foundation

// MARK: - Internal

public actor api {
    static let decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
    
    let requestConstructor = APIRequestConstructor()
    
    let urlSession: URLSession = .shared
    
    public init() {
    }
    
    func apiResponse<B, R>(for request: APIRequest<B, R>, priorityDecoding: ((Data) -> R?)? = nil) async throws -> R {
        let urlRequest: URLRequest
        switch request.multipartBody {
        case true:
            urlRequest = APIRequestConstructor.multipartUrlRequest(from: request)
        case false:
            urlRequest = APIRequestConstructor.urlRequest(from: request)
        }
        
        let (data, _) = try await urlSession.data(for: urlRequest)
        do {
            if let result = priorityDecoding?(data) {
                return result
            } else {
                let apiResponse = try api.decoder.decode(APIResponse<R>.self, from: data)
                guard apiResponse.request.success else {
                    throw APIError.unhandled(apiResponse.request.statusCode, message: "Request \(request.path) in failed state")
                }
                
                guard let result = apiResponse.result else {
                    throw APIError.badResponseEncoding
                }
                return result
            }
        }
        catch {
            if let errorMessageResponse: APIResponse<BasicResponse> = try? api.decoder.decode(APIResponse.self, from: data) {
                throw APIError.create(from: errorMessageResponse)
            }
            throw APIError.badResponseEncoding
        }
    }
    
    func multipartPublisher<B, R>(for request: APIRequest<B, R>) -> APIResultPublisher<R> {
        let dataTask = urlSession.dataTaskPublisher(for: APIRequestConstructor.multipartUrlRequest(from: request))
        return publisher(for: dataTask, priorityDecoding: nil)
    }
    
    func publisher<B, R>(for request: APIRequest<B, R>, priorityDecoding: ((Data) -> R?)? = nil) -> APIResultPublisher<R> {
        let dataTask = urlSession.dataTaskPublisher(for: APIRequestConstructor.urlRequest(from: request))
        return publisher(for: dataTask, priorityDecoding: priorityDecoding)
    }
    
    private func publisher<R>(for task: URLSession.DataTaskPublisher, priorityDecoding: ((Data) -> R?)?) -> APIResultPublisher<R> {
        task
            .map { data, response in
                do {
                    if let result = priorityDecoding?(data) {
                        return .success(result)
                    } else {
                        let apiResponse = try api.decoder.decode(APIResponse<R>.self, from: data)
                        guard apiResponse.request.success else {
                            return .failure(.create(from: apiResponse))
                        }
                        
                        guard let response = apiResponse.result else {
                            return .failure(.badResponseEncoding)
                        }
                        
                        return .success(response)
                    }
                }
                catch {
                    if let errorMessageResponse: APIResponse<BasicResponse> = try? api.decoder.decode(APIResponse.self, from: data) {
                        return .failure(.create(from: errorMessageResponse))
                    }
                    return .failure(.badResponseEncoding)
                }
            }
            .replaceError(with: .failure(.inconceivable))
            .eraseToAnyPublisher()
    }
    
    func requestPublisher<T: Response>(_ request: URLRequest) -> APIResultPublisher<T> {
        urlSession.dataTaskPublisher(for: request)
            .map { data, response in
                do {
                    let result: APIResponse<T> = try api.decoder.decode(APIResponse.self, from: data)
                    
                    guard result.request.success else {
                        return .failure(.create(from: result))
                    }
                    
                    guard let response = result.result else {
                        return .failure(.badResponseEncoding)
                    }
                    
                    return .success(response)
                }
                catch {
                    if let errorMessageResponse: APIResponse<BasicResponse> = try? api.decoder.decode(APIResponse.self, from: data) {
                        return .failure(.create(from: errorMessageResponse))
                    }
                    return .failure(.badResponseEncoding)
                }
            }
            .replaceError(with: .failure(.inconceivable))
            .eraseToAnyPublisher()
    }
}

public extension api {
    // MARK: - Service
    
    func serviceInfo() async throws -> ServiceInfo {
        let request = GETServiceInfoAPIRequest()
        let response = try await apiResponse(for: request)
        
        let info = ServiceInfo(summary: response.message ?? "", members: Int(response.members) ?? 0, addresses: Int(response.addresses) ?? 0, profiles: Int(response.profiles) ?? 0)
        
        return info
    }
    
    // MARK: - Account
    
    nonisolated
    func authURL(with clientId: String, redirect: String) -> URL? {
        URL(string: "https://home.omg.lol/oauth/authorize?client_id=\(clientId)&scope=everything&redirect_uri=\(redirect)&response_type=code")
    }
    
    func oAuthExchange(with clientId: String, and clientSecret: String, redirect: String, code: String) async throws -> APICredential? {
        let oAuthRequest = OAuthRequest(with: clientId, and: clientSecret, redirect: redirect, accessCode: code)
        
        let response = try await self.apiResponse(for: oAuthRequest, priorityDecoding: { data in
            try? api.decoder.decode(OAuthResponse.self, from: data)
        })
        
        return response.accessToken
    }
    
    func addresses(with credentials: APICredential) async throws -> [AddressName] {
        let request = GETAddresses(authorization: credentials)
        
        let response = try await self.apiResponse(for: request)
        
        return response.map({ $0.address })
    }
    
    func account(for emailAddress: String, with credentials: APICredential) async throws -> Account {
        let infoRequest = GETAccountInfoAPIRequest(
            for: emailAddress,
            authorization: credentials
        )
        let info = try await self.apiResponse(for: infoRequest)
        
        return Account(
            info: info
        )
    }
    
    // MARK: - Addresses
    
    func addressDirectory() async throws -> [AddressName] {
        let request = GETAddressDirectoryRequest()
        let response = try await apiResponse(for: request)
        return response.directory
    }
    
    func availability(_ address: AddressName) async throws -> Address.Availability {
        let request = GETAddressAvailabilityRequest(for: address)
        let response = try await apiResponse(for: request)
        return Address.Availability(
            address: response.address,
            available: response.available,
            punyCode: response.punyCode
        )
    }
    
    func details(_ address: AddressName) async throws -> Address {
        let request = GETAddressInfoRequest(for: address)
        let response = try await apiResponse(for: request)
        return Address(
            name: response.address,
            registered: response.registration,
            expired: response.expiration.expired,
            verified: response.verification.verified
        )
    }
    
    func expirationDate(_ address: AddressName, credentials: APICredential) async throws -> Date {
        let request = GETAddressInfoRequest(for: address, authorization: credentials)
        let response = try await apiResponse(for: request)
        let date = Date(timeIntervalSince1970: Double(response.expiration.unixEpochTime ?? "") ?? 0)
        return date
    }
    
    // MARK: - Now
    
    func nowGarden() async throws -> NowGarden {
        let request = GETNowGardenRequest()
        let response = try await apiResponse(for: request)
        return response.garden
            .map { NowGardenEntry(
                address: $0.address,
                url: $0.url,
                updated: $0.updated
            )}
    }
    
    func nowWebpage(for address: AddressName) async throws -> NowPage {
        let request = GETAddressNowPageRequest(address)
        let response = try await apiResponse(for: request) { data in
            String(data: data, encoding: .utf8)
        }
        return NowPage(
            address: address,
            content: response
        )
    }
    
    func now(for address: AddressName, credential: APICredential? = nil) async throws -> Now {
        let request = GETAddressNowRequest(for: address, authorization: credential)
        let response = try await apiResponse(for: request)
        return Now(
            address: address,
            content: response.now.content,
            listed: response.now.listed.boolValue,
            updated: response.now.updatedAt
        )
    }
    
    func saveNow(for address: AddressName, content: String, credential: APICredential) async throws -> Now? {
        let draft = Now.Draft(content: content, listed: true)
        let request = SETAddressNowRequest(for: address, draft: draft, authorization: credential)
        let _ = try await apiResponse(for: request)
        return try await now(for: address, credential: credential)
    }
    // MARK: - PasteBin
    
    func pasteBin(for address: AddressName, credential: APICredential?) async throws -> PasteBin {
        let request = GETAddressPasteBin(address, authorization: credential)
        let response = try await apiResponse(for: request)
        return response.pastebin.map { paste in
            Paste(
                title: paste.title,
                author: address,
                content: paste.content,
                modifiedOn: paste.updated,
                listed: paste.isPublic
            )
        }
    }
    
    func paste(_ title: String, from address: AddressName, credential: APICredential?) async throws -> Paste? {
        let request = GETAddressPaste(title, from: address)
        do {
            let response = try await apiResponse(for: request)
            let paste = response.paste
            return Paste(
                title: paste.title,
                author: address,
                content: paste.content,
                modifiedOn: paste.updated,
                listed: paste.isPublic
            )
        } catch let error as APIError {
            switch error {
            case .notFound:
                return nil
            default:
                throw error
            }
        }
    }
    
    func deletePaste(_ name: String, for address: AddressName, credential: APICredential) async throws {
        let request = DELETEAddressPasteContent(paste: name, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    func savePaste(_ draft: Paste.Draft, to address: AddressName, credential: APICredential) async throws -> Paste? {
        let request = SETAddressPaste(draft, to: address, authorization: credential)
        let response = try await apiResponse(for: request)
        return try await paste(response.title, from: address, credential: credential)
    }
    
    // MARK: - PURL
    
    func purls(from address: AddressName, credential: APICredential?) async throws -> [PURL] {
        let request = GETAddressPURLs(address)
        let response = try await apiResponse(for: request)
        return response.purls.map({ purl in
            PURL(
                address: address,
                name: purl.name,
                url: purl.url,
                counter: purl.counter ?? 0,
                listed: purl.isPublic
            )
        })
    }
    
    func purl(_ name: String, for address: AddressName, credential: APICredential?) async throws -> PURL {
        let request = GETAddressPURL(
            name,
            address: address,
            authorization: credential
        )
        do {
            let response = try await apiResponse(for: request)
            return PURL(
                address: address,
                name: response.purl.name,
                url: response.purl.url,
                counter: response.purl.counter ?? 0,
                listed: true
            )
        } catch {
            throw error
        }
    }
    
    func purlContent(_ name: String, for address: AddressName, credential: APICredential?) async throws -> String? {
        let request = GETAddressPURLContent(purl: name, address: address, authorization: credential)
        do {
            let response = try await apiResponse(for: request, priorityDecoding: { String(data: $0, encoding: .utf8) })
            return response
        } catch {
            throw error
        }
    }
    
    func deletePURL(_ name: String, for address: AddressName, credential: APICredential) async throws {
        let request = DELETEAddressPURLContent(purl: name, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    func savePURL(_ draft: PURL.Draft, to address: AddressName, credential: APICredential) async throws -> PURL? {
        let request = SETAddressPURL(draft, address: address, authorization: credential)
        let _ = try await apiResponse(for: request)
        return try await purl(draft.name, for: address, credential: credential)
    }
    
    // MARK: - Profile
    
    func publicProfile(_ address: AddressName) async throws -> PublicProfile {
        let request = GETPublicProfile(address)
        let response = try await apiResponse(for: request, priorityDecoding: { data in
            String(data: data, encoding: .utf8)
        })
        return PublicProfile(
            address: address,
            content: response
        )
    }
    
    func profile(_ address: AddressName, with credential: APICredential) async throws -> Profile {
        let request = GETProfile(address, with: credential)
        let response = try await apiResponse(for: request)
        return Profile(
            address: address,
            content: response.content ?? "",
            theme: response.theme ?? "",
            head: response.head,
            css: response.css
        )
    }
    
    func saveProfile(_ content: String, for address: AddressName, with credential: APICredential) async throws -> Profile {
        let request = SETProfile(.init(content: content, publish: true), from: address, with: credential)
        let _ = try await apiResponse(for: request)
        return try await profile(address, with: credential)
    }
    
    // MARK: - Status
    
    func completeStatusLog() async throws -> PublicLog {
        let request = GETCompleteStatusLog()
        let response = try await apiResponse(for: request)
        let statuses = response.statuses ?? []
        return PublicLog(statuses: statuses.map { status in
            Status(
                id: status.id,
                address: status.address,
                created: status.createdDate,
                content: status.content,
                emoji: status.emoji,
                externalURL: status.externalURL
            )
        })
    }
    
    func latestStatusLog() async throws -> PublicLog {
        let request = GETLatestStatusLogs()
        let response = try await apiResponse(for: request)
        let statuses = response.statuses ?? []
        return PublicLog(statuses: statuses.map { status in
            Status(
                id: status.id,
                address: status.address,
                created: status.createdDate,
                content: status.content,
                emoji: status.emoji,
                externalURL: status.externalURL
            )
        })
    }
    
    func statusLog(from address: AddressName) async throws -> StatusLog {
        let logs = try await logs(for: address)
        let bio = try await bio(for: address)
        
        return StatusLog(
            address: address,
            bio: bio,
            statuses: logs
        )
    }
    
    func logs(for address: String) async throws -> [Status] {
        guard !address.isEmpty else {
            return []
        }
        let request = GETAddressStatuses(address)
        let response = try await apiResponse(for: request)
        let statuses = response.statuses ?? []
        return statuses.map { status in
            Status(
                id: status.id,
                address: status.address,
                created: status.createdDate,
                content: status.content,
                emoji: status.emoji,
                externalURL: status.externalURL
            )
        }
    }
    
    func bio(for address: String) async throws -> StatusLog.Bio {
        let request = GETAddressStatusBio(address)
        let response = try await apiResponse(for: request, priorityDecoding: { data in
            if let response = try? api.decoder.decode(APIResponse<StatusLogBioResponseModel>.self, from: data) {
                if response.result?.message?.lowercased().hasPrefix("couldn’t find a statuslog bio for") ?? false {
                    return response.result
                }
            }
            return nil
        })
        return .init(content: response.bio ?? "")
    }
    
    func followers(for address: AddressName) async throws -> [AddressName] {
        let request = GETAddressFollowers(address)
        let response = try await apiResponse(for: request)
        return response.followers
    }
    
    func following(from address: AddressName) async throws -> [AddressName] {
        let request = GETAddressFollowing(address)
        let response = try await apiResponse(for: request)
        return response.following
    }
    
    func follow(_ target: AddressName, from address: AddressName, credential: APICredential) async throws {
        let request = SETAddressFollowing(address, target, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    func unfollow(_ target: AddressName, from address: AddressName, credential: APICredential) async throws {
        let request = DELETEAddressFollowing(address, target, authorization: credential)
        let _ = try await apiResponse(for: request)
    }
    
    func status(_ status: String, from address: AddressName) async throws -> Status {
        let request = GETAddressStatus(status, from: address)
        let response = try await apiResponse(for: request)
        return Status(
            id: response.status.id,
            address: response.status.address,
            created: response.status.createdDate,
            content: response.status.content,
            emoji: response.status.emoji,
            externalURL: response.status.externalURL
        )
    }
    
    func deleteStatus(_ status: Status.Draft, from address: AddressName, credential: APICredential) async throws -> Status? {
        guard let id = status.id else {
            return nil
        }
        let request = DELETEAddressStatus(status, from: address, authorization: credential)
        let backup = try await self.status(id, from: address)
        let _ = try await apiResponse(for: request)
        return backup
    }
    
    func saveStatus(_ draft: Status.Draft, to address: AddressName, credential: APICredential) async throws -> Status {
        let request = SETAddressStatus(draft, with: address, authorization: credential)
        let response = try await apiResponse(for: request)
        return try await status(response.id, from: address)
    }
    
    func themes() async throws -> [Theme] {
        let request = GETThemes()
        let response = try await apiResponse(for: request)
        let themes = response.themes.values.map({ model in
            Theme(
                id: model.id,
                name: model.name,
                created: model.created,
                updated: model.updated,
                author: model.author,
                authorUrl: model.authorUrl,
                version: model.version,
                license: model.license,
                description: model.description,
                previewCss: model.previewCss
            )
        })
        return themes
    }
}
