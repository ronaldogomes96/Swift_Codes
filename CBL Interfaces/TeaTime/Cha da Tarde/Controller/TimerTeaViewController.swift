//
//  TimerTeaViewController.swift
//  Cha da Tarde
//
//  Created by Ronaldo Gomes on 21/04/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class TimerTeaViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer(){
        seconds -= 1
        timerLabel.text = "\(seconds)"
    }
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        runTimer()
    }
    
    
    @IBAction func pauseButtonTaped(_ sender: UIButton) {
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
    }
    
    
    
}
