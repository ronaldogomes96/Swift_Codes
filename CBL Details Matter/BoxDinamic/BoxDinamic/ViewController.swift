//
//  ViewController.swift
//  BoxDinamic
//
//  Created by Ronaldo Gomes on 09/09/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollisionBehaviorDelegate {

    // Já é um UIDynamicItem
    @IBOutlet weak var box: UIImageView!
    
    // Caixa oara troca de ancoragem
    @IBOutlet weak var houseBox: UIView!
    
    //View que serve como bola que movimenta
    @IBOutlet weak var ball: UIView!
    
    // O comportamento para ser associado ao item
    var snapBehavior: UISnapBehavior!
    
    // O objeto animador
    var dynamicAnimator: UIDynamicAnimator!
    
    //Variavel de colisao
    var collider: UICollisionBehavior!
    
    //As bordas da colisao
    var colliderBounds: UICollisionBehavior!
    
    //Comportamento da bola
    var ballBehavior: UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Configurando cor e tamanho da housebox
        houseBox.layer.borderWidth = 5
        houseBox.layer.borderColor = UIColor.gray.cgColor
        
        // Desativa a interacao com toques do usuario na houseBox
        houseBox.isUserInteractionEnabled = false
        
        //tornando view da ball circular
        ball.clipsToBounds = true
        ball.layer.cornerRadius = ball.frame.height / 2
        
        // Faz a view como base da dynamic animator
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        //Cria um corpotamento da imagem, centralizando
        snapBehavior = UISnapBehavior(item: box, snapTo: view.center)
        //Adiciona esse comportamento
        dynamicAnimator.addBehavior(snapBehavior)
        
        //Cria o pan gesture para movimentar a box
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pannedView))
        //Adiciona esse gesture
        box.addGestureRecognizer(panGesture)
        //Permite o usuario movimentar a imagem
        box.isUserInteractionEnabled = true
        
        //Elasticidade a bola
        ballBehavior = UIDynamicItemBehavior(items: [ball])
        ballBehavior.elasticity = 0.6
        dynamicAnimator.addBehavior(ballBehavior)
        
        //Colisao entre a ball e os limites das Views na tela
        colliderBounds = UICollisionBehavior(items: [ball])
        colliderBounds.collisionMode = .boundaries
        colliderBounds.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(colliderBounds)
        
        //Colisao entre a ball e a box
        collider = UICollisionBehavior(items: [ball, box])
        collider.collisionDelegate = self
        collider.collisionMode = .items
        collider.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collider)
    }

    //Funcao que realiza a acao executada pelo PanGesture
    @objc func pannedView(recognizer: UIPanGestureRecognizer){
        
        //Possiveis acoes
        switch recognizer.state {
        //Inicio
        case .began:
            
            //Tira o colisor inicial
            dynamicAnimator.removeBehavior(collider)
            //Tira o comportamento que centraliza a imagem
            dynamicAnimator.removeBehavior(snapBehavior)
        
        //Mudando
        case .changed:
            
            //Faz toda a translacao da imagem
            let translation = recognizer.translation(in: view)
            box.center = CGPoint(x: box.center.x + translation.x,
                                      y: box.center.y + translation.y)
            recognizer.setTranslation(.zero, in: view)
            
            //Chama a funcao que checa se a box esta dentro ou nao da caixa view
            checkIntersectionWith(boxView: houseBox)
            
        //Fim
        case .ended, .cancelled, .failed:
            //Retorna com o comportamento padrao
            dynamicAnimator.addBehavior(collider)
            //Volta para a posicao inicial com o comportamento
            dynamicAnimator.addBehavior(snapBehavior)
            
        case .possible:
            break
        @unknown default:
            fatalError()
        }
        
    }
    
    //Além de checar intercessao, a funcao adiciona animacao no translado da smileBox
    func checkIntersectionWith(boxView: UIView) {
        
        //Box esta dentro da view
        if boxView.frame.contains(box.center) {

            //Centraliza a box dentro da view
            snapBehavior.snapPoint = box.center
            let center = box.center
            //Faz a animacao de colocar dentro da view em 0.5segundos
            UIView.animate(withDuration: 0.5) {
                self.box.frame.size = boxView.frame.size
                self.box.center = center
            }

        }
        //Box nao esta dentro da view
        else {
            
            //Centraliza a box na view normal
            snapBehavior.snapPoint = view.center
            UIView.animate(withDuration: 0.5) {
                self.box.frame.size = CGSize(width: 100, height: 100)
            }
        }
    }
}

