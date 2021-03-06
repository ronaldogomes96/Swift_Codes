//
//  GameScene.swift
//  Project11
//
//  Created by Ronaldo Gomes on 06/03/21.
//

import SpriteKit

class GameScene: SKScene {
    
    //Equivale ao didLoad
    override func didMove(to view: SKView) {
        
        //Imagem de background
        let background = SKSpriteNode(imageNamed: "background.jpg")
        
        /*
         ao contrário do UIKit, o SpriteKit posiciona as coisas com base em seu centro - ou seja, o ponto 0,0
         se refere ao centro horizontal e vertical de um nó. E também ao contrário do UIKit, o eixo Y do
         SpriteKit começa na borda inferior, então um número Y mais alto coloca um nó mais alto na tela.
         */
        background.position = CGPoint(x: 512, y: 450)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        //Adicionando uma fisica para a tela inteira
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        
        makeBouncer(at: CGPoint(x: 0, y: 300))
        makeBouncer(at: CGPoint(x: 256, y: 300))
        makeBouncer(at: CGPoint(x: 512, y: 300))
        makeBouncer(at: CGPoint(x: 768, y: 300))
        makeBouncer(at: CGPoint(x: 1024, y: 300))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            //Adicionando um spriteKitNode, com formato de bola
            let ball = SKSpriteNode(imageNamed: "ballRed")
            //Adicionando uma fisica
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
            ball.physicsBody?.restitution = 0.4
            ball.position = location
            addChild(ball)
        }
    }
    
    //Cria uma bola estatica e adiciona na tela
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
}
