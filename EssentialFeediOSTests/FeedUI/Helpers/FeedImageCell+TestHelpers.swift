//
//  FeedImageCell+TestHelpers.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 21/01/2025.
//

import EssentialFeediOS
import UIKit

extension FeedImageCell {
    func simulateRetryAction() {
        feedImageRetryButton.simulateTap()
    }
    
    var isShowingLocation: Bool {
        !locationContainer.isHidden
    }
    
    var isShowingImageLoadingIndicator: Bool {
        feedImageContainer.isShimmering
    }
    
    var isShowingRetryAction: Bool {
        !feedImageRetryButton.isHidden
    }
    
    var locationText: String? {
        locationLabel.text
    }
    
    var descriptionText: String? {
        descriptionLabel.text
    }
    
    var renderedImage: Data? {
        feedImageView.image?.pngData()
    }
}
