//
//  ViewController.swift
//  ARDicee
//
//  Created by Ronaldo Gomes on 14/11/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        /*
        //Cria um box, que nao vai ser um cubo perfeito
        //Parametro chamferReadius é o arredondamento
        //let cube = SCNBox(width: 0.2, height: 0.15, length: 0.25, chamferRadius: 0.1)
        
        let sphere = SCNSphere(radius: 0.4)
        
        //Podemos personalizar os elementos com materials
        let materials = SCNMaterial()
        materials.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
        
        //Entao adicionamos ao cube como array pois pode receber mais de um
        //cube.materials = [materials]
        sphere.materials = [materials]
        
        //É a estrutura de algum elemento
        let node = SCNNode()
        //Posicao 3D na tela
        node.position = SCNVector3(0, 0.1, -0.5)
        //Objeto a ser fixado
        //node.geometry = cube
        node.geometry = sphere
        
        sceneView.scene.rootNode.addChildNode(node)
        */
        
        //Ajuste das luzes do ambiente para uma melhor experiencia
        sceneView.autoenablesDefaultLighting = true
        
//        // Create a new scene
//        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
//        //Pega os nodes da arvore dessa scene
//        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
//
//            diceNode.position = SCNVector3(0, 0, -0.1)
//            sceneView.scene.rootNode.addChildNode(diceNode)
//        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Cria a configuracao inicial da sessao, possibilitando a captura do mundo 3D
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //É chamado todas as vezes em que for detectado um novo no plano na tela
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        //Verifica se a ancora recebida pode ser do tipo ARPlaneAnchor
        if anchor is ARPlaneAnchor {
            
            let planeAnchor = anchor as! ARPlaneAnchor
            
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
            
            node.addChildNode(planeNode)
        }
    }
}
