//
//  WebView.swift
//  NY Times
//
//  Created by fmajid on 21/08/2025.
//

import Foundation
import SwiftUI
import WebKit

/// For displaying article details in the web view.
struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
        webview.backgroundColor = .white
        webview.isOpaque = true
        webview.load(URLRequest(url: url))
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
