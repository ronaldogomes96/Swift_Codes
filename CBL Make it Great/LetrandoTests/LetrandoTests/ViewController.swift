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

    @IBOutlet var sceneView: ARSCNView!
    
    let names = ["a", "b", "c", "d", "e", "f", "g", "h", "j", "l"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
        
        addSpheres()
        
        //1. Create A UITapGestureRecognizer & Add It To Our MainView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkNodeHit(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
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
    
    /// Runs An SCNHitTest To Check If An SCNNode Has Been Hit
    ///
    /// - Parameter gesture: UITapGestureRecognizer
    @objc func checkNodeHit(_ gesture: UITapGestureRecognizer){

        //1. Get The Current Touch Location In The View
        let currentTouchLocation = gesture.location(in: sceneView)

        //2. Perform An SCNHitTest To Determine If We Have Hit An SCNNode
        guard let hitTestNode = sceneView.hitTest(currentTouchLocation, options: nil).first?.node else { return }


        print("The User Has Successfuly Tapped On \(hitTestNode.name!)")

        
    }

    //Recebe como parametro uma posicao para colocar nosso objeto no espaco 3D
    func addSpheres() {

        for i in 0...9 {
            
            //1. Create An SCNNode With An SCNSphere Geometry
            let nodeOneGeometry = SCNText(string: names[i], extrusionDepth: 1)

            //2. Set It's Colour To Cyan
            nodeOneGeometry.firstMaterial?.diffuse.contents = UIColor.cyan
            
            //3. Assign The Geometry To The Node
            let scene = SCNNode(geometry: nodeOneGeometry)

            //4. Assign A Name For Our Node
            scene.name = names[i]

            let randomNumbers = self.randomNumbers()
            
            //5. Position It & Add It To Our ARSCNView
            scene.position = SCNVector3(randomNumbers[0], randomNumbers[1], randomNumbers[2])
            
            sceneView.scene.rootNode.addChildNode(scene)
        }
    }
    
    func randomNumbers() -> [Float] {
        var array = [Float]()
        for _ in 0...3{
            let numbers = Float.random(in: -10...10)
            array.append(numbers)
        }
        return array
    }
}
