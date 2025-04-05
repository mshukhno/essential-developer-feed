//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 30/01/2025.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}
