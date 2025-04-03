//
//  FeedViewAdapter.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 23/01/2025.
//

import UIKit
import EssentialFeed
import EssentialFeediOS

final class FeedViewAdapter: ResourceView {    
    private weak var controller: ListViewController?
    private let imageLoader: (URL) -> FeedImageDataLoader.Publisher
    private let selection: (FeedImage) -> Void
    
    private typealias LoadMorePresentationAdapter = LoadResourcePresentationAdapter<Paginated<FeedImage>, FeedViewAdapter>
    
    init(controller: ListViewController, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher, selection: @escaping (FeedImage) -> Void) {
        self.controller = controller
        self.imageLoader = imageLoader
        self.selection = selection
    }
    
    public func display(_ viewModel: Paginated<FeedImage>) {
        let feed: [CellController] = viewModel.items.map { model in
            let adapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<FeedImageCellController>>(loader: { [imageLoader] in
                imageLoader(model.url)
            })
            
            let view = FeedImageCellController(
                viewModel: FeedImagePresenter.map(model),
                delegate: adapter,
                selection: { [selection] in
                    selection(model)
                }
            )
            
            adapter.presenter = LoadResourcePresenter(
                errorView: WeakRefVirtualProxy<FeedImageCellController>(view),
                loadingView: WeakRefVirtualProxy(view),
                resourceView: WeakRefVirtualProxy(view),
                mapper: { data in
                    guard let image = UIImage(data: data) else {
                        throw InvalidImageData()
                    }
                    
                    return image
                }
            )
            
            return CellController(id: model, view)
        }
        
        guard let loadMorePublisher = viewModel.loadMorePublisher else {
            controller?.display(feed)
            return
        }
        
        let loadMoreAdapter = LoadMorePresentationAdapter(loader: loadMorePublisher)
        let loadMore = LoadMoreCellController(callback: loadMoreAdapter.loadResource)
        
        loadMoreAdapter.presenter = LoadResourcePresenter(
            errorView: WeakRefVirtualProxy(loadMore),
            loadingView: WeakRefVirtualProxy(loadMore),
            resourceView: self,
            mapper: { $0 }
        )
        
        let loadMoreSection = [CellController(id: UUID(), loadMore)]
        
        controller?.display(feed, loadMoreSection)
    }
}

private struct InvalidImageData: Error {}
