//
//  FontExtensionsTests.swift
//  NY TimesTests
//
//  Created by fmajid on 21/08/2025.
//

import XCTest
import SwiftUI
@testable import NY_Times

final class FontExtensionsTests: XCTestCase {
    
    func testAppRegularReturnsCorrectFontNameAndSize() {
        let expectedSize: CGFloat = 18.0
        let font = UIFont.appRegular(expectedSize)
        
        XCTAssertEqual(font.fontName, "Georgia", "The font name should be 'Georgia'")
        XCTAssertEqual(font.pointSize, expectedSize, accuracy: 0.001, "The font size should match the requested size")
    }
    
    func testAppRegularReturnsSystemFontAsFallback() {
        let font = UIFont.appRegular()
        XCTAssertNotNil(font, "The appRegular method should never return a nil font.")
        
        let nonexistentFont = UIFont(name: "NonexistentFont", size: 12)
        XCTAssertNil(nonexistentFont, "This assert confirms that a nonexistent font returns nil.")
    }
    
    func testAppBoldReturnsCorrectFontName() {
        let font = UIFont.appBold(18)
        
        XCTAssertEqual(font.fontName, "Georgia-Bold", "The bold font should have a font name of 'Georgia-Bold'")
    }
    
    func testAppItalicReturnsCorrectFontName() {
        let font = UIFont.appItalic(18)
        
        XCTAssertEqual(font.fontName, "Georgia-Italic", "The italic font should have a font name of 'Georgia-Italic'")
    }
}
