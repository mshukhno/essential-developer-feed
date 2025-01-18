//
//  FeedViewControllerTest.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 18/01/2025.
//

import XCTest

final class FeedViewController: UIViewController  {
    private var loader: FeedViewControllerTest.LoaderSpy?
    
    init(loader: FeedViewControllerTest.LoaderSpy) {
        self.loader = loader
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader?.load()
    }
}

final class FeedViewControllerTest: XCTestCase {
    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        _ = FeedViewController(loader: loader)
        
        XCTAssertEqual(loader.loadCallCount, 0)
    }
    
    func test_viewDidLoad_loadsFeed() {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadCallCount, 1)
    }
    
    // MARK: Helpers
    class LoaderSpy {
        private(set) var loadCallCount: Int = 0
        
        func load() {
            loadCallCount += 1
        }
    }
}
