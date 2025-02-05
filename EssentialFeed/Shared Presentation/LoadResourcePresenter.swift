//
//  LoadResourcePresenter.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 05/02/2025.
//

import Foundation

public protocol ResourceView {
    func display(_ viewModel: String)
}

public final class LoadResourcePresenter {
    public typealias Mapper = (String) -> String
    
    private let errorView: FeedErrorView
    private let loadingView: FeedLoadingView
    private let resourceView: ResourceView
    private let mapper: Mapper
    
    private static var feedLoadError: String {
        NSLocalizedString(
            "FEED_VIEW_CONNECTION_ERROR",
            tableName: "Feed",
            bundle: Bundle(for: FeedPresenter.self),
            comment: "Error message displayed when we can't load the image feed from the server"
        )
    }
    
    public init(
        errorView: FeedErrorView,
        loadingView: FeedLoadingView,
        resourceView: ResourceView,
        mapper: @escaping Mapper
    ) {
        self.errorView = errorView
        self.loadingView = loadingView
        self.resourceView = resourceView
        self.mapper = mapper
    }
    
    public func didStartLoading() {
        errorView.display(errorMessage: .noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoading(with resource: String) {
        resourceView.display(mapper(resource))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoadingFeed(with error: Error) {
        loadingView.display(FeedLoadingViewModel(isLoading: false))
        errorView.display(errorMessage: .init(message: LoadResourcePresenter.feedLoadError))
    }
}
