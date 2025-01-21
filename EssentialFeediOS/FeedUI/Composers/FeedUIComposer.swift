//
//  FeedUIComposer.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 21/01/2025.
//

import EssentialFeed
import UIKit

public final class FeedUIComposer {
    private init() { }
    
    public static func feedComposeWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let refreshController = FeedRefreshViewController(feedLoader: feedLoader)
        let feedController = FeedViewController(refreshController: refreshController)
        refreshController.onRefresh = adaptFeedToControllers(forwardingTo: feedController, loader: imageLoader)
        
        return feedController
    }
    
    private static func adaptFeedToControllers(
        forwardingTo controller: FeedViewController,
        loader: FeedImageDataLoader
    ) -> (([FeedImage]) -> Void) {
        return { [weak controller] feed in
            controller?.tableModel = feed.map { image in
                FeedImageCellController(model: image, imageLoader: loader)
            }
        }
    }
}
