//
//  ViewController.swift
//  HomeDecor
//
//  Created by Ronaldo Gomes on 07/11/20.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    
    //Configuracao do mundo real a partir do arkit
    let config = ARWorldTrackingConfiguration()
    //Cria um objeto 3D em forma de capsula
    let capsuleNode = SCNNode(geometry: SCNCapsule(capRadius: 0.03, height: 0.1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Permite a visualizacao de informacoes em tempo real da aplicacao
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        //Informa que o sera detectado o plano horizontal
        config.planeDetection = .horizontal
        //Inicia a secao do arkit
        sceneView.session.run(config)
        //Dizemos que ele implementa seu propio delegate
        sceneView.delegate = self

        /*
        //Coloca a posicao da capsula
        capsuleNode.position = SCNVector3(0.1, 0.1, -0.1)
        //Adiciona ele na tela
        sceneView.scene.rootNode.addChildNode(capsuleNode)
        
        //O primeiro elemento da tela tera a cor laranja
        capsuleNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
        //Estamos dizendo que o angulo sera de 90 graus ( radianos )
        capsuleNode.eulerAngles = SCNVector3(0,0,Double.pi/2)
        */

    }
    
    //Funcao que recebe ARPlaneAnchor como parâmetro, criar um node de piso na posição da âncora e devolvê-lo.
    func createFloorNode(anchor:ARPlaneAnchor) ->SCNNode{
        
        /*
         Estamos criando um node com uma geometria de SCNPlane que tem o tamanho da âncora da tela. A extensão ARPlaneAnchor
         contém as informações de posição. O fato de Extenso.z ter sido usado como altura e não extensão.y pode ser um
         pouco confuso. Se você visualizar que um cubo 3D está colocado em um chão e quiser torná-lo plano ao longo de uma
         superfície 2D, altere y para zero e ele ficará plano. Agora, para obter o comprimento desta superfície 2D, você
         consideraria z, não é? Nosso piso é plano, então precisamos de um nó plano, não de um cubo.
        */
        let floorNode = SCNNode(geometry: SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z)))
        //Definindo a posicao do node, como não precisamos de nenhuma elevação, tornamos y zero.
        floorNode.position = SCNVector3(anchor.center.x,0,anchor.center.z)
        //Defini a cor do piso como azul
        floorNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "WoodenFloorTile")
        //A cor do material será exibida apenas em um lado
        floorNode.geometry?.firstMaterial?.isDoubleSided = true
        //Por padrão, o plano será colocado verticalmente. Para torná-lo horizontal, precisamos girá-lo em 90 graus.
        floorNode.eulerAngles = SCNVector3(Double.pi/2,0,0)
        return floorNode
    }
    
    //Implementando os metodos delegate
    
    //é chamado a cada adicao de node na tela
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        //Verificando se a âncora é um ARPlaneAnchor, já que lidaríamos apenas com este tipo de âncora.
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        
        //Criamos um novo node com base nessa ancora
        let planeNode = createFloorNode(anchor: planeAnchor)
        //Adicionando ao novo no
        node.addChildNode(planeNode)
    }
    
    //Vamos deletar todos os nossos nós de piso. Faremos isso porque as dimensões do nó atual foram alteradas e os nós do piso antigo não coincidem.
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        //Verificando se a âncora é um ARPlaneAnchor, já que lidaríamos apenas com este tipo de âncora.
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        
        //Elimina todos os nodes antigos
        node.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        
        //Criamos um novo node com base nessa ancora
        let planeNode = createFloorNode(anchor: planeAnchor)
        //Adicionando ao novo no
        node.addChildNode(planeNode)
    }
    
    //Por fim é chamada para remover os nos desncessarios
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let _ = anchor as? ARPlaneAnchor else {return}
        node.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
    }
}

