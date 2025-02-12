//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 08/02/2025.
//

import Foundation

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?
    
    public var hasLocation: Bool {
        location != nil
    }
    
    public init(description: String? = nil, location: String? = nil) {
        self.description = description
        self.location = location
    }
}
