//
//  LoaderSpy.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 21/01/2025.
//

import Combine
import EssentialFeed
import EssentialFeediOS
import Foundation

extension FeedUIIntegrationTests {
    class LoaderSpy: FeedImageDataLoader {
        // MARK: - FeedLoader
        private var feedRequests = [PassthroughSubject<[FeedImage], Error>]()
        
        var loadFeedCallCount: Int {
            feedRequests.count
        }
        
        func loadPublisher() -> AnyPublisher<[FeedImage], Error> {
            let publisher = PassthroughSubject<[FeedImage], Error>()
            feedRequests.append(publisher)
            return publisher.eraseToAnyPublisher()
        }

        func completeFeedLoading(with feed: [FeedImage] = [], at index: Int = 0) {
            feedRequests[index].send(feed)
        }
        
        func completeFeedLoadingWithError(at index: Int) {
            let error = NSError(domain: "an error", code: 0)
            feedRequests[index].send(completion: .failure(error))
        }
        
        // MARK: - FeedImageDataLoader
        private struct TaskSpy: FeedImageDataLoaderTask {
            let cancelCallback: () -> Void
            
            func cancel() {
                cancelCallback()
            }
        }
        
        private var imageRequests = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
        
        var loadedImageURLs: [URL] {
            imageRequests.map { $0.url }
        }
        
        private(set) var cancelledImageURLs = [URL]()
        
        func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
            imageRequests.append((url, completion))
            
            return TaskSpy { [weak self] in
                self?.cancelledImageURLs.append(url)
            }
        }
        
        func completeImageLoading(with imageData: Data = Data(), at index: Int = 0) {
            if imageRequests.count > index {
                imageRequests[index].completion(.success(imageData))
            }
        }
        
        func completeImageLoadingWithError(at index: Int) {
            if imageRequests.count > index {
                let error = NSError(domain: "an error", code: 0)
                imageRequests[index].completion(.failure(error))
            }
        }
    }
}
