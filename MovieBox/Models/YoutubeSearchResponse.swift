//
//  YoutubeSearchResponse.swift
//  MovieBox
//
//  Created by Aslıhan Gürkan on 8.04.2023.
//

import Foundation

struct YoutubeSearchResponse : Codable {
    let items : [VideoItem]
}

struct VideoItem : Codable {
    let kind : String
    let etag : String
    let id : VideoIdItem
}

struct VideoIdItem : Codable {
    let kind : String
    let videoId : String
}
