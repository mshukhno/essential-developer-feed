//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 22/01/2025.
//

import Foundation

public struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        location != nil
    }
}
