//
//  Recipe+Extension.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 01/02/25.
//
import Foundation

extension Recipe {
    
    static var sample: Self = {
        try! JSONDecoder().decode(Self.self, from: sampleJSON)
    }()
    
    static var sampleEmpty: Self = {
        try! JSONDecoder().decode(Self.self, from: sampleEmptyJSON)
    }()
    
    static var sampleNull: Self = {
        try! JSONDecoder().decode(Self.self, from: sampleNullJSON)
    }()
    
    static let sampleJSON = """
    {
      "cuisine": "British",
      "name": "Bakewell Tart",
      "photo_url_large": "https://some.url/large.jpg",
      "photo_url_small": "https://some.url/small.jpg",
      "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
      "source_url": "https://some.url/index.html",
      "youtube_url": "https://www.youtube.com/watch?v=some.id"
    }
    """.data(using: .utf8)!
    
    static let sampleEmptyJSON = """
    {
      "cuisine": " ",
      "name": " ",
      "photo_url_large": " ",
      "photo_url_small": " ",
      "uuid": " ",
      "source_url": " ",
      "youtube_url": " "
    }
    """.data(using: .utf8)!
    
    static let sampleNullJSON = """
    {
      "cuisine": null,
      "name": null,
      "photo_url_large": null,
      "photo_url_small": null,
      "uuid": null,
      "source_url": null,
      "youtube_url": null
    }
    """.data(using: .utf8)!
}
