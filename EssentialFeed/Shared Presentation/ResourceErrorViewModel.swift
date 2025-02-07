//
//  ResourceErrorViewModel.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 26/01/2025.
//

public struct ResourceErrorViewModel {
    public let message: String?
    
    public static var noError: ResourceErrorViewModel {
        ResourceErrorViewModel(message: nil)
    }
    
    public init(message: String?) {
        self.message = message
    }
}
