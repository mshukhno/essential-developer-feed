//
//  FeedPresenter.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 26/01/2025.
//

import Foundation

public final class FeedPresenter {
    public static var title: String {
        NSLocalizedString(
            "FEED_VIEW_TITLE",
            tableName: "Feed",
            bundle: Bundle(for: FeedPresenter.self),
            comment: "Title for the feed view"
        )
    }
}
