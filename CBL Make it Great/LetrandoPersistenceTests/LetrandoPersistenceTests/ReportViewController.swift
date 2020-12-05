//
//  ReportViewController.swift
//  LetrandoPersistenceTests
//
//  Created by Ronaldo Gomes on 05/12/20.
//

import UIKit

class ReportViewController: UIViewController {

    
    @IBOutlet weak var numberOfWordLearned: UILabel!
    
    @IBOutlet weak var numberOfMediaWordLearned: UILabel!
    
    @IBOutlet weak var rankOfWords: UILabel!
    
    @IBOutlet weak var wordsADay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfWordLearned.text = "\(Report.numberOfLearnedWords())"

        // Do any additional setup after loading the view.
    }

    

}
