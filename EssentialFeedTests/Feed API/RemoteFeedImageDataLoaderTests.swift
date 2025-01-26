//
//  RemoteFeedImageDataLoaderTests.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 26/01/2025.
//

import XCTest
import EssentialFeed

class RemoteFeedImageDataLoader {
    init(client: Any) {
        
    }
}

class RemoteFeedImageDataLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    // MARK: - Private
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteFeedImageDataLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedImageDataLoader(client: client)
        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, client)
    }
    
    private class HTTPClientSpy {
        var requestedURLs = [URL]()
    }
}

