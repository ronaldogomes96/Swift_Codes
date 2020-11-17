//
//  ArkitModel.swift
//  ARDicee
//
//  Created by Ronaldo Gomes on 17/11/20.
//

import Foundation
import ARKit

class ArkitModel {
    
    var diceNodesArray = [SCNNode]()
    
    // Cria a configuracao inicial da sessao, possibilitando a captura do mundo 3D
    let configuration = ARWorldTrackingConfiguration()
    
    init() {
        configuration.planeDetection = .horizontal
    }
    
    func addDice(atLocation location: ARRaycastQuery) -> SCNNode? {
        // Create a new scene
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        //Pega os nodes da arvore dessa scene
        guard let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) else {
            
            return nil
            
            
//                    //Para fazer a animacao, temos que pegar um numero aleatorio das posicoes de x e z
//                    let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
//                    let randomZ = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
//
//                    //Criar a animacao com uma funcao do sceneKit
//                    diceNode.runAction(
//                        SCNAction.rotateBy(
//                            x: CGFloat(randomX * 5),
//                            y: 0,
//                            z: CGFloat(randomZ * 5),
//                            duration: 0.5
//                        )
//                    )

        }
        //Podemos agora pegar a posicao real do touch
        diceNode.position = SCNVector3(
            location.direction.x,
            location.direction.y,
            location.direction.z
        )
        return diceNode
    }
    
    //Rola todos os dados
    func rollAll() {
        if !diceNodesArray.isEmpty {
            for dice in diceNodesArray {
                roll(dice: dice)
            }
        }
    }
    
    //Rola um dado node especifico
    func roll(dice: SCNNode) {
        
        //Para fazer a animacao, temos que pegar um numero aleatorio das posicoes de x e z
        let randomX = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
        let randomZ = Float(arc4random_uniform(4) + 1) * (Float.pi/2)
        
        //Criar a animacao com uma funcao do sceneKit
        dice.runAction(
            SCNAction.rotateBy(
                x: CGFloat(randomX * 5),
                y: 0,
                z: CGFloat(randomZ * 5),
                duration: 0.5
            )
        )
    }
    
    func removeAllDices() {
        if !diceNodesArray.isEmpty {
            for dice in diceNodesArray {
                dice.removeFromParentNode()
            }
        }
    }
    
    func createPlane(withPlaneAnchor planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        //Pega o plano de acordo com as coordenadas do anchor
        let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        //Criar o node  que ira ser o plano
        let planeNode = SCNNode()
        
        //definindo sua posicao de acordo com o anchor
        planeNode.position = SCNVector3(CGFloat(planeAnchor.center.x), 0, CGFloat(planeAnchor.center.z))
        //Temos que transforma-lo para se comportar da forma correta no plano
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
        
        //Personalizando o node
        let gridMaterial = SCNMaterial()
        
        gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
        
        plane.materials = [gridMaterial]
        
        planeNode.geometry = plane
        
        return planeNode
        
    }
}
