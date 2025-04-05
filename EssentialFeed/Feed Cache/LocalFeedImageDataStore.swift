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
    
    @available(*, deprecated)
    func retrieve(
        dataForURL url: URL,
        completion: @escaping (RetrievalResult) -> Void
    )
    
    @available(*, deprecated)
    func insert(
        _ data: Data,
        for url: URL,
        completion: @escaping (InsertionResult) -> Void
    )
}

public extension FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws {
        let group = DispatchGroup()
        group.enter()
        var result: InsertionResult!
        insert(data, for: url) {
            result = $0
            group.leave()
        }
        group.wait()
        return try result.get()
    }

    func retrieve(dataForURL url: URL) throws -> Data? {
        let group = DispatchGroup()
        group.enter()
        var result: RetrievalResult!
        retrieve(dataForURL: url) {
            result = $0
            group.leave()
        }
        group.wait()
        return try result.get()
    }
    
    func retrieve(
        dataForURL url: URL,
        completion: @escaping (RetrievalResult) -> Void
    ) { completion(.success(.none)) }
    
    func insert(
        _ data: Data,
        for url: URL,
        completion: @escaping (InsertionResult) -> Void
    ) { completion(.success(())) }
}
