//
//  FirstScee.swift
//  BraveryOfQwanoesTests
//
//  Created by Ronaldo Gomes on 15/03/21.
//

import Foundation
import SpriteKit

class FirstScene: SKScene {
    
    // Preferir usar este ao inves do sceneDidLoad
    override func didMove(to view: SKView) {
        self.backgroundColor = .purple
    }
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        self.backgroundColor = .blue
    }
}
