//
//  RecentMediaResponse.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 28/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

struct RecentMedia: Codable {
    var data: [Item]
}

struct Item: Codable {
    let likes: Likes
    let images: Images
    let type: ItemType
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case likes
        case images, type
        case id
    }
}

enum ItemType: String, Codable {
    case image = "image"
    case video = "video"
}

struct Likes: Codable {
    let count: Int
}

struct Images: Codable {
    let lowResolution, thumbnail, standardResolution: ImageInfo
    
    enum CodingKeys: String, CodingKey {
        case lowResolution = "low_resolution"
        case thumbnail
        case standardResolution = "standard_resolution"
    }
}

struct ImageInfo: Codable {
    let url: String
    let width, height: Int
}
