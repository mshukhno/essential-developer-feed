//
//  LocalFeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 27/01/2025.
//

import Foundation

public protocol FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws
    
    func retrieve(dataForURL url: URL) throws -> Data?
}
