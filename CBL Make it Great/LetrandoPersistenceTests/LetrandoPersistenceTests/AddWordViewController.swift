//
//  AddWordViewController.swift
//  LetrandoPersistenceTests
//
//  Created by Ronaldo Gomes on 04/12/20.
//

import UIKit

class AddWordViewController: UIViewController {

    
    @IBOutlet weak var wordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func okButton(_ sender: UIButton) {
        Report.createReport(word: wordField.text ?? "")
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
}
