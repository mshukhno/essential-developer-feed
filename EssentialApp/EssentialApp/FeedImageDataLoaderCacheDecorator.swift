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
                self?.cache.save(data, for: url) { _ in }
            default:
                break
            }
            completion(result)
        }
    }
    
}
