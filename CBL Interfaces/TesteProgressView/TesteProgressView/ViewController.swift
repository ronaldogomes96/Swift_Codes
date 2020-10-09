//
//  ViewController.swift
//  TesteProgressView
//
//  Created by Ronaldo Gomes on 18/09/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var progressOne: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 1.0
        progress.progressTintColor = .red
        //progress.center = self.view.center
        progress.frame = CGRect(x: 100,y: 100,width: 100,height: 20)
        progress.transform = progress.transform.scaledBy(x: 1, y: 10)
        progress.translatesAutoresizingMaskIntoConstraints = false

        return progress
    }()
    
    var progressTwo: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 0.6
        progress.progressTintColor = .blue
        //progress.center = self.view.center
        progress.frame = CGRect(x: 100,y: 100,width: 100,height: 20)
        progress.transform = progress.transform.scaledBy(x: 1, y: 10)
        progress.translatesAutoresizingMaskIntoConstraints = false

        return progress
    }()
    
    var progressTree: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 0.25
        progress.progressTintColor = .black
        //progress.center = self.view.center
        progress.frame = CGRect(x: 100,y: 100,width: 100,height: 20)
        progress.transform = progress.transform.scaledBy(x: 1, y: 10)
        progress.translatesAutoresizingMaskIntoConstraints = false

        return progress
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(progressOne)
        self.view.addSubview(progressTwo)
        self.view.addSubview(progressTree)
        // Do any additional setup after loading the view.
    }


}

