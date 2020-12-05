//
//  ViewController.swift
//  LetrandoTests
//
//  Created by Ronaldo Gomes on 19/11/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    private let configuration = ARWorldTrackingConfiguration()
    
    var sceneNode = SCNNode()
    
    override func viewDidLoad() {
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        createPanGestureRecognize()
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
        sceneNode = createPlane(withPlaneAnchor: planeAnchor)
        node.addChildNode(sceneNode)
    }
    
    func createPlane(withPlaneAnchor planeAnchor: ARPlaneAnchor) -> SCNNode {
        //Criar o node  que ira ser o plano
        let planeNode = SCNNode()
    
        //definindo sua posicao de acordo com o anchor
        planeNode.position = SCNVector3(CGFloat(planeAnchor.center.x), 0, CGFloat(planeAnchor.center.z))
        //Temos que transforma-lo para se comportar da forma correta no plano
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
    
        planeNode.addChildNode(addLetter(planeNode: planeNode))

        return planeNode
    }

    //Recebe como parametro uma posicao para colocar nosso objeto no espaco 3D
    func addLetter(planeNode: SCNNode) -> SCNNode {
        
        let nodeOneGeometry = SCNText(string: "A", extrusionDepth: 0.5)
        nodeOneGeometry.firstMaterial?.diffuse.contents = UIColor.cyan

        let newNode = SCNNode(geometry: nodeOneGeometry)
        newNode.name = "A"
        newNode.position = SCNVector3(planeNode.worldPosition.x, 0, planeNode.worldPosition.z)
        newNode.transform = SCNMatrix4MakeRotation(Float.pi/2, 0, 0, 0)
        return newNode
    }
    
    func createPanGestureRecognize() {
        let panGesture = UIPanGestureRecognizer(target: self, action:  #selector(didPan(_:)))
        panGesture.delegate = self
        sceneView.addGestureRecognizer(panGesture)
    }
    
    @objc
    func didPan(_ gesture: UIPanGestureRecognizer) {
        
        guard let recognizedView = gesture.view as? ARSCNView else {return}
        let location = gesture.location(in: recognizedView)
        
        switch gesture.state {
        
        case .began:
            // perform a hitTest
            let hitTestResult = sceneView.hitTest(location)
            
            guard let hitNode = hitTestResult.first?.node else { return }
            
            // Set hitNode as selected
            sceneNode = hitNode
        
        case .changed:
            
            let results = sceneView.raycastQuery(from: location, allowing: .estimatedPlane, alignment: .horizontal)
            
            if let hitResults = results {
                sceneNode.position = SCNVector3(hitResults.direction.x,
                                              hitResults.direction.y,
                                              hitResults.direction.z)
            }
        
        default:
            break
        }
        
    }
    
}
