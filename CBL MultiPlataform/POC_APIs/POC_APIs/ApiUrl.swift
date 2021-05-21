//
//  ApiUrl.swift
//  POC_APIs
//
//  Created by Ronaldo Gomes on 18/05/21.
//

import Foundation

enum ApiUrl: String {
    case pexelsImage = "https://api.pexels.com/v1/search"
    case pexelsVideo = "https://api.pexels.com/videos/search"
    case pixabayImage = "https://pixabay.com/api/"
    case pixabayVideo = "https://pixabay.com/api/videos/"
    case rijksmuseum = "https://www.rijksmuseum.nl/api/en/collection"
    case poetrydb = "https://poetrydb.org/random/4"
}

enum tokens: String {
    case pexels = "563492ad6f91700001000001d18b9d0dcabe44ffb5436ad57b3a52ee"
    case pixabay = "21586355-9a53b7219c21f55756e9566af"
    case rijksmuseum = "jCEuqrdy"
}
