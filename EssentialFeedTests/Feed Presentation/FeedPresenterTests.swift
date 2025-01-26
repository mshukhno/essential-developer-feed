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
        let (view, _) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (ViewSpy, FeedPresenter) {
        let view = ViewSpy()
        let sut = FeedPresenter(view: view)
        trackForMemoryLeaks(view, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (view, sut)
    }
    
    
    class ViewSpy {
        private(set) var messages = [Any]()
    }
}
