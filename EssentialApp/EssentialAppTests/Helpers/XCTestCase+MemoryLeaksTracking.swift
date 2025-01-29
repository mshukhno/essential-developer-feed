//
//  XCTestCase+MemoryLeaksTracking.swift
//  EssentialApp
//
//  Created by Mikalai Shuhno on 29/01/2025.
//

import XCTest

public extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
