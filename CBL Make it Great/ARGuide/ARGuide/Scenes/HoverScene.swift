//
//  HoverScene.swift
//  ARGuide
//
//  Created by Ronaldo Gomes on 11/11/20.
//

import Foundation
import ARKit

//Struct que inicia nossa cena
struct HoverScene {
    //Objeto de referencia da cena 3D
    var scene: SCNScene?
    
    init() {
        scene = self.initializeScene()
    }
    
    //Inicia o objeto de cena
    func initializeScene() -> SCNScene? {
        let scene = SCNScene()
        setDefaults(scene: scene)
        return scene
    }
    
    //Configuracoes padroes do scene
    func setDefaults(scene: SCNScene) {
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = SCNLight.LightType.ambient
        ambientLightNode.light?.color = UIColor(white: 0.6, alpha: 1.0)
        
        scene.rootNode.addChildNode(ambientLightNode)
        
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        let directionalNode = SCNNode()
        directionalNode.eulerAngles = SCNVector3Make(GLKMathDegreesToRadians(-130), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(35))
        directionalNode.light = directionalLight
        
        scene.rootNode.addChildNode(directionalNode)
    }
    
    //Recebe como parametro uma posicao para colocar nosso objeto no espaco 3D
    func addSphere(position: SCNVector3) {
        
        guard let scene = self.scene else { return }
        
        let containerNode = SCNNode()
        let nodesInFile = SCNNode.allNodes(from: "sphere.dae")
        
        nodesInFile.forEach { (node) in
            containerNode.addChildNode(node)
        }
        
        containerNode.position = position
        scene.rootNode.addChildNode(containerNode)
    }
}
