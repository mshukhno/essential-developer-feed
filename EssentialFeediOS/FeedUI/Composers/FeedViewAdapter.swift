//
//  FeedViewAdapter.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 23/01/2025.
//

import UIKit
import EssentialFeed

final class FeedViewAdapter: FeedView {    
    private weak var controller: FeedViewController?
    private let imageLoader: FeedImageDataLoader
    
    init(controller: FeedViewController, imageLoader: FeedImageDataLoader) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    public func display(_ viewModel: FeedViewModel) {
        controller?.tableModel = viewModel.feed.map { model in
            let adapter = FeedImageDataLoaderPresentationAdapter<WeakRefVirtualProxy<FeedImageCellController>, UIImage>(
                model: model,
                imageLoader: imageLoader
            )
            let view = FeedImageCellController(delegate: adapter)
            
            adapter.presenter = FeedImagePresenter(
                view: WeakRefVirtualProxy<FeedImageCellController>(view),
                imageTransformer: UIImage.init
            )
            
            return view
        }
    }
}
