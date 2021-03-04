//
//  ViewController.swift
//  The Universe AR Tests
//
//  Created by Ronaldo Gomes on 12/02/21.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    //É a estrutura de algum elemento
    let node = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let sphere = SCNSphere(radius: 0.4)
        
        //Podemos personalizar os elementos com materials
        let materials = SCNMaterial()
        materials.diffuse.contents = UIImage(named: "art.scnassets/Earth.jpg")
        
        //Entao adicionamos ao cube como array pois pode receber mais de um
        sphere.materials = [materials]
        
        //Posicao 3D na tela
        node.position = SCNVector3(0, 0.1, -2)
        //Objeto a ser fixado
        //node.geometry = cube
        node.geometry = sphere
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(0, 1, 0), duration: 15)
        let repeatAction = SCNAction.repeatForever(action)
        node.runAction(repeatAction)
        
        sceneView.allowsCameraControl = true
        //sceneView.cameraControlConfiguration.autoSwitchToFreeCamera = false
        
        
        sceneView.scene.rootNode.addChildNode(node)
        
//        addPinchGesture()
//
//        addRotationGesture()

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

//    
//    //Permite o zoom do objeto
//    private func addPinchGesture() {
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
//        self.sceneView.addGestureRecognizer(pinchGesture)
//    }
//    
//    //Permite a rotacao do objeto
//    private func addRotationGesture() {
//        let panGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(_:)))
//        self.sceneView.addGestureRecognizer(panGesture)
//    }
//    
//    //Funcao do gesto do usuario
//    @objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
//        
//        //Status do gesto
//        switch gesture.state {
//        //Faz um gesto de pinça e adicione a escala do nosso cubo a ele para os casos em que o cubo já foi alongado e queremos continuar a escalar e não iniciá-lo do início.
//        case .began:
//            gesture.scale = CGFloat(node.scale.x)
//        //Caso ele seja mudado
//        case .changed:
//            //Iniciamos uma nova scala
//            var newScale: SCNVector3
//            //Se a escala for menor que 0,5, deixamos no nível 0,5
//            if gesture.scale < 0.5 {
//                newScale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
//            }
//            //Se a escala for superior a 3 deixamos no nível 3
//            else if gesture.scale > 3 {
//                newScale = SCNVector3(3, 3, 3)
//            }
//            //Em todos os outros casos, definimos a escala que corresponde ao gesto de pinça.
//            else {
//                newScale = SCNVector3(gesture.scale, gesture.scale, gesture.scale)
//            }
//            //Entao definimos nossa scala para o node
//            node.scale = newScale
//        default:
//            break
//        }
//    }
//    
//    //Varivael de rotacao
//    private var lastRotation: Float = 0
//    
//    @objc func didRotate(_ gesture: UIRotationGestureRecognizer) {
//        
//        
//        //Caso o status do gesto
//        switch gesture.state {
//        //QUando mudado
//        case .changed:
//            //Mudamos o angulo de y
//            self.node.eulerAngles.y = self.lastRotation + Float(gesture.rotation)
//            self.node.eulerAngles.z = self.lastRotation + Float(gesture.rotation)
//        case .ended:
//            //Salvamos o ultimo valor da rotacao
//            self.lastRotation += Float(gesture.rotation)
//        default:
//            break
//        }
//    }
}
