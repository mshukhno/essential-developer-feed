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
        refreshController.onRefresh = { [weak feedController] feed in
            feedController?.tableModel = feed.map { image in
                FeedImageCellController(model: image, imageLoader: imageLoader)
            }
        }
        
        return feedController
    }
}
