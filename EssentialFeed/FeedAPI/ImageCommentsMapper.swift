//
//  ImageCommentsMapper.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 02/02/2025.
//

import Foundation

final class ImageCommentsMapper {
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard
            response.isOK,
            let root = try? JSONDecoder().decode(Root.self, from: data)
        else {
            throw RemoteImageCommentsLoader.Error.invalidData
        }
        
        return root.items
    }
}
