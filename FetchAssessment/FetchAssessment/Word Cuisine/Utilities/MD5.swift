//
//  MD5.swift
//  Word Cuisine
//
//  Created by Ruthwik Nekkanti on 31/01/25.
//
import Foundation
import CryptoKit

@available(iOS 13.0, *)
func md5(_ string: String) async -> String {
    await withCheckedContinuation { continuation in
        DispatchQueue.global(qos: .userInitiated).async {
            let data = Data(string.utf8)
            let digest = Insecure.MD5.hash(data: data)
            let hashString = digest.map { String(format: "%02hhx", $0) }.joined()
            continuation.resume(returning: hashString)
        }
    }
}
