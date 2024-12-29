//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 29/12/2024.
//

import Foundation

public final class LocalFeedLoader {
    public typealias SavedResult = Error?
    
    private let store: FeedStore
    private let currentDate: () -> Date
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    public func save(items: [FeedItem], completion: @escaping (SavedResult) -> Void) {
        store.deleteCachedFeed { [weak self] error in
            guard let self else { return }
            
            if let cacheDeletingError = error {
                completion(cacheDeletingError)
            } else {
                self.cache(items: items, with: completion)
            }
        }
    }
    
    private func cache(items: [FeedItem], with completion: @escaping (SavedResult) -> Void) {
        store.insert(items.toLocal(), timestamp: currentDate()) { [weak self] error in
            guard self != nil else { return }
            completion(error)
        }
    }
}

private extension Array where Element == FeedItem {
    func toLocal() -> [LocalFeedItem] {
        map { LocalFeedItem(id: $0.id, description: $0.description, location: $0.location, imageURL: $0.imageURL) }
    }
}
