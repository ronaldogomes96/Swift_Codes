//
//  Scene.swift
//  LetrandoTests
//
//  Created by Ronaldo Gomes on 19/11/20.
//

import Foundation
import ARKit

class Scene {
    
//    //Objeto de referencia da cena 3D
//    var scene: SCNScene?
//    
//    init() {
//        scene = self.initializeScene()
//    }
//    
//    //Inicia o objeto de cena
//    func initializeScene() -> SCNScene? {
//        let scene = SCNScene()
//        setDefaults(scene: scene)
//        return scene
//    }
//    
//    //Configuracoes padroes do scene
//    func setDefaults(scene: SCNScene) {
//        let ambientLightNode = SCNNode()
//        ambientLightNode.light = SCNLight()
//        ambientLightNode.light?.type = SCNLight.LightType.ambient
//        ambientLightNode.light?.color = UIColor(white: 0.6, alpha: 1.0)
//        
//        scene.rootNode.addChildNode(ambientLightNode)
//        
//        let directionalLight = SCNLight()
//        directionalLight.type = .directional
//        let directionalNode = SCNNode()
//        directionalNode.eulerAngles = SCNVector3Make(GLKMathDegreesToRadians(-130), GLKMathDegreesToRadians(0), GLKMathDegreesToRadians(35))
//        directionalNode.light = directionalLight
//        
//        scene.rootNode.addChildNode(directionalNode)
//    }
    
    //Recebe como parametro uma posicao para colocar nosso objeto no espaco 3D
    func addSphere(position: SCNVector3) -> SCNNode {
        
        //1. Create An SCNNode With An SCNSphere Geometry
        let nodeOneGeometry = SCNSphere(radius: 0.2)

        //2. Set It's Colour To Cyan
        nodeOneGeometry.firstMaterial?.diffuse.contents = UIColor.cyan

        //3. Assign The Geometry To The Node
        let scene = SCNNode(geometry: nodeOneGeometry)

        //4. Assign A Name For Our Node
        scene.name = "Node One"

        //5. Position It & Add It To Our ARSCNView
        scene.position = position
        
        return scene
        //scene.rootNode.addChildNode(nodeOne)
    }
}
//
//@IBOutlet var sceneView: ARSCNView!
//
//private var node: SCNNode!
//
//let names = ["a", "b", "c", "d", "e", "f", "g", "h", "j", "l"]
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//
//    // Set the view's delegate
//    sceneView.delegate = self
//
//    // Show statistics such as fps and timing information
//    sceneView.showsStatistics = true
//
//    // Create a new scene
//    //let scene = SCNScene(named: "art.scnassets/ship.scn")!
//
//    // Set the scene to the view
//    //sceneView.scene = scene
//
//    //addLetter()
//
//    //1. Create A UITapGestureRecognizer & Add It To Our MainView
//    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkNodeHit(_:)))
//    tapGesture.numberOfTapsRequired = 1
//    self.view.addGestureRecognizer(tapGesture)
//
//    // Faz o zoom da letra
//    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
//    self.sceneView.addGestureRecognizer(pinchGesture)
//}
//
//override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//
//    // Create a session configuration
//    let configuration = ARWorldTrackingConfiguration()
//
//    // Run the view's session
//    sceneView.session.run(configuration)
//}
//
//override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
//
//    // Pause the view's session
//    sceneView.session.pause()
//}
//
///// Runs An SCNHitTest To Check If An SCNNode Has Been Hit
/////
///// - Parameter gesture: UITapGestureRecognizer
//@objc func checkNodeHit(_ gesture: UITapGestureRecognizer){
//
//    //1. Get The Current Touch Location In The View
//    let currentTouchLocation = gesture.location(in: sceneView)
//
//    //2. Perform An SCNHitTest To Determine If We Have Hit An SCNNode
//    guard let hitTestNode = sceneView.hitTest(currentTouchLocation, options: nil).first?.node else { return }
//
//
//    print("The User Has Successfuly Tapped On \(hitTestNode.name!)")
//
//
//}
//
////Recebe como parametro uma posicao para colocar nosso objeto no espaco 3D
//func addLetter() -> SCNText {
//
//    //for i in 0...9 {
//
//        //1. Create An SCNNode With An SCNSphere Geometry
//    let nodeOneGeometry = SCNText(string: names[0].uppercased(), extrusionDepth: 0.5)
//
//        //2. Set It's Colour To Cyan
//        nodeOneGeometry.firstMaterial?.diffuse.contents = UIColor.cyan
//    return nodeOneGeometry
//
//
////            //3. Assign The Geometry To The Node
////            node = SCNNode(geometry: nodeOneGeometry)
////
////            //4. Assign A Name For Our Node
////            node.name = names[0].uppercased()
////
////            //let randomNumbers = self.randomNumbers()
////
////            //5. Position It & Add It To Our ARSCNView
////            node.position = SCNVector3(0, 0, -0.2)
////
////            sceneView.scene.rootNode.addChildNode(node)
//    //}
//}
//
////Funcao do gesto do usuario
//@objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
//
//    //Status do gesto
//    switch gesture.state {
//    //Faz um gesto de pinça e adicione a escala do nosso cubo a ele para os casos em que o cubo já foi alongado e queremos continuar a escalar e não iniciá-lo do início.
//    case .began:
//        gesture.scale = CGFloat(node.scale.x)
//    //Caso ele seja mudado
//    case .changed:
//        //Iniciamos uma nova scala
//        var newScale: SCNVector3
//        //Se a escala for menor que 0,5, deixamos no nível 0,5
//        if gesture.scale < 0.5 {
//            newScale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
//        }
//        //Se a escala for superior a 3 deixamos no nível 3
//        else if gesture.scale > 3 {
//            newScale = SCNVector3(3, 3, 3)
//        }
//        //Em todos os outros casos, definimos a escala que corresponde ao gesto de pinça.
//        else {
//            newScale = SCNVector3(gesture.scale, gesture.scale, gesture.scale)
//        }
//        //Entao definimos nossa scala para o node
//        node.scale = newScale
//    default:
//        break
//    }
//}
//
//func createPlane(withPlaneAnchor planeAnchor: ARPlaneAnchor) -> SCNNode {
//
//    //Pega o plano de acordo com as coordenadas do anchor
//    let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
//
//    //Criar o node  que ira ser o plano
//    let planeNode = SCNNode()
//
//    //definindo sua posicao de acordo com o anchor
//    planeNode.position = SCNVector3(CGFloat(planeAnchor.center.x), 0, CGFloat(planeAnchor.center.z))
//    //Temos que transforma-lo para se comportar da forma correta no plano
//    planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
//
//    //Personalizando o node
////        let gridMaterial = SCNMaterial()
////
////        gridMaterial.diffuse.contents = UIImage(named: "art.scnassets/grid.png")
////
////        plane.materials = [gridMaterial]
////
////        planeNode.geometry = plane
//
//    planeNode.geometry = addLetter()
//
//
//
//    return planeNode
//
//}
//
//func randomNumbers() -> [Float] {
//    var array = [Float]()
//    for _ in 0...3{
//        let numbers = Float.random(in: -10...10)
//        array.append(numbers)
//    }
//    return array
//}
//
////É chamado todas as vezes em que for detectado um novo no plano na tela
//func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//
//    guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
//
//    let planeNode = createPlane(withPlaneAnchor: planeAnchor)
//
//    planeNode.addChildNode(planeNode)
//
//    self.node.addChildNode(planeNode)
//
//    sceneView.scene.rootNode.addChildNode(self.node)
//}
