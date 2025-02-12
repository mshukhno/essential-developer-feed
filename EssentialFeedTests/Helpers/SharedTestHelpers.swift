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

func anyData() -> Data {
    Data("any data".utf8)
}

func makeItemsJSON(_ items: [[String: Any]]) -> Data {
    let json = ["items": items]
    return try! JSONSerialization.data(withJSONObject: json)
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

extension Date {
    func adding(seconds: TimeInterval) -> Date {
        self + seconds
    }
    
    func adding(days: Int, calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(minutes: Int, calendar: Calendar = .current) -> Date {
        calendar.date(byAdding: .minute, value: minutes, to: self)!
    }
}
