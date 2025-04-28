//
//  api.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Main client interface for interacting with api.omg.lol within omgapi
///
/// In general all access goes through the ``api`` interface, which acts as it's own Swift `actor`. Models are returned by the api asyncronously, the api itself is state-less. Each function requests all the data it needs, and returns everything relevant it receives.
///
/// Public requests like ``directory()``  and ``bio(for:)`` don't require any authentication. If that content isn't marked public however then the `api` will throw `APIError.notFound`.
///
/// Private resources can be fetched by providing an appropriate ``APICredential`` to the given request. If the `credential` property is marked as `optional` then providing `nil` will only return public resources. `APICredential` is generally only marked `nonoptional` if the function makes no sense in a public context, otherwise it's always `optional`.
///
/// Learn more in ``APICredential``
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
/// Make sure to handle common errors that may be thrown. See ``api/Error`` for more guidance
/// ```swift
/// do {
///    let profile = try await api.publicProfile("PrivateAddress")
/// } catch {
///    switch error as? api.Error {
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
    
    /// Default initializer does nothing in itself. New instances of `api` have all the internal models they need.
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
                    throw Error.unhandled(apiResponse.request.statusCode, message: "Request \(request.path) in failed state")
                }
                
                guard let result = apiResponse.result else {
                    throw Error.badResponse
                }
                return result
            }
        }
        catch {
            if let errorMessageResponse: APIResponse<BasicResponse> = try? api.decoder.decode(APIResponse.self, from: data) {
                throw Error.create(from: errorMessageResponse)
            }
            throw Error.badResponse
        }
    }
}

extension api {
    /// Error cases that may arise when working with the API
    public enum Error: Swift.Error, Equatable {
        
        /// An internal value used only for cases that shouldn't happen in normal usage
        case inconceivable

        /// The request had missing or invalid credentials
        case unauthenticated

        /// The requested resource either does not exist or is not public
        case notFound

        /// The request body was malformed or invalid.
        case badBody

        /// The response could not be decoded from the expected format.
        case badResponse

        /// A non-specific error with an unhandled HTTP status code and optional message.
        ///
        /// - Parameters:
        ///   - statusCode: The HTTP status code returned by the server.
        ///   - message: An optional error message from the API.
        case unhandled(_ statusCode: Int, message: String?)

        /// Creates an appropriate `APIError` based on an `APIResponse`.
        ///
        /// - Parameter response: The decoded response from the API, if any.
        /// - Returns: A corresponding `APIError` instance.
        static func create<R>(from response: APIResponse<R>?) -> Error {
            guard let response = response else {
                return .inconceivable
            }

            let status = response.request.statusCode

            switch status {
            case 401:
                return .unauthenticated
            case 404:
                return .notFound
            case 200:
                return .badResponse
            default:
                var message: String?

                if let responseMessage = (response.result as? CommonAPIResponse)?.message {
                    message = responseMessage
                }
                
                return .unhandled(status, message: message)
            }
        }
    }
}
