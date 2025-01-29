//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 30/01/2025.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>
    
    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
