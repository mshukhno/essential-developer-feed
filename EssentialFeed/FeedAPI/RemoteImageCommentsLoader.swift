//
//  RemoteImageCommentsLoader.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 02/02/2025.
//

import Foundation

public typealias RemoteImageCommentsLoader = RemoteLoader<[ImageComment]>

public extension RemoteImageCommentsLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: ImageCommentsMapper.map)
    }
}
