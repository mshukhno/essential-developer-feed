//
//  UIControl+TestHelpers.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 20/01/2025.
//

import UIKit

extension UIControl {
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
