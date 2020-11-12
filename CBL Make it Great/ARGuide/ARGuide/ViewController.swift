//
//  ViewController.swift
//  ARGuide
//
//  Created by Ronaldo Gomes on 11/11/20.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    var sceneController = HoverScene()
    @IBOutlet weak var sceneView: ARSCNView!
    var configuration = ARWorldTrackingConfiguration()
    var didInitializeScene: Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Criando uma nova scene
        if let scene = sceneController.scene {
            sceneView.scene = scene
        }
        sceneView.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapScreen))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Criando a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Iniciando a view session
        sceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pausando a view session
        sceneView.session.pause()
    }

    //É acionado quando o frame é atualizado na tela
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        //Caso nao tenha sido iniciado a scena
        if !didInitializeScene {
            //Pega o frame atual da camera
            if sceneView.session.currentFrame?.camera != nil {
                didInitializeScene = true
            }
        }
    }
    
    //Mostra o objeto quando a tela é clicada
    @objc func didTapScreen(recognizer: UITapGestureRecognizer) {
        if didInitializeScene {
            if let camera = sceneView.session.currentFrame?.camera {
                /*
                 Obteremos sua propriedade transform que nos dará sua posição e rotação.
                 Criamos uma nova transformação que traduzimos por -1,0 no eixo Z, o que significa que estamos movendo 1
                 unidade para frente nas unidades mundiais do SceneKit (1 metro). Pegamos essa transformação traduzida e
                 a multiplicamos para a transformação da câmera, essencialmente colocando um objeto 1 metro na frente da
                 câmera, para onde quer que ele esteja apontando. Em seguida, usamos essa transformação e pegamos apenas
                 os valores XYZ necessários para criar um SCNVector3. Isso é passado para nossa função addSphere
                 para colocar nossa esfera no mundo.
                 */
                var translation = matrix_identity_float4x4
                translation.columns.3.z = -1.0
                let transform = camera.transform * translation
                let position = SCNVector3(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
                sceneController.addSphere(position: position)
            }
        }
    }

}

