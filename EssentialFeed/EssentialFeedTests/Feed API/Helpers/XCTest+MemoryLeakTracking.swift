//
//  XCTest+MemoryLeakTracking.swift
//  EssentialFeedTests
//
//  Created by Mikalai Shuhno on 21/10/2024.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(
            _ instance: AnyObject,
            file: StaticString = #filePath,
            line: UInt = #line
        ) {
            addTeardownBlock { [weak instance] in
                XCTAssertNil(instance, "Instance should be deallocated. Potential memory leak.", file: file, line: line)
            }
        }
}
