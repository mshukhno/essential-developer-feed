//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 29/12/2024.
//

import Foundation

public typealias CachedFeed = (feed: [LocalFeedImage], timestamp: Date)

public protocol FeedStore {
    func deleteCachedFeed() throws
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws
    
    func retrieve() throws -> CachedFeed?
}
