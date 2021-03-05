//
//  Empty.swift
//  Dispenser
//
//  Created by Ronaldo Gomes on 05/03/21.
//

import Foundation
import GameplayKit

class Empty: GKState {
    
    override func didEnter(from previousState: GKState?) {
        print("Tanque vazio")
    }
}
