//
//  ViewController.swift
//  CubeARKit
//
//  Created by Ronaldo Gomes on 07/11/20.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    //Rastreia a orientação e a posição do dispositivo.
    //Ele também detecta superfícies reais, visíveis através da câmera.
    private let configuration = ARWorldTrackingConfiguration()
    
    //representando uma posição e transformação em um espaço de coordenadas 3D,
    //ao qual pode anexar geometria, luzes, câmeras ou outro conteúdo exibível.
    private var node: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Mostra estatísticas como fps e informações de tempo
        sceneView.showsStatistics = true
        /*
         Isso permitirá ver como o ARKit detecta uma superfície. Quando lançamos o aplicativo, temos que ver
         muitas manchas amarelas na superfície. Esses pontos permitem estimar propriedades como orientação e
         posição de objetos físicos no ambiente base atual. Quanto mais manchas vemos na área, mais chances
         temos de o ARKit ser capaz de detectar e rastrear o ambiente.
         */
        sceneView.debugOptions = [.showFeaturePoints]
        addTapGesture()
        addPinchGesture()
        //addRotationGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Ao aparecer a tela, a secao do arkit sera iniciada, com a configuration pre determinada
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Quando a tela desaparece, a secao do arkit sera pausada
        sceneView.session.pause()
    }
    
    //Adiciona uma box na tela
    func addBox(x: Float = 0, y: Float = 0, z: Float = -0.2) {
        //Criamos um objeto virtual aqui na forma de um cubo com uma face de 0,1 metro. 1 float = 1 metro.
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        //Adicionamos uma cor diferente a cada face e criamos um array de cores,
        let colors = [UIColor.green, // front
                      UIColor.systemPink, // right
                      UIColor.blue, // back
                      UIColor.yellow, // left
                      UIColor.purple, // top
                      UIColor.gray] // bottom
        //então criamos um material SCNMaterial para cada face em um map e atribuímos o array recebido aos
        //materiais de nosso cubo.
        let sideMaterials = colors.map{ color -> SCNMaterial in
            let material = SCNMaterial()
            material.diffuse.contents = color
            material.locksAmbientWithDiffuse = true
            return material
        }
        //Mostra a geometria e aparencia do material criado
        box.materials = sideMaterials
        
        //Criamos um objeto SCNNode, ele representa a posição e as coordenadas do objeto no espaço tridimensional.
        node = SCNNode()
        //Adicionamos nosso cubo a ele e definimos suas coordenadas
        self.node.geometry = box
        self.node.position = SCNVector3(x, y, z)
        
        //Por fim, adicionamos nosso node na cena
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    //Permite o click na tela
    private func addTapGesture() {
        let tapGesture = UIPanGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.sceneView.addGestureRecognizer(tapGesture)
    }
    
    //Permite o zoom do objeto
    private func addPinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinch(_:)))
        self.sceneView.addGestureRecognizer(pinchGesture)
    }
    
//    //Permite a rotacao do objeto
//    private func addRotationGesture() {
//        let panGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotate(_:)))
//        self.sceneView.addGestureRecognizer(panGesture)
//    }
    
    //Funcao do click da tela que recebe como parametro esse click
    @objc func didTap(_ gesture: UIPanGestureRecognizer) {
        //Definimos a posicao do click da tela
        let tapLocation = gesture.location(in: self.sceneView)
        //Entao passamos como parametro do hitTest e achamos o local no SceneKit view
        let results = self.sceneView.raycastQuery(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)
        
        
        switch gesture.state {
        case .began:
            //Caso os pontos de contato tenham sido encontrados, recebemos o primeiro e seguimos em frente, caso contrário, completamos a função.
            guard let result = results else {
                return
            }
            
            //Usando o campo worldTransform do ponto de contato, determinamos as coordenadas deste ponto no sistema de coordenadas do mundo real, no caso, x y z result.worldTransform.translation
            let translation = result.direction
            
            //Se o objeto existe, mudamos sua posição
            guard let node = self.node else {
                //caso contrário, chamamos a função de addBox e passamos as coordenadas do ponto de contato para ele.
                self.addBox(x: translation.x, y: translation.y, z: translation.z)
                return
            }
            //Mudando a posicao
            self.node.position = SCNVector3Make(translation.x, translation.y, translation.z)
            self.sceneView.scene.rootNode.addChildNode(self.node)

        case .changed:
            let hitResult = sceneView.hitTest(tapLocation, types: .existingPlane)
            if !hitResult.isEmpty{
                guard let hitResult = hitResult.last else { return }
                node.position = SCNVector3Make(hitResult.worldTransform.columns.3.x, hitResult.worldTransform.columns.3.y, hitResult.worldTransform.columns.3.z)
            }

        default:
            break
        }
    }

    //Funcao do gesto do usuario
    @objc func didPinch(_ gesture: UIPinchGestureRecognizer) {
        
        //Status do gesto
        switch gesture.state {
        //Faz um gesto de pinça e adicione a escala do nosso cubo a ele para os casos em que o cubo já foi alongado e queremos continuar a escalar e não iniciá-lo do início.
        case .began:
            gesture.scale = CGFloat(node.scale.x)
        //Caso ele seja mudado
        case .changed:
            //Iniciamos uma nova scala
            var newScale: SCNVector3
            //Se a escala for menor que 0,5, deixamos no nível 0,5
            if gesture.scale < 0.5 {
                newScale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
            }
            //Se a escala for superior a 3 deixamos no nível 3
            else if gesture.scale > 3 {
                newScale = SCNVector3(3, 3, 3)
            }
            //Em todos os outros casos, definimos a escala que corresponde ao gesto de pinça.
            else {
                newScale = SCNVector3(gesture.scale, gesture.scale, gesture.scale)
            }
            //Entao definimos nossa scala para o node
            node.scale = newScale
        default:
            break
        }
    }
    
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
//        case .ended:
//            //Salvamos o ultimo valor da rotacao
//            self.lastRotation += Float(gesture.rotation)
//        default:
//            break
//        }
//    }
}

//É a extensão para float4 × 4, o que torna o trabalho com as coordenadas mais conveniente.
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}
