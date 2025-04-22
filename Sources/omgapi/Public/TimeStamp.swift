//
//  TimeStamp.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Represents a timestamp returned by the omg.lol API,
public struct TimeStamp: Codable, Sendable {
    /// Optional human-readable message accompanying the timestamp.
    public let message: String?

    /// The decoded `Date` representation of the timestamp.
    public let date: Date

    private enum CodingKeys: String, CodingKey {
        case message
        case epoch = "unixEpochTime"
    }

    /// Initializes a new `TimeStamp` with a given `Date`.
    ///
    /// - Parameter date: The date to wrap in the timestamp.
    init(_ date: Date) {
        self.message = nil
        self.date = date
    }

    /// A timestamp representing the current moment.
    public static var now: TimeStamp { .init(.now) }

    /// Decodes a `TimeStamp` from an API response.
    ///
    /// The `unixEpochTime` field is expected as a `String` or `Int`.
    /// If decoding fails, a fallback value of `Date()` is used.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)

        let epochString: String?
        do {
            epochString = try container.decode(String.self, forKey: .epoch)
        } catch {
            epochString = "\(try container.decode(Int.self, forKey: .epoch))"
        }

        if let epochString = epochString {
            self.date = Date(timeIntervalSince1970: Double(epochString) ?? 0)
        } else {
            self.date = Date()
        }
    }

    /// Encodes the `TimeStamp` for transmission to an API.
    ///
    /// The `date` is encoded as a stringified epoch time.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        let epoch = date.timeIntervalSince1970
        try container.encode("\(epoch)", forKey: .epoch)
    }
}
