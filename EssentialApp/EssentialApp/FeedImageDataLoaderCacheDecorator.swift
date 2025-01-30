//
//  FeedImageDataLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Mikalai Shuhno on 30/01/2025.
//

import EssentialFeed
import Foundation

public final class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private let decoratee: FeedImageDataLoader
    private let cache: FeedImageDataCache
    
    public init(decoratee: FeedImageDataLoader, cache: FeedImageDataCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> any FeedImageDataLoaderTask {
        decoratee.loadImageData(from: url) { [weak self] result in
            switch result  {
            case let .success(data):
                self?.cache.saveIgnoringResult(for: url, data: data)
            default:
                break
            }
            completion(result)
        }
    }
}

private extension FeedImageDataCache {
    func saveIgnoringResult(for url: URL, data: Data) {
        save(data, for: url) { _ in }
    }
}
