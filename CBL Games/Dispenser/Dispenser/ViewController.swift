//
//  ViewController.swift
//  Dispenser
//
//  Created by Ronaldo Gomes on 05/03/21.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var ServeButton: UIButton!
    @IBOutlet weak var RefillButton: UIButton!
    static var level: Int = 1
    var machine: GKStateMachine!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        machine = GKStateMachine(states: [
            Full(),
            Empty(),
            PartiallyFull(),
            Serve(),
            Refill()
        ])
        machine.enter(PartiallyFull.self)
    }

    @IBAction func serveAction(_ sender: UIButton) {
        switch ViewController.level {
        case 0:
            machine.enter(Empty.self)
        case 1:
            machine.enter(PartiallyFull.self)
            machine.enter(Serve.self)
        case 2:
            machine.enter(Full.self)
            machine.enter(Serve.self)
        default:
            fatalError()
        }
    }

    @IBAction func refillAction(_ sender: UIButton) {
        switch ViewController.level {
        case 0:
            machine.enter(Empty.self)
            machine.enter(Refill.self)
        case 1:
            machine.enter(PartiallyFull.self)
            machine.enter(Refill.self)
        case 2:
            machine.enter(Full.self)
        default:
            fatalError()
        }
    }
}

