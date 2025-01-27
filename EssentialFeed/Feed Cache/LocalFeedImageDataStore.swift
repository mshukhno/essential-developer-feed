//
//  LocalFeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 27/01/2025.
//

import Foundation

public protocol FeedImageDataStore {
    typealias RetrievalResult = Swift.Result<Data?, Error>
    typealias InsertionResult = Swift.Result<Void, Error>
    
    func retrieve(
        dataForURL url: URL,
        completion: @escaping (RetrievalResult) -> Void
    )
    
    func insert(
        _ data: Data,
        for url: URL,
        completion: @escaping (InsertionResult) -> Void
    )
}
