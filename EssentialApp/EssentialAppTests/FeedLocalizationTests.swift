//
//  FeedLocalizationTests.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 23/01/2025.
//

@testable import EssentialFeed
@testable import EssentialFeediOS
import Foundation
import XCTest

final class FeedLocalizationTests: XCTestCase {
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Feed"
        let presentationBundle = Bundle(for: FeedPresenter.self)
        
        assertLocalizedKeyAndValueExist(in: bundle, table)
    }
    
    // MARK: - Helpers
    private typealias LocalizedBundle = (bundle: Bundle, localization: String)
    
    private func allLocalizationBundles(
        in bundle: Bundle,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [LocalizedBundle] {
        return bundle.localizations.compactMap { localization in
            guard
                let path = bundle.path(forResource: localization, ofType: "lproj"),
                let localizedBundle = Bundle(path: path)
            else {
                XCTFail("Couldn't find bundle for localization: \(localization)", file: file, line: line)
                return nil
            }
            
            return (localizedBundle, localization)
        }
    }
    
    private func allLocalizedStringKeys(
        in bundles: [LocalizedBundle],
        table: String,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Set<String> {
        return bundles.reduce([]) { (acc, current) in
            guard
                let path = current.bundle.path(forResource: table, ofType: "strings"),
                let strings = NSDictionary(contentsOfFile: path),
                let keys = strings.allKeys as? [String]
            else {
                XCTFail("Couldn't load localized strings for localization: \(current.localization)", file: file, line: line)
                return acc
            }
            
            return acc.union(Set(keys))
        }
    }
}

