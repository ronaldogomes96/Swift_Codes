//
//  ViewController.swift
//  CloudKitLogErros
//
//  Created by Ronaldo Gomes on 11/08/21.
//

import UIKit
import CloudKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }

    @IBAction func sendErroToCloudkit(_ sender: UIButton) {
        let record = CKRecord(recordType: "LogErros")
        
        record["Error"] = "Teste error"
        
        CKContainer.default().publicCloudDatabase.save(record) { [unowned self] record, error in
            guard let _ = record, error == nil else {
                fatalError()
            }
        }
    }
}

