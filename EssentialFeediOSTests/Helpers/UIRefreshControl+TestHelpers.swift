//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 20/01/2025.
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
}
