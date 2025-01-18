//
//  FeedViewControllerTest.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 18/01/2025.
//

import XCTest

final class FeedViewController  {
    init(loader: FeedViewControllerTest.LoaderSpy) {
    }
}

final class FeedViewControllerTest: XCTestCase {
    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        _ = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }
    
    // MARK: Helpers
    class LoaderSpy {
        private(set) var loadCallCount: Int = 0
    }
}
