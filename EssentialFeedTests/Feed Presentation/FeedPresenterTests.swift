//
//  FeedPresenterTests.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 26/01/2025.
//

import XCTest

class FeedPresenter {
    let view: Any
    
    init(view: Any) {
        self.view = view
    }
}

class FeedPresenterTests: XCTestCase {
    
    func test_init_doesNotSendAnyMessagesToView() {
        let view = ViewSpy()
        _ = FeedPresenter(view: view)
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    // MARK: - Helpers
    
    class ViewSpy {
        private(set) var messages = [Any]()
    }
}
