//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 30/12/2024.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
