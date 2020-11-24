//
//  Scene.swift
//  LetrandoTests
//
//  Created by Ronaldo Gomes on 19/11/20.
//

import Foundation
import ARKit

class Scene {
    
//    //Objeto de referencia da cena 3D
//    var scene: SCNScene?
//    
//    init() {
//        scene = self.initializeScene()
//    }
//    
//    //Inicia o objeto de cena
//    func initializeScene() -> SCNScene? {
//        let scene = SCNScene()
//        setDefaults(scene: scene)
//        return scene
//    }
//    
//    //Configuracoes padroes do scene
//    func setDefaults(scene: SCNScene) {
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light?.type = SCNLight.LightType.ambient
//        ambientLightNode.light?.color = UIColor(white: 0.6, alpha: 1.0)
//        
//        scene.rootNode.addChildNode(ambientLightNode)
//        
//        let directionalLight = SCNLight()
//        directionalLight.type = .directional
//        let directionalNode = SCNNode()
//        directionalNode.eulerAngles = SCNVector3Make(GLKMathDegreesToRadians(-130), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(35))
//        directionalNode.light = directionalLight
//        
//        scene.rootNode.addChildNode(directionalNode)
//    }
    
    //Recebe como parametro uma posicao para colocar nosso objeto no espaco 3D
    func addSphere(position: SCNVector3) -> SCNNode {
        
        //1. Create An SCNNode With An SCNSphere Geometry
        let nodeOneGeometry = SCNSphere(radius: 0.2)

        //2. Set It's Colour To Cyan
        nodeOneGeometry.firstMaterial?.diffuse.contents = UIColor.cyan

        //3. Assign The Geometry To The Node
        let scene = SCNNode(geometry: nodeOneGeometry)

        //4. Assign A Name For Our Node
        scene.name = "Node One"

        //5. Position It & Add It To Our ARSCNView
        scene.position = position
        
        return scene
        //scene.rootNode.addChildNode(nodeOne)
    }
}
