//
//  FeedLoaderCacheDecoratorTests.swift
//  EssentialApp
//
//  Created by Mikalai Shuhno on 29/01/2025.
//

import XCTest
import EssentialFeed

final class FeedLoaderCacheDecorator: FeedLoader {
    private let decoratee: FeedLoader
    
    init(decoratee: FeedLoader) {
        self.decoratee = decoratee
    }

    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load(completion: completion)
    }
    
}

class FeedLoaderCacheDecoratorTests: XCTestCase {
    
    func test_load_deliversFeedOnLoaderSuccess() {
        let feed = uniqueFeed()
        let loader = FeedLoaderStub(result: .success(feed))
        let sut = FeedLoaderCacheDecorator(decoratee: loader)
        
        expect(sut, toCompleteWith: .success(feed))
    }
    
    func test_load_deliversFeedOnLoaderFailure() {
        let loader = FeedLoaderStub(result: .failure(anyNSError()))
        let sut = FeedLoaderCacheDecorator(decoratee: loader)
        
        expect(sut, toCompleteWith: .failure(anyNSError()))
    }
    
    private func expect(
        _ sut: FeedLoaderCacheDecorator,
        toCompleteWith expectedResult: FeedLoader.Result,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { result in
            switch (result, expectedResult) {
            case let (.success(receivedData), .success(expectedData)):
                XCTAssertEqual(receivedData, expectedData, "Expected to complete with success", file: file, line: line)
            case (.failure, .failure):
                break
            default:
                XCTFail("Expected to complete with \(expectedResult), got \(result) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
                
        wait(for: [exp], timeout: 1.0)
    }
}
