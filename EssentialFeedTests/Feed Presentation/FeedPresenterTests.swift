//
//  FeedPresenterTests.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 26/01/2025.
//

import XCTest

protocol FeedErrorView {
    func display(errorMessage: FeedErrorViewModel)
}

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        FeedErrorViewModel(message: nil)
    }
}

class FeedPresenter {
    let errorView: FeedErrorView
    
    init(errorView: FeedErrorView) {
        self.errorView = errorView
    }
    
    func didStartLoadingFeed() {
        errorView.display(errorMessage: .noError)
    }
}

class FeedPresenterTests: XCTestCase {
    
    func test_init_doesNotSendAnyMessagesToView() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    func test_didStartLoadingFeed_displaysNoErrorMessage() {
        let (sut, view) = makeSUT()
        sut.didStartLoadingFeed()
        
        XCTAssertEqual(view.messages, [.display(errorMessage: .none)])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (FeedPresenter, ViewSpy) {
        let view = ViewSpy()
        let sut = FeedPresenter(errorView: view)
        trackForMemoryLeaks(view, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, view)
    }
    
    
    class ViewSpy: FeedErrorView {
        private(set) var messages = [Message]()
        
        enum Message: Equatable {
            case display(errorMessage: String?)
        }
        
        func display(errorMessage: FeedErrorViewModel) {
            messages.append(.display(errorMessage: errorMessage.message))
        }
    }
}
