//
//  ViewController.swift
//  BraveryOfQwanoesTests
//
//  Created by Ronaldo Gomes on 15/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func goGame(_ sender: UIButton) {
        let vc = GameViewController()
        // Gambiarra?
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

