//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 26/01/2025.
//

public struct FeedErrorViewModel {
    public let message: String?
    
    public static var noError: FeedErrorViewModel {
        FeedErrorViewModel(message: nil)
    }
    
    public init(message: String?) {
        self.message = message
    }
}
