//
//  FeedLoaderWithFallbackComposite.swift
//  EssentialApp
//
//  Created by Mikalai Shuhno on 29/01/2025.
//

import EssentialFeed

public class FeedLoaderWithFallbackComposite: FeedLoader {
    private let primary: FeedLoader
    private let fallback: FeedLoader
    
    public init(primary: FeedLoader, fallback: FeedLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        primary.load { result in
            switch result {
            case .failure:
                self.fallback.load(completion: completion)
            case .success:
                completion(result)
            }
        }
    }
    
}
