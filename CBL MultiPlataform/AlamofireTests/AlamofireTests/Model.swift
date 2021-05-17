//
//  Model.swift
//  AlamofireTests
//
//  Created by Ronaldo Gomes on 17/05/21.
//

import Foundation
import Alamofire

class Model {
    init() {
        AF.request("https://httpbin.org/get").response {
            print($0)
        }
        // POST
        AF.request("https://httpbin.org/post", method: .post)
        // PUT
        AF.request("https://httpbin.org/put", method: .put)
        // DELETE
        AF.request("https://httpbin.org/delete", method: .delete)
        
        
        // Requests com parametros
        let parameters = ["category": "Movies", "genre": "Action"]
        
        AF.request("https://httpbin.org/get", parameters: parameters).response { response in
            debugPrint(response)
        }
        //this is equivalent to https://httpbin.org/get?category=Movies&genre=Action
        
        // HTTP Headers
        let headers: HTTPHeaders = [
            .authorization(username: "test@email.com", password: "testpassword"),
            .accept("application/json")
        ]
        
        AF.request("https://httpbin.org/headers", headers: headers).responseJSON { response in
            debugPrint(response)
        }
                
        AF.request("https://httpbin.org/headers", parameters: parameters, headers: headers).responseJSON { response in
            debugPrint(response)
        }

        // Handling Authorization
        // Normal way to authenticate using the .authenticate with username and password
        let user = "test@email.com"
        let password = "testpassword"
        
        AF.request("https://httpbin.org/basic-auth/\(user)/\(password)")
            .authenticate(username: user, password: password)
            .responseJSON { response in
                debugPrint(response)
            }
        
        // Authentication using URLCredential
        
        let credential = URLCredential(user: user, password: password, persistence: .forSession)
        
        AF.request("https://httpbin.org/basic-auth/\(user)/\(password)")
            .authenticate(with: credential)
            .responseJSON { response in
                debugPrint(response)
            }
        
        // Response Handling
        
        // Basic response
        AF.request("https://httpbin.org/get").response { response in
            debugPrint("Response: \(response)")
        }
        
        // Json response
        AF.request("https://httpbin.org/get").responseJSON { response in
            debugPrint("Response: \(response)")
        }
        
        // Data response
        AF.request("https://httpbin.org/get").responseData { response in
            debugPrint("Response: \(response)")
        }
        
        // String response
        AF.request("https://httpbin.org/get").responseString { response in
            debugPrint("Response: \(response)")
        }
        
        // Decodable response
        struct HTTPBinResponse: Decodable { let url: String }

        AF.request("https://httpbin.org/get").responseDecodable(of: HTTPBinResponse.self) { response in
            debugPrint("Response: \(response)")
        }
        
        
        // File Download/Handling
        
        // Fetch in Memory
        AF.download("https://httpbin.org/image/png").responseData { response in
            if let data = response.value {
                //self.imageView.image = UIImage(data: data)
            }
        }
        
        // Download locally
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("image.png")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download("https://httpbin.org/image/png", to: destination).response { response in
            debugPrint(response)
            
            if response.error == nil, let imagePath = response.fileURL?.path {
                let image = UIImage(contentsOfFile: imagePath)
            }
        }
        
        // Uploading Data/Files
        let data = Data("data".utf8)

        AF.upload(data, to: "https://httpbin.org/post").responseJSON { response in
            debugPrint(response)
        }
        
        // Upload/Download Progress
        
        // For downloadProgress
        AF.download("https://httpbin.org/image/png", to: destination)
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .response { response in
                debugPrint(response)
                
                if response.error == nil, let imagePath = response.fileURL?.path {
                    let image = UIImage(contentsOfFile: imagePath)
                }
            }
        
        // For uploadProgress
        let fileURL = Bundle.main.url(forResource: "video", withExtension: "mp4")!
        
        AF.upload(fileURL, to: "https://httpbin.org/post")
            .uploadProgress { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }
            .responseJSON { response in
                debugPrint(response.response)
            }

    }
}
