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
    
    private let errorView: ResourceErrorView
    private let loadingView: ResourceLoadingView
    private let resourceView: View
    private let mapper: Mapper
    
    public static var loadError: String {
        NSLocalizedString(
            "GENERIC_CONNECTION_ERROR",
            tableName: "Shared",
            bundle: Bundle(for: FeedPresenter.self),
            comment: "Error message displayed when we can't load the resource from the server"
        )
    }
    
    public init(
        errorView: ResourceErrorView,
        loadingView: ResourceLoadingView,
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
        loadingView.display(ResourceLoadingViewModel(isLoading: true))
    }
    
    public func didFinishLoading(with resource: Resource) {
        resourceView.display(mapper(resource))
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
    }
    
    public func didFinishLoading(with error: Error) {
        loadingView.display(ResourceLoadingViewModel(isLoading: false))
        errorView.display(errorMessage: .init(message: LoadResourcePresenter.loadError))
    }
}
