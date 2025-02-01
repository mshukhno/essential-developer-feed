//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 20/01/2025.
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}
