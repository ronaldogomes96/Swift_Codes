//
//  API.swift
//  NasaAPITests
//
//  Created by Ronaldo Gomes on 18/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation
import UIKit

class API {
    var listOfImages: [UIImage] = []
    var responseStruct: Response?
    
    
    func nasaApiCall( planetName: String, completion: @escaping ([UIImage]) -> ()) {
        
        listOfImages = []
        let requestURL = requestUrl(url: "https://images-api.nasa.gov/search?q=\(planetName)&media_type=image")
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data,response, error) in
            
            guard let data = data, error == nil else {
                fatalError("Erron in \(String(describing: error))")
            }
            
            do {
                
                self.responseStruct = try JSONDecoder().decode(Response.self, from: data)
                let group = DispatchGroup()
                
                for i in 0..<10 {
                    group.enter()
                    
                    self.fetchImage(url:
                    (self.responseStruct!.collection.items[i].links.first?.href)!) { image in
                        
                        self.listOfImages.append(image)
                        group.leave()
                    }
                }
                
                group.notify(queue: .global()) {
                    completion(self.listOfImages)
                }
                
            } catch {
                fatalError("Erron in \(String(describing: error))")
            }
        }
        task.resume()
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage) ->()) {
        
        let requestURL = requestUrl(url: url)
        
        let task = URLSession.shared.downloadTask(with: requestURL) { (Url, response, error) in
            guard let url = Url, error == nil else {
                fatalError("Erron in \(String(describing: error))")
            }
            
            do {
                let data = try Data(contentsOf: url)
                let imagePlanet = UIImage(data: data)
                completion(imagePlanet!)
            } catch {
                fatalError("Erron in \(String(describing: error))")
            }
        }
        task.resume()
        
    }
    
    func requestUrl (url: String) -> URL {
        let url = URL(string: url)
        guard let requestUrl = url else {fatalError()}
        return requestUrl
    }
}
