//
//  FeedLocalizationTests.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 23/01/2025.
//

import EssentialFeed
import XCTest

final class FeedLocalizationTests: XCTestCase {
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Feed"
        let bundle = Bundle(for: FeedPresenter.self)
        
        assertLocalizedKeyAndValueExist(in: bundle, table)
    }
}
