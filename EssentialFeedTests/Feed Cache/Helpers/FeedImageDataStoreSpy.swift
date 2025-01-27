//
//  FeedImageDataStoreSpy.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 27/01/2025.
//

import Foundation
import EssentialFeed

final class FeedImageDataStoreSpy: FeedImageDataStore {
    enum Messages: Equatable {
        case retrieve(dataFor: URL)
        case insert(data: Data, for: URL)
    }
    
    private var retrievalCompletions = [(FeedImageDataStore.RetrievalResult) -> Void]()
    private(set) var receivedMessages = [Messages]()
    
    func insert(_ data: Data, for url: URL, completion: @escaping (FeedImageDataStore.InsertionResult) -> Void) {
        receivedMessages.append(.insert(data: data, for: url))
    }
    
    func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.RetrievalResult) -> Void) {
        retrievalCompletions.append(completion)
        receivedMessages.append(.retrieve(dataFor: url))
    }
    
    func completeRetrieval(with error: Error, at index: Int = 0) {
        retrievalCompletions[index](.failure(error))
    }
    
    func completeRetrieval(with data: Data?, at index: Int = 0) {
        retrievalCompletions[index](.success(data))
    }
}
