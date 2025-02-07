//
//  WeakRefVirtualProxy.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 23/01/2025.
//

import UIKit
import EssentialFeed
import EssentialFeediOS

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: ResourceLoadingView where T: ResourceLoadingView {
    func display(_ viewModel: ResourceLoadingViewModel) {
        object?.display(viewModel)
    }
}

extension WeakRefVirtualProxy: FeedImageView where T: FeedImageView, T.Image == UIImage {
    func display(_ viewModel: FeedImageViewModel<UIImage>) {
        object?.display(viewModel)
    }
}
    
extension WeakRefVirtualProxy: ResourceErrorView where T: ResourceErrorView {
    func display(errorMessage: ResourceErrorViewModel) {
        object?.display(errorMessage: errorMessage)
    }
}
