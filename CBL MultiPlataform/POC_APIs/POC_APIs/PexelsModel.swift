//
//  PexelsModel.swift
//  POC_APIs
//
//  Created by Ronaldo Gomes on 18/05/21.
//

import Foundation

struct PexelsModel: Codable{
    let photos: [Photos]?
    let videos: [Videos]?
    let hits: [Hit]?
    let artObjects: [ArtObject]?
    let lines: [String]?
}

struct Photos: Codable {
    let src: SRC
}

struct Videos: Codable {
    let video_files: [VideosFiles]?
    let medium: Medium?
}

struct ArtObject: Codable {
    let webImage: Picture
}

struct Medium: Codable {
    let url: String
}

struct VideosFiles: Codable {
    let link: String
}

struct SRC: Codable {
    let original: String
}

struct Hit: Codable {
    let largeImageURL: String?
    let videos: Videos?
}

struct Picture: Codable {
    let url: String
}
