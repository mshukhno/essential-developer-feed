//
//  ImageCommentsLocalizationTests.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 12/02/2025.
//

import XCTest
import EssentialFeed

class ImageCommentsLocalizationTests: XCTestCase {
    
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "ImageComments"
        let bundle = Bundle(for: ImageCommentsPresenter.self)
        
        assertLocalizedKeyAndValueExist(in: bundle, table)
    }
    
}
