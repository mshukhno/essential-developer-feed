//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 30/01/2025.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedImage]) throws
}
