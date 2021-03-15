//
//  GameViewController.swift
//  BraveryOfQwanoesTests
//
//  Created by Ronaldo Gomes on 15/03/21.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    //Cria uma SKView do tamanho da tela
    let skView: SKView = SKView(frame: UIScreen.main.bounds)
    
    // Carrega a skview na tela
    override func loadView() {
        super.loadView()
        self.view = skView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Instancia a scene e passa como presentScene da Skview
        let scene: SKScene = FirstScene()
        scene.scaleMode = .aspectFill
        self.skView.presentScene(scene)
    }
}
