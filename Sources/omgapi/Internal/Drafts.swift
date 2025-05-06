//
//  Drafts.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

/// A base protocol for all data types that can be submitted to the omg.lol API as a draft.
///
/// Types conforming to `Draft` are encodable and safe for concurrent use.
protocol Draft: RequestBody, Sendable {
}

/// A shared protocol for all markdown-like draft types sent to the omg.lol API.
///
/// Types conforming to `MDDraft` include a content body and are safe for concurrent use.
/// Used for posting or updating resources like statuses, profiles, Now entries, pastes, and PURLs.
protocol MDDraft: Draft {
    var content: String { get }
}
