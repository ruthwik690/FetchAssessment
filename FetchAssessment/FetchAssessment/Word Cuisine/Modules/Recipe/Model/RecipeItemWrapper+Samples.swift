//
//  Recipe+Samplesq.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 05/02/25.
//

import Foundation

public extension RecipeItemWrapper {
    static var sample: Self = {
        try! JSONDecoder().decode(Self.self, from: sampleJSON)
    }()
    
    static func sampleEmpty() throws -> Self {
        try JSONDecoder().decode(Self.self, from: sampleEmptyJSON)
    }
    
    static func sampleNull() throws -> Self {
        try JSONDecoder().decode(Self.self, from: sampleNullJSON)
    }
    
    static func sampleMalformed() throws -> Self {
        try JSONDecoder().decode(Self.self, from: malformedSampleJSON)
    }
    
    
    static let sampleJSON = """
        {
            "recipes": [
                {
                    "cuisine": "Malaysian",
                    "name": "Apam Balik",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                    "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                    "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                },
                {
                    "cuisine": "British",
                    "name": "Apple & Blackberry Crumble",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                    "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                    "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                },
                {
                    "cuisine": "British",
                    "name": "Apple Frangipan Tart",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
                    "uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
                    "youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
                },
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "youtube_url": "https://www.youtube.com/watch?v=1ahpSTf_Pvk"
                },
                {
                    "cuisine": "American",
                    "name": "Banana Pancakes",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/banana-pancakes",
                    "uuid": "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                    "youtube_url": "https://www.youtube.com/watch?v=kSKtb2Sv-_U"
                }]}
    """.data(using: .utf8)!
    
    static let sampleEmptyJSON = """
    {
      "recipes": []
    }
    """.data(using: .utf8)!
    
    static let sampleNullJSON = """
    {
      "recipes": null
    }
    """.data(using: .utf8)!
    
    static let malformedSampleJSON = """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/604d020a-967a-40e1-97d2-561de5c66807/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/604d020a-967a-40e1-97d2-561de5c66807/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/classic-christmas-pudding",
                    "uuid": "d603f36e-7aae-4a51-a96a-6711f582de19",
                    "youtube_url": "https://www.youtube.com/watch?v=Pb_lJxL1vtk"
                },
                {
                    "cuisine": "British",
                    "name": "Dundee Cake",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8bf9399d-c42c-4316-8a3b-5dfce59d986b/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8bf9399d-c42c-4316-8a3b-5dfce59d986b/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/2155640/dundee-cake",
                    "uuid": "6b628dfc-5473-4924-b80c-5718cdae8b2a",
                    "youtube_url": "https://www.youtube.com/watch?v=4hEXsfpeMQE"
                },
                {
                    "cuisine": "American",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/d23ad009-8f17-428f-a41f-5f3b5bc51883/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/d23ad009-8f17-428f-a41f-5f3b5bc51883/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/2155644/key-lime-pie",
                    "uuid": "303ce395-af37-4cff-87b4-09c75a4e07ed",
                    "youtube_url": "https://www.youtube.com/watch?v=q4Rz7tUkX9A"
                },
                {
                    "cuisine": "American",
                    "name": "Krispy Kreme Donut",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/def8c76f-9054-40ff-8021-7f39148ad4b7/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/def8c76f-9054-40ff-8021-7f39148ad4b7/small.jpg",
                    "source_url": "https://www.mythirtyspot.com/krispy-kreme-copycat-recipe-for/",
                    "uuid": "9e230f96-f93d-4d29-9230-a1f5fd539464",
                    "youtube_url": "https://www.youtube.com/watch?v=SamYg6IUGOI"
                },
                {
                    "cuisine": null,
                    "name": null,
                    "photo_url_large": null,
                    "photo_url_small": null,
                    "source_url": null,
                    "uuid": null,
                    "youtube_url": null
                },
                {
                    "cuisine": "Polish",
                    "name": "Polskie NaleÃ…â€ºniki (Polish Pancakes)",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8b526c42-5121-4ddf-b8f9-a0c1153b5c20/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8b526c42-5121-4ddf-b8f9-a0c1153b5c20/small.jpg",
                    "source_url": "https://www.tasteatlas.com/nalesniki/recipe",
                    "uuid": "25a52168-29f8-4309-b48b-a96cae6ce867",
                    "youtube_url": "https://www.youtube.com/watch?v=EZS4ev2crHc"
                },
                {
                    "name": " ",
                    "photo_url_large": null,
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/93e50ff1-bf1d-4f88-8978-e18e01d3231d/small.jpg",
                    "source_url": null,
                    "uuid": "11b2e8a4-7f4e-4b81-b8db-09ea2f10e9d3",
                    "youtube_url": null
                },
                {
                    "cuisine": " ",
                    "name": " ",
                    "photo_url_large": " ",
                    "photo_url_small": " ",
                    "source_url": null,
                    "uuid": " ",
                    "youtube_url": " "
                },
                {
                    "cuisine": " ",
                    "name": "Sugar Pie",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/25624a61-cf25-4e26-8a3a-b38f347e3642/large.jpg",
                    "source_url": null,
                    "uuid": "9f5a753e-472d-413e-a05b-ffbc8032e64c",
                    "youtube_url": "https://www.youtube.com/watch?v=uVQ66jiL-Dc"
                }
            ]
        }
    }
    """.data(using: .utf8)!
}
