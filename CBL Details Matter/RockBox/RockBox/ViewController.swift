//
//  ViewController.swift
//  RockBox
//
//  Created by Ronaldo Gomes on 12/09/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Criando a caixa
    var box: UIView?
    
    //Animacao
    var animator: UIDynamicAnimator?
    
    //Comportamento da gravidade
    var gravity = UIGravityBehavior()
    
    let collider = UICollisionBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addBox(location: CGRect(x: 100, y: 100, width: 30, height: 30))
        createAnimatorStuff()
    }


    //Funcao que cria a box em algum ponto da view
    func addBox(location: CGRect) {
        let newBox = UIView(frame: location)
        newBox.backgroundColor = .red
        view.insertSubview(newBox, at: 0)
        box = newBox
    }

    // Cria a animacao da box com gravidade
    func createAnimatorStuff() {
        //Cria o animator e referencia na view
        animator = UIDynamicAnimator(referenceView: view)
        
        //Cria o movimento da gravidade na box
        gravity.addItem(box!)
        gravity.gravityDirection = .init(dx: 0, dy: 0.8)
        animator?.addBehavior(gravity)
        
        //Cria o comportamento de colisao
        collider.addItem(box!)
        collider.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collider)
    }
}

