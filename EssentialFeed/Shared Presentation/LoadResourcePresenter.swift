//
//  LoadResourcePresenter.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 05/02/2025.
//

import Foundation

public protocol ResourceView {
    associatedtype ResourceViewModel
    func display(_ viewModel: ResourceViewModel)
}

public final class LoadResourcePresenter<Resource, View: ResourceView> {
    public typealias Mapper = (Resource) -> View.ResourceViewModel
    
    private let errorView: FeedErrorView
    private let loadingView: FeedLoadingView
    private let resourceView: View
    private let mapper: Mapper
    
    private static var feedLoadError: String {
        NSLocalizedString(
            "GENERIC_CONNECTION_ERROR",
            tableName: "Feed",
            bundle: Bundle(for: FeedPresenter.self),
            comment: "Error message displayed when we can't load the image feed from the server"
        )
    }
    
    public init(
        errorView: FeedErrorView,
        loadingView: FeedLoadingView,
        resourceView: View,
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
    
    public func didFinishLoading(with resource: Resource) {
        resourceView.display(mapper(resource))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoading(with error: Error) {
        loadingView.display(FeedLoadingViewModel(isLoading: false))
        errorView.display(errorMessage: .init(message: LoadResourcePresenter.feedLoadError))
    }
}
