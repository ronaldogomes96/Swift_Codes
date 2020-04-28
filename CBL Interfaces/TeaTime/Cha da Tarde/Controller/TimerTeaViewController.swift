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
    
    /*
        Testes das funcoes de UIViewController
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //So aparece uma vez a cada carregamento da tela
        print("View Did Load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Aparece antes de cada exibicao da tela
        print("View will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Aparece depois que a funcao apareceu na tela
        print("View did appear")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //Aparece antes da nova tela aparecer, porem depois dela ser carregada
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        //Aparece depois que ela desaparece
        print("view will disappear")
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
