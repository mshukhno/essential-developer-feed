//
//  ImageCommentsPresenter.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 12/02/2025.
//

import Foundation

public final class ImageCommentsPresenter {
    public static var title: String {
        NSLocalizedString(
            "IMAGE_COMMENTS_VIEW_TITLE",
            tableName: "ImageComments",
            bundle: Bundle(for: Self.self),
            comment: "Title for the image comments view"
        )
    }
}
