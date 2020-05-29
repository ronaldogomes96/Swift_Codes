//
//  ViewController.swift
//  WeatherData
//
//  Created by Ronaldo Gomes on 29/05/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Pega a url
        let url = URL(string: "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02")
        
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error!)
            } else {
                if let urlContent = data {
                    do{
                        //Transforma em um json
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: .mutableContainers) as AnyObject
                        print(jsonResult)
                        print(jsonResult["name"]!!)
                    }
                    catch{
                        print("json error")
                    }
                }
            }
        }
        task.resume()
    }


}

