//
//  Paste.swift
//  api
//
//  Created by Calvin Chestnut on 3/5/23.
//

import Foundation

public struct Paste: Sendable {
    public let title: String
    public let author: String
    public let content: String
    public let modifiedOn: Date
    public let listed: Bool
}

public typealias PasteBin = [Paste]
