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
    var imageList: [UIImage]?
    let api = API()
    
    
    @IBOutlet weak var imagePlanet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButton(_ sender: UIButton) {
        api.nasaApiCall(planetName: userPlanet.text!) { image in
            DispatchQueue.main.async {
                
                self.imageList = image
                self.imagePlanet.image = self.imageList![7]
            }
        }
        
        
    }
    
    
}

