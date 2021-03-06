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
        makeSlot(at: CGPoint(x: 128, y: 300), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 300), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 300), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 300), isGood: false)
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
    
    //Faz e adiciona os possiveis slots, bons e ruins
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        //Sao dois slots diferentes, para fazer um efeito de circulo com lamina
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
        }
        
        //Adicionamos a posicao de ambos
        slotBase.position = position
        slotGlow.position = position
        
        addChild(slotBase)
        addChild(slotGlow)
        
        //Entao adicionamos uma action para girar eternamente o circulo
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
}
