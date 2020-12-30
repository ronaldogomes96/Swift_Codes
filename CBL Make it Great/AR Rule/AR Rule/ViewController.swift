//
//  ViewController.swift
//  AR Rule
//
//  Created by Ronaldo Gomes on 30/12/20.
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
        
        // Mostra os pontos que foram detectados
        sceneView.debugOptions = [.showFeaturePoints]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // Chamado a cada toque do usuario na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touchLocation = touches.first?.location(in: sceneView) {
            
            // Local no espaco 3d dentro do mundo real
            guard let raycastQueryResults = sceneView.raycastQuery(from: touchLocation,
                                                           allowing: .estimatedPlane,
                                                           alignment: .horizontal) else {
                fatalError()
            }
            if let rayqueryResult = sceneView.session.raycast(raycastQueryResults).last {
                addDot(at: rayqueryResult)
            }
        }
    }
    
    
    // Adiciona um ponto onde o usuario clicou
    func addDot(at rayqueryResult: ARRaycastResult) {
        
        let dotGeometry = SCNSphere(radius: 0.005)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        
        dotGeometry.materials = [material]
        
        let dotNode = SCNNode(geometry: dotGeometry)
        
        dotNode.position = SCNVector3(rayqueryResult.worldTransform.columns.3.x,
                                      rayqueryResult.worldTransform.columns.3.y,
                                      rayqueryResult.worldTransform.columns.3.z)
        
        sceneView.scene.rootNode.addChildNode(dotNode)
    }
    
}
