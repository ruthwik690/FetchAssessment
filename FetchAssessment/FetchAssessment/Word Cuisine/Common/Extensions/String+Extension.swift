//
//  String+Extension.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//
import Foundation

extension  String {
    
    public var url: URL? {
        URL(string: self)
    }
}
