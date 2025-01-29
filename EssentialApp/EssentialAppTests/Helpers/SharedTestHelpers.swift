//
//  SharedTestHelpers.swift
//  EssentialApp
//
//  Created by Mikalai Shuhno on 29/01/2025.
//

import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyData() -> Data {
    Data("any data".utf8)
}

func anyURL() -> URL {
    URL(string: "http://a-url.com")!
}
