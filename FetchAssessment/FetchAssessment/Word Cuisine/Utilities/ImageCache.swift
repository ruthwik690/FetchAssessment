//
//  ImageCache.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//

import UIKit

actor ImageCache {
    
    public enum FileFetchError: Error {
        case imageNotFound
    }
    static let shared = ImageCache()
    
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let diskCacheDirectory: URL
    
    private init() {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        diskCacheDirectory = paths[0].appendingPathComponent("ImageCache")
        
        if !fileManager.fileExists(atPath: diskCacheDirectory.path) {
            try? fileManager.createDirectory(at: diskCacheDirectory, withIntermediateDirectories: true)
        }
    }
    
    func getImage(for url: String) async throws -> UIImage? {
        let cacheKey  = await md5(url) as NSString
        // Check Memory Cache
        if let cachedImage = memoryCache.object(forKey: cacheKey) {
            return cachedImage
        }
        
        // Check Disk Cache
        let fileURL = diskCacheDirectory.appendingPathComponent(cacheKey.lastPathComponent)
        if fileManager.fileExists(atPath: fileURL.path),
           let imageData = try? Data(contentsOf: fileURL),
           let image = UIImage(data: imageData) {
            memoryCache.setObject(image, forKey: cacheKey) // Cache in memory
            return image
        } else {
            throw ImageCache.FileFetchError.imageNotFound
        }
    }
       
    func saveImage(_ image: UIImage, for url: String) async throws {
        let cacheKey  = await md5(url) as NSString
        let fileURL = diskCacheDirectory.appendingPathComponent(cacheKey.lastPathComponent)
        
        // Save to Memory Cache
        memoryCache.setObject(image, forKey: cacheKey)
        
        // Save to Disk Cache
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try imageData.write(to: fileURL)
        }
    }
    
    /// Fetch image from memory, disk, or network.
    func fetchImage(from urlString: String) async throws -> UIImage? {
        let cacheKey  = await md5(urlString) as NSString
        // 1. Check Memory Cache
        if let cachedImage = memoryCache.object(forKey: cacheKey) {
            return cachedImage
        }
        
        // 2. Check Disk Cache
        let fileURL = diskCacheDirectory.appendingPathComponent(cacheKey.lastPathComponent)
        if fileManager.fileExists(atPath: fileURL.path),
           let imageData = try? Data(contentsOf: fileURL),
           let image = UIImage(data: imageData) {
            memoryCache.setObject(image, forKey: cacheKey) // Cache in memory
            return image
        }
        
        
        // 3. Download from Network
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
            request.networkServiceType = .responsiveData
        let (data, response) = try await NetworkProvider.shared.execute(request: request)
        guard response.statusCode == Http.Status.ok else {
            throw NetworkError.unexpectedResponse(
                statusCode: response.statusCode
            )
        }
        guard let image = UIImage(data: data) else { return nil }
        
        // 4. Save to Memory Cache
        memoryCache.setObject(image, forKey: cacheKey)
        
        // 5. Save to Disk Cache
        try data.write(to: fileURL)
        return image
    }
}
