//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 30/12/2024.
//

import Foundation

struct RemoteFeedItem: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
