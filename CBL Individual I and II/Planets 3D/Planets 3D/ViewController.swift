//
//  ViewController.swift
//  Planets 3D
//
//  Created by Ronaldo Gomes on 03/01/21.
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
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Ajusta as luzes automaticamente
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        //Referencia da imagem a ser procurada
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Planets", bundle: Bundle.main) {
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 1
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate

    //É chamado quando a ancora é achada, no caos a imagem determinada anteriormente
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            //Pegamos o plano da imagem
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                                 height: imageAnchor.referenceImage.physicalSize.height)
            
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            
            // Rotacionamos o angulo em 90 graus no sentido anti horario
            planeNode.eulerAngles.x = -.pi / 2
            
            node.addChildNode(planeNode)
            
            //Pegamos a referencia do arquivo scn
            if let planetScene = SCNScene(named: "art.scnassets/Earth.scn") {
                
                // Pegamos o node deste arquivo
                if let planetNode = planetScene.rootNode.childNodes.first {
                    
                    // Rotacionamos em 90 graus no sentido horario
                    planeNode.eulerAngles.x = .pi / 2
                    
                    // Adicionamos esta referencia
                    planeNode.addChildNode(planetNode)
                    
                    print("AIAIAIAIAIAI")
                }
            }
        }
        
        return node
    }
}
