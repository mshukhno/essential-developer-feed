//
//  FeedImageView.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 08/02/2025.
//

import Foundation

public final class FeedImagePresenter {
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        FeedImageViewModel(
            description: image.description,
            location: image.location
        )
    }
}
