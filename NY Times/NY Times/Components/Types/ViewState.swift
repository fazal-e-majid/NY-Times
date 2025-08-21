//
//  ViewState.swift
//  NY Times
//
//  Created by fmajid on 21/08/2025.
//

import Foundation

/// For displaying correspoding View 
enum ViewState<T> {
    case loading
    case loaded(T)
    case error(Error)
}
