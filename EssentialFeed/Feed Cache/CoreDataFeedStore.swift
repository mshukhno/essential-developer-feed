//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 12/01/2025.
//

import Foundation

public final class CoreDataFeedStore: FeedStore {
    public init() { }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }

    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
    }
}
