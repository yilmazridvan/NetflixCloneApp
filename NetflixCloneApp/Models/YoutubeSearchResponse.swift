//
//  YoutubeSearchResponse.swift
//  NetflixCloneApp
//
//  Created by Rıdvan Yılmaz on 14.11.2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
