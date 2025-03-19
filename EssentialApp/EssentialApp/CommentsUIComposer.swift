//
//  CommentsUIComposer.swift
//  EssentialApp
//
//  Created by Mikalai Shuhno on 15/03/2025.
//

import EssentialFeed
import UIKit
import EssentialFeediOS
import Combine

public final class CommentsUIComposer {
    private init() { }
    
    private typealias CommentsResourcePresentationAdapter = LoadResourcePresentationAdapter<[ImageComment], CommentsViewAdapter>
    
    public static func commentsComposeWith(
        commentsLoader: @escaping () -> AnyPublisher<[ImageComment], Error>
    ) -> ListViewController {
        let presentationAdapter = CommentsResourcePresentationAdapter(loader: commentsLoader)
        
        let commentsController = makeCommentsViewController(title: ImageCommentsPresenter.title)
        commentsController.onRefresh = presentationAdapter.loadResource
        
        presentationAdapter.presenter = LoadResourcePresenter(
            errorView: WeakRefVirtualProxy(commentsController),
            loadingView: WeakRefVirtualProxy(commentsController),
            resourceView: CommentsViewAdapter(controller: commentsController),
            mapper: { ImageCommentsPresenter.map($0) }
        )
        
        return commentsController
    }
    
    private static func makeCommentsViewController(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "ImageComments", bundle: bundle)
        let commentsController = storyboard.instantiateInitialViewController() as! ListViewController
        commentsController.title = title
        
        return commentsController
    }
}

final class CommentsViewAdapter: ResourceView {
    private weak var controller: ListViewController?
    
    init(controller: ListViewController) {
        self.controller = controller
    }
    
    public func display(_ viewModel: ImageCommentsViewModel) {
        controller?.display(viewModel.comments.map { viewModel in
            CellController(id: viewModel, ImageCommentCellController(model: viewModel) )
        })
    }
}
