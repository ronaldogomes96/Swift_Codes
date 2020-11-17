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

    let arkitModel = ArkitModel()

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
        materials.diffuse.contents = UIImage(named: "art.scnassets/moon.png")
        
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

        // Run the view's session
        sceneView.session.run(arkitModel.configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //Funcao que é chamada quando a tela é clicada
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Verificamos o primeiro toque, ja que é um array
        if let touch = touches.first {
            //Pegamos entao a localizacao desse touch, de acordo com a scene view
            let touchLocation = touch.location(in: sceneView)
            
            //Funcao do arkit que tenta pegar a posicao 3D
            let results = sceneView.raycastQuery(from: touchLocation, allowing: .existingPlaneGeometry, alignment: .horizontal)
            
            //Verificando se o resultado é valido
            if let hitResults = results {
                let diceNode = arkitModel.addDice(atLocation: hitResults)
                sceneView.scene.rootNode.addChildNode(diceNode!)
                arkitModel.roll(dice: diceNode!)
            }
        }
    }
    
    
    
    @IBAction func rollAgain(_ sender: UIBarButtonItem) {
        arkitModel.rollAll()
    }
    
    @IBAction func removeAllDice(_ sender: UIBarButtonItem) {
        arkitModel.removeAllDices()
    }
    //Acionado quando a tela é balancada
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        arkitModel.rollAll()
    }
    
    //É chamado todas as vezes em que for detectado um novo no plano na tela
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        
        let planeNode = arkitModel.createPlane(withPlaneAnchor: planeAnchor)
        
        node.addChildNode(planeNode)
    }
}
