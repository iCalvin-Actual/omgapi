//
//  api.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation


// MARK: - Internal

/// Main client interface for interacting with api.omg.lol in omgapi
///
/// In general all access goes through the ``api`` interface, which acts as it's own Swift `actor`. Models are returned by the api asyncronously, the api itself is state-less. Each function requests all the data it needs, and returns everything relevant it receives.
///
/// Public omg.lol resources like ``Profile``, ``Status``, and ``NowGarden`` don't require any authentication. If that content isn't marked public however then the `api` will throw `APIError.notFound`.
///
/// Private resources can be fetched by providing an appropriate ``APICredential`` to the given request. If the `credential` property is marked as `optional` then providing `nil` will only return public resources. `APICredential` is generally only marked `nonoptional` if the function makes no sense in a public context, otherwise it's always `optional`.
///
/// Learn more in <doc:Authentication>
///
/// ## Getting started
///
/// Construct an ``api`` instance with the default ``init()`` to begine using
/// ```swift
/// let api = omgapi.api()
/// ```
///
/// Most api calls will be async
/// ```swift
/// async let info = try? api.serviceInfo()
/// let info = try? await api.serviceInfo()
/// ```
///
/// Make sure to handle common errors. See <doc:APIError> for more guidance
/// ```swift
/// do {
///    let profile = try await api.publicProfile("PrivateAddress")
/// } catch {
///    switch error as? APIError {
///    case .notFound:
///      // Handle private profile
///    default:
///      throw error
///    }
/// }
/// ```
public actor api {
    static let decoder: JSONDecoder = {
        var decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return decoder
    }()
    
    let requestConstructor = APIRequestConstructor()
    
    let urlSession: URLSession = .shared
    
    /// Creates a new instance of the api interface
    public init() {
    }
    
    /// Performs an async API call and decodes the response into a typed result.
    ///
    /// - Parameters:
    ///   - request: The APIRequest object describing the endpoint and body.
    ///   - priorityDecoding: An optional closure to decode the response before falling back to normal decoding.
    /// - Returns: A decoded value of type `R`.
    /// - Throws: `APIError` if the request fails or decoding is unsuccessful.
    func apiResponse<B, R>(for request: APIRequest<B, R>, priorityDecoding: ((Data) -> R?)? = nil) async throws -> R {
        let data: Data
        if request.path is LocalPath {
            data = FileManager.default.contents(atPath: request.path.string) ?? .init()
        } else {
            let urlRequest: URLRequest
            switch request.multipartBody {
            case true:
                urlRequest = APIRequestConstructor.multipartUrlRequest(from: request)
            case false:
                urlRequest = APIRequestConstructor.urlRequest(from: request)
            }
            
            let (fetchedData, _) = try await urlSession.data(for: urlRequest)
            data = fetchedData
        }
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
}
