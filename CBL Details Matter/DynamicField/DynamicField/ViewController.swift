//
//  ViewController.swift
//  DynamicField
//
//  Created by Ronaldo Gomes on 12/09/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //O cirulo que ira se movimentar
    @IBOutlet weak var orbitingView: UIView! {
        willSet {
            newValue.layer.cornerRadius = newValue.frame.width/2.0
            newValue.layer.backgroundColor = UIColor.blue.cgColor
        }
    }
    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.view)
    }()
    
    //Centro da tela
    lazy var center: CGPoint = {
        return CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
    }()
    

    //Field Behavior
    lazy var radialGravity: UIFieldBehavior = {
        
        //cria um comportamento dinâmico que modela uma força gravitacional radial, definindo a forma do campo. A força da gravidade é centralizada na visualização do controlador de visualização
        let radialGravity: UIFieldBehavior = UIFieldBehavior.radialGravityField(position: self.center)
        
        //define que o campo exerce uma força sobre os itens que estão dentro de uma região composta por um círculo com raio de 300 pontos.
        radialGravity.region = UIRegion(radius: 300.0)
        
        //define a força do campo. O valor padrão para esta propriedade é 1,0, mas eu o defino como 1,5, porque parece um bom número para o que estou tentando realizar (estou seguindo a sugestão fornecida na documentação)
        radialGravity.strength = 1.5
        
        //define a rapidez com que a intensidade do campo diminui à medida que a distância do centro do campo aumenta. O valor padrão para esta propriedade é zero, o que produz um campo uniforme que não diminui com a distância. Defino essa propriedade como 4
        radialGravity.falloff = 4.0
        
        // define a distância mínima na qual começar a calcular novos valores para o campo. Defino essa propriedade para 50.
        radialGravity.minimumRadius = 50.0 // 5
        return radialGravity
    }()
    
    
    //Criacao da curvatura
    lazy var vortex: UIFieldBehavior = {
        
        //cria o comportamento dinâmico que modela uma força de vórtice.
        let vortex: UIFieldBehavior = UIFieldBehavior.vortexField()
        
        //define a posição do campo de vórtice, centralizando a posição dos campos no controlador de visualização.
        vortex.position = self.center
        
        //configura a região definindo a área de influência com raio de círculo de 200 pontos.
        vortex.region = UIRegion(radius: 200.0)
        
        //define a força do campo. Defino para 0,005.
        vortex.strength = 0.005 // 9
        return vortex
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
         
        //crio um objeto UIDynamicItemBehavior para alterar a densidade do item dinâmico (orbitingView).
        let itemBehavior = UIDynamicItemBehavior(items: [orbitingView])
        itemBehavior.density = 0.5
        animator.addBehavior(itemBehavior)
         
        //Criando o comportamento de campo
        vortex.addItem(orbitingView)
        radialGravity.addItem(orbitingView)
         
        animator.addBehavior(radialGravity) // 16
        animator.addBehavior(vortex) // 17
    }

}

