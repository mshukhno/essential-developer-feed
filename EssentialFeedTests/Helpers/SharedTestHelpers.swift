//
//  SharedTestHelpers.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 03/01/2025.
//

import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "https://any-url.com")!
}
