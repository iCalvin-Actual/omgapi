//
//  TimeStamp.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// Represents a timestamp returned by the omg.lol API,
struct TimeStamp: Codable, Sendable {
    /// Optional human-readable message accompanying the timestamp.
    let message: String?

    /// The decoded `Date` representation of the timestamp.
    let date: Date

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
    static var now: TimeStamp { .init(.now) }

    /// Decodes a `TimeStamp` from an API response.
    ///
    /// The `unixEpochTime` field is expected as a `String` or `Int`, and is
    /// required: a missing, null, or unparseable value throws. Use
    /// `LenientTimeStamp` for fields the API doesn't reliably populate.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)

        let epochString: String?
        do {
            epochString = try container.decode(String.self, forKey: .epoch)
        } catch {
            epochString = "\(try container.decode(Int.self, forKey: .epoch))"
        }

        guard let epochString, let epoch = Double(epochString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .epoch,
                in: container,
                debugDescription: "'\(epochString ?? "nil")' is not a valid unix epoch value"
            )
        }
        self.date = Date(timeIntervalSince1970: epoch)
    }

    /// Encodes the `TimeStamp` for transmission to an API.
    ///
    /// The `date` is encoded as a stringified epoch time.
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(message, forKey: .message)
        let epoch = date.timeIntervalSince1970
        try container.encode("\(epoch)", forKey: .epoch)
    }
}

/// A `TimeStamp` that decodes to a `nil` date instead of throwing when the API
/// omits, nulls, or malforms its `unix_epoch_time`.
///
/// omg.lol doesn't populate every timestamp it documents — lifetime addresses
/// carry no expiration epoch, and registration epochs aren't guaranteed either.
/// Decoding those strictly fails the entire response, so a single address
/// without a usable epoch would take down the whole account address list and
/// leave the app looking signed out. Anything unparseable becomes `nil` here
/// instead.
struct LenientTimeStamp: Codable, Sendable {
    /// The underlying timestamp, or `nil` if the API value was unusable.
    let timeStamp: TimeStamp?

    /// The decoded `Date`, if the API sent a usable epoch.
    var date: Date? { timeStamp?.date }

    /// Wraps an already-decoded timestamp.
    init(_ timeStamp: TimeStamp?) {
        self.timeStamp = timeStamp
    }

    init(from decoder: Decoder) throws {
        self.timeStamp = try? TimeStamp(from: decoder)
    }

    func encode(to encoder: Encoder) throws {
        guard let timeStamp else {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
            return
        }
        try timeStamp.encode(to: encoder)
    }
}
