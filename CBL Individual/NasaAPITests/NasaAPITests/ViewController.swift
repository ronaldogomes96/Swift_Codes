//
//  ViewController.swift
//  NasaAPITests
//
//  Created by Ronaldo Gomes on 13/08/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userPlanet: UITextField!
    
    
    @IBOutlet weak var imagePlanet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButton(_ sender: UIButton) {
        api(planetName: userPlanet.text!) { response in
            self.fetchImage(url: (response.collection.items.first?.links.first?.href)!) { (image) in
                DispatchQueue.main.async {
                    self.imagePlanet.image = image
                }
                
            }
        }
    }
    
    func fetchImage(url: String, completion: @escaping (UIImage) ->()) {
        
        let url = URL(string: url)
        guard let requestUrl = url else {fatalError()}
        
        let task = URLSession.shared.downloadTask(with: requestUrl) { (Url, response, error) in
            guard let url = Url, error == nil else {
                print("Houve um erro em \(String(describing: error))")
                return
            }
            
            let data = try! Data(contentsOf: url)
            
            let imagePlanet = UIImage(data: data)
            completion(imagePlanet!)
            
        }
        task.resume()
        
    }
    
    func api( planetName: String, completion: @escaping (Response) -> ()) {
        
        let url = URL(string: "https://images-api.nasa.gov/search?q=\(planetName)&media_type=image")
        guard let requestUrl = url else { fatalError() }
        
        let task = URLSession.shared.dataTask(with: requestUrl) { (data,response, error) in
            
            guard let data = data, error == nil else {
                print("Houve um erro em \(String(describing: error))")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(response)
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
}

