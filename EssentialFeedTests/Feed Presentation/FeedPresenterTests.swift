//
//  FeedPresenterTests.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 26/01/2025.
//

import XCTest
import EssentialFeed

protocol FeedErrorView {
    func display(errorMessage: FeedErrorViewModel)
}

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

struct FeedViewModel {
    let feed: [FeedImage]
}

struct FeedErrorViewModel {
    let message: String?
    
    static var noError: FeedErrorViewModel {
        FeedErrorViewModel(message: nil)
    }
}

struct FeedLoadingViewModel {
    let isLoading: Bool
}

class FeedPresenter {
    let errorView: FeedErrorView
    let loadingView: FeedLoadingView
    let feedView: FeedView
    
    init(errorView: FeedErrorView, loadingView: FeedLoadingView, feedView: FeedView) {
        self.errorView = errorView
        self.loadingView = loadingView
        self.feedView = feedView
    }
    
    func didStartLoadingFeed() {
        errorView.display(errorMessage: .noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}

class FeedPresenterTests: XCTestCase {
    
    func test_init_doesNotSendAnyMessagesToView() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    func test_didStartLoadingFeed_displaysNoErrorMessageAndStartLoading() {
        let (sut, view) = makeSUT()
        sut.didStartLoadingFeed()
        
        XCTAssertEqual(
            view.messages, [
                .display(errorMessage: .none),
                .display(isLoading: true)
            ]
        )
    }
    
    func test_didFinishLoadingFeed_displaysFeedAndStopsLoading() {
        let (sut, view) = makeSUT()
        let feed = uniqueImageFeed().models
        sut.didFinishLoadingFeed(with: feed)
        
        XCTAssertEqual(
            view.messages, [
                .display(isLoading: false),
                .display(feed: feed)
            ]
        )
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (FeedPresenter, ViewSpy) {
        let view = ViewSpy()
        let sut = FeedPresenter(errorView: view, loadingView: view, feedView: view)
        trackForMemoryLeaks(view, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, view)
    }
    
    
    class ViewSpy: FeedErrorView, FeedLoadingView, FeedView {
        private(set) var messages = Set<Message>()
        
        enum Message: Hashable {
            case display(errorMessage: String?)
            case display(isLoading: Bool)
            case display(feed: [FeedImage])
        }
        
        func display(errorMessage: FeedErrorViewModel) {
            messages.insert(.display(errorMessage: errorMessage.message))
        }
        
        func display(_ viewModel: FeedLoadingViewModel) {
            messages.insert(.display(isLoading: viewModel.isLoading))
        }
        
        func display(_ viewModel: FeedViewModel) {
            messages.insert(.display(feed: viewModel.feed))
        }
    }
}
