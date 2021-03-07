//
//  GameScene.swift
//  Project11
//
//  Created by Ronaldo Gomes on 06/03/21.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!

    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editLabel: SKLabelNode!

    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    //Equivale ao didLoad
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
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
        
        //Configuracao da label de score
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        //Label do edit
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
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

            let objects = nodes(at: location)

            if objects.contains(editLabel) {
                editingMode.toggle()
            } else {
                if editingMode {
                    // create a box
                    let size = CGSize(width: Int.random(in: 16...128), height: 16)
                    let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                    box.zRotation = CGFloat.random(in: 0...3)
                    box.position = location

                    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                    box.physicsBody?.isDynamic = false

                    addChild(box)
                } else {
                    // create a ball
                    let ball = SKSpriteNode(imageNamed: "ballRed")
                    //Adicionando uma fisica
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                    ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                    ball.physicsBody?.restitution = 0.4
                    ball.position = location
                    //Adicionando um nome para melhor compreensao da variavel
                    ball.name = "ball"
                    addChild(ball)
                }
            }
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
            //Adicionando um nome para melhor compreensao da variavel
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            //Adicionando um nome para melhor compreensao da variavel
            slotBase.name = "bad"
        }
        
        //Adicionamos a posicao de ambos
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        //Entao adicionamos uma action para girar eternamente o circulo
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    //Chamado quando a bola bate em alguma coisa
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball)
            score += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        }
    }

    //Entao destroi o bola
    func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        
        ball.removeFromParent()
    }
    
    //É chamada quando balls se chocam
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
}
