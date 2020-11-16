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

    var diceNodesArray = [SCNNode]()

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
    
    //Funcao que é chamada quando a tela é clicada
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Verificamos o primeiro toque, ja que é um array
        if let touch = touches.first {
            //Pegamos entao a localizacao desse touch, de acordo com a scene view
            let touchLocation = touch.location(in: sceneView)
            
            //Funcao do arkit que tenta pegar a posicao 3D
            let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
            
            //Verificando se o resultado é valido
            if let hitResults = results.first {
                
                // Create a new scene
                let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
                //Pega os nodes da arvore dessa scene
                if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
                    
                    //Podemos agora pegar a posicao real do touch
                    diceNode.position = SCNVector3(
                        hitResults.worldTransform.columns.3.x,
                        hitResults.worldTransform.columns.3.y,
                        hitResults.worldTransform.columns.3.z
                    )
                    sceneView.scene.rootNode.addChildNode(diceNode)
                    
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
                    
                    roll(dice: diceNode)
                }
            }
        }
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
    
    @IBAction func rollAgain(_ sender: UIBarButtonItem) {
        rollAll()
    }
    
    //Acionado quando a tela é balancada
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollAll()
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
