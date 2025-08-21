//
//  Font+Ext.swift
//  NY Times
//
//  Created by fmajid on 21/08/2025.
//

import Foundation
import SwiftUI

/// Fonts used in the app.
extension UIFont {
    static func appRegular(_ size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Georgia", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func appBold(_ size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Georgia-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
    
    static func appItalic(_ size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Georgia-Italic", size: size) ?? .italicSystemFont(ofSize: size)
    }
}

extension Font {
    static func appRegular(_ size: CGFloat = UIFont.systemFontSize) -> Font {
        return Font(UIFont.appRegular(size))
    }
    
    static func appBold(_ size: CGFloat = UIFont.systemFontSize) -> Font {
        return Font(UIFont.appBold(size))
    }
    
    static func appItalic(_ size: CGFloat = UIFont.systemFontSize) -> Font {
        return Font(UIFont.appItalic(size))
    }
}
