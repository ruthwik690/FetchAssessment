//
//  ViewState.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 02/02/25.
//

import SwiftUI

/// A generic ViewState, utilized to show different views depending on the state of this enum.
public enum ViewState<T>: Equatable where T: Equatable {
    case loading
    
    case success(result: T)
    
    // The message is of type LocalizedStringKey because Text view supports embedding
    // markdown via LocalizedStringKey.
    case failure(message: String)
}
