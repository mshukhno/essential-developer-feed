//
//  UIButton+TestHelpers.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 20/01/2025.
//

import UIKit

extension UIButton {
    func simulateTap() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .touchUpInside)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
}
