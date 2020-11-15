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
        
        // Create a new scene
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        //Pega os nodes da arvore dessa scene
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
            
            diceNode.position = SCNVector3(0, 0, -0.1)
            sceneView.scene.rootNode.addChildNode(diceNode)
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Cria a configuracao inicial da sessao, possibilitando a captura do mundo 3D
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
}
