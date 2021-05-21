//
//  Model.swift
//  POC_APIs
//
//  Created by Ronaldo Gomes on 18/05/21.
//

import SwiftUI
import Alamofire

class Model: ObservableObject {
    
    @Published var data = [Data]()
    
    var headers: HTTPHeaders
    
    var responseStruct: PexelsModel!
    
    var arrayResponseStruct: [PexelsModel]!
    
    var url: ApiUrl
        
    var parameters = [String: String]()
    
    init(url: ApiUrl, token: tokens) {
        headers = [.authorization(bearerToken: token.rawValue)]
        self.url = url
        parameters = ["query": "food"]
        if self.url == .pixabayImage || self.url == .pixabayVideo {
            parameters["key"] = token.rawValue
            headers = []
        }
        
        if self.url == .rijksmuseum {
            parameters["key"] = token.rawValue
            parameters["technique"] = "painting"
            parameters["p"] = "\(Int.random(in: 1..<1000))"
            headers = []
        }
        
        if self.url == .poetrydb {
            parameters = [:]
            headers = []
        }
    }
    
    func getImageUrl() {
        if self.url == .poetrydb {
            AF.request(url.rawValue).responseDecodable(of: [PexelsModel].self) { response in
                self.arrayResponseStruct = try! JSONDecoder().decode([PexelsModel].self, from: response.data!)
                for i in self.arrayResponseStruct {
                    self.data.append(i.lines!.reduce("", { $0 + "\n" + $1 }).data(using: .utf8)!)
                }
            }
        } else {
            AF.request(url.rawValue, parameters: parameters, headers: headers).responseDecodable(of: PexelsModel.self) { response in
                self.responseStruct = try! JSONDecoder().decode(PexelsModel.self, from: response.data!)
                
                switch self.url {
                case .pexelsImage:
                    for i in self.responseStruct.photos! {
                        AF.download(i.src.original).responseData {
                            self.data.append($0.value!)
                            self.objectWillChange.send()
                        }
                    }
                case .pexelsVideo:
                    for i in self.responseStruct.videos! {
                        self.data.append((i.video_files?.first?.link.data(using: .utf8)!)!)
                        self.objectWillChange.send()
                    }
                    
                case .pixabayImage:
                    for i in self.responseStruct.hits! {
                        AF.download(i.largeImageURL!).responseData {
                            self.data.append($0.value!)
                            self.objectWillChange.send()
                        }
                    }
                case .pixabayVideo:
                    for i in self.responseStruct.hits! {
                        self.data.append((i.videos!.medium?.url.data(using: .utf8)!)!)
                        self.objectWillChange.send()
                    }
                    
                case .rijksmuseum:
                    for i in self.responseStruct.artObjects! {
                        AF.download(i.webImage.url).responseData {
                            self.data.append($0.value!)
                            self.objectWillChange.send()
                        }
                    }
                
                case .poetrydb:
                    break
                }
                
            }
        }

    }
}

