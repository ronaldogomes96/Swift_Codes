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
        numberOfMediaWordLearned.text = "\(Report.mediaOfWordsInWeek())"
        let rank = Report.getMostSearchWords()
        rankOfWords.text = "\(String(describing: rank![0]))\n\(String(describing: rank![1]))\n\(String(describing: rank![2]))\n"
        var words = ""
        for i in 1...7 {
            words += "\(String(describing: Report.getWordsADay()![i]!))\n"
        }
        wordsADay.text = words

        // Do any additional setup after loading the view.
    }

    

}
