//
//  FeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 21/01/2025.
//

import Foundation

public protocol FeedImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
