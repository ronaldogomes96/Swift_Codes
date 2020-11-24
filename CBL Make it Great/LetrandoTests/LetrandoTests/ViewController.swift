//
//  ViewController.swift
//  LetrandoTests
//
//  Created by Ronaldo Gomes on 19/11/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    private let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Ao aparecer a tela, a secao do arkit sera iniciada, com a configuration pre determinada
        configuration.planeDetection = [.horizontal]
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Quando a tela desaparece, a secao do arkit sera pausada
        sceneView.session.pause()
    }
    
    //É chamado todas as vezes em que for detectado um novo no plano na tela
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        let planeNode = createPlane(withPlaneAnchor: planeAnchor)
        node.addChildNode(planeNode)
    }
    
    func createPlane(withPlaneAnchor planeAnchor: ARPlaneAnchor) -> SCNNode {
        //Criar o node  que ira ser o plano
        let planeNode = SCNNode()
    
        //definindo sua posicao de acordo com o anchor
        planeNode.position = SCNVector3(CGFloat(planeAnchor.center.x), 0, CGFloat(planeAnchor.center.z))
        //Temos que transforma-lo para se comportar da forma correta no plano
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
    
        planeNode.addChildNode(addLetter(planeAnchor: planeAnchor))

        return planeNode
    }

    //Recebe como parametro uma posicao para colocar nosso objeto no espaco 3D
    func addLetter(planeAnchor: ARPlaneAnchor) -> SCNNode {
        
        let nodeOneGeometry = SCNText(string: "A", extrusionDepth: 0.5)
        nodeOneGeometry.firstMaterial?.diffuse.contents = UIColor.cyan

        let newNode = SCNNode(geometry: nodeOneGeometry)
        newNode.name = "A"
        newNode.position = SCNVector3(CGFloat(planeAnchor.center.x), 0, CGFloat(planeAnchor.center.z))
        newNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, -1, 0, 0)
        return newNode
    }
}
