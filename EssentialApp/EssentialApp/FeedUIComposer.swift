//
//  FeedUIComposer.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 21/01/2025.
//

import EssentialFeed
import UIKit
import EssentialFeediOS
import Combine

public final class FeedUIComposer {
    private init() { }
    
    public static func feedComposeWith(
        feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>,
        imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher
    ) -> FeedViewController {
        let presentationAdapter = LoadResourcePresentationAdapter<[FeedImage], FeedViewAdapter>(loader: feedLoader)
        
        let feedController = makeWith(
            delegate: presentationAdapter,
            title: FeedPresenter.title
        )
        
        let weakRefVirtualProxy = WeakRefVirtualProxy(feedController)
        
        presentationAdapter.presenter = LoadResourcePresenter(
            errorView: weakRefVirtualProxy,
            loadingView: weakRefVirtualProxy,
            resourceView: FeedViewAdapter(
                controller: feedController,
                imageLoader: imageLoader
            ),
            mapper: FeedPresenter.map
        )
        
        return feedController
    }
    
    private static func makeWith(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! FeedViewController
        feedController.delegate = delegate
        feedController.title = FeedPresenter.title
        
        return feedController
    }
}
