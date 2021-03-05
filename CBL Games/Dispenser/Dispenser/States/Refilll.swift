//
//  Refilll.swift
//  Dispenser
//
//  Created by Ronaldo Gomes on 05/03/21.
//

import Foundation
import GameplayKit

class Refill: GKState {
    
    override func didEnter(from previousState: GKState?) {
        ViewController.level = 2
        print("Enchendo...")
    }
}
