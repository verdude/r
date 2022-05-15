//
//  Listings.swift
//  r
//
//  Created by e on 5/10/22.
//

import Foundation

struct Root: Codable {
    let data: Parent
}

struct Parent: Codable {
    let children: [Child]
}

struct Child: Codable {
    let data: Listing
}

struct Listing: Codable, Identifiable {
    let preview: Preview?
    let id: String
    let title: String
    
    func getDisplayImage() -> String? {
        return nil
    }
}

struct Preview: Codable {
    let images: [RImage]
    let reddit_video_preview: RedditVideoPreview?
}

struct RImage: Codable {
    let source: FileMeta
    let variants: Formats
}

struct FileMeta: Codable {
    let url: String
    let width: Int
    let height: Int
}

struct Formats: Codable {
    let gif: ImageMeta?
    let mp4: ImageMeta?
}

struct ImageMeta: Codable {
    let source: FileMeta
    let resolutions: [FileMeta]
}

struct RedditVideoPreview: Codable {
    let is_gif: Bool
    let fallback_url: String
}
