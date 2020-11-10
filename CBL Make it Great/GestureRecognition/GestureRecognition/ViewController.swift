//
//  ViewController.swift
//  GestureRecognition
//
//  Created by Ronaldo Gomes on 09/11/20.
//

import UIKit
import ARKit
import Vision

class ViewController: UIViewController {

    //Objeto virtual que esta sendo instanciado na tela
    @IBOutlet weak var sceneView: ARSCNView!
    //Objeto que pega o mundo real
    let configuration = ARWorldTrackingConfiguration()
    //Estaremos constantemente tentando reconhecer cada quadro exibido de nossa câmera, e não podemos bloquear o thread da IU muitas vezes por segundo para analisar esses quadros. Portanto, devemos lidar com isso usando uma serial queue, que é nossa primeira propriedade.
    private let serialQueue = DispatchQueue(label: "com.hb.dispatchqueueml")
    //Array de request do framework Vision
    private var visionRequest = [VNRequest]()
    //Web view que ira aparecer na tela
    private let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 640, height: 480))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        setupAR()
        setupML()
        loopCoreMLUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    //Funcao de configuracao do Arkit
    func setupAR() {
        //Cria um objeto que permite a acao de uma funcao ao clicar na tela
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        //Adiciona na tela
        sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        sceneView.session.run(configuration)
    }
    
    @objc func tapped(recognizer: UIGestureRecognizer) {
        
        //Pega o plano atual da tela
        guard let currentFrame = self.sceneView.session.currentFrame,
              let url = URL(string: "https://www.supercharge.io") else {
            return
        }
        
        //Faz o rquest para o site
        webView.loadRequest(URLRequest(url: url))
        
        //Criamos um no para carregar essa webview
        let browserPlane = SCNPlane(width: 1.0, height: 0.75)
        browserPlane.firstMaterial?.diffuse.contents = webView
        browserPlane.firstMaterial?.isDoubleSided = true
        
        //A posição do nó que contém este SCNPlane está sendo definida ao obter a matriz de transformação da câmera para recuperar o ponto de vista e multiplicar o eixo 'z' por -1,0, para que possa ser visto um pouco à frente da câmera do telefone.
        let browserPlaneNode = SCNNode(geometry: browserPlane)
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1.0
        browserPlaneNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        browserPlaneNode.eulerAngles = SCNVector3Zero
        
        //Adicionamos na tela
        self.sceneView.scene.rootNode.addChildNode(browserPlaneNode)
    }

    //Funcao de configuracao do coreML
    func setupML() {
        
        //Faz o unwarpd do modelo coreml
        guard let selectedModel = try? VNCoreMLModel(for: example_5s0_hand_model().model) else {
            fatalError("Could not load model.")
        }
        
        //Fazendo o request desse model
        let classificationRequest = VNCoreMLRequest(model: selectedModel, completionHandler: classificationCompleteHandler)
        visionRequest = [classificationRequest]
    }
    
    //Chamamos essa funcao na thread main e usamos recursividade para fazer o update
    private func loopCoreMLUpdate() {
        serialQueue.async {
            self.updateCoreML()
            self.loopCoreMLUpdate()
        }
    }
    
    private func updateCoreML() {
        
        //Recuperamos o quadro atual da camera
        let pixbuff: CVPixelBuffer? = (sceneView.session.currentFrame?.capturedImage)
        if pixbuff == nil { return }
        //Guardamos isso em uma imagem
        let ciImage = CIImage(cvPixelBuffer: pixbuff!)
        
        //Em seguida, instanciamos um VNImageRequestHandler passando esse CIImage e chamamos o método perform neste manipulador, passando a propriedade do array contendo o VNRequest que criamos antes
        let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try imageRequestHandler.perform(self.visionRequest)
        } catch {
            print(error)
        }
    }
    
    private func classificationCompleteHandler(request: VNRequest, error: Error?) {
        if error != nil {
            print("Error: " + (error?.localizedDescription)!)
            return
        }
        guard let observations = request.results else {
            print("No results")
            return
        }
        
        let classifications = observations[0...2]
            .compactMap({ $0 as? VNClassificationObservation })
            .map({ "\($0.identifier) \(String(format:" : %.2f", $0.confidence))" })
            .joined(separator: "\n")
        
        DispatchQueue.main.async {
            let topPrediction = classifications.components(separatedBy: "\n")[0]
            let topPredictionName = topPrediction.components(separatedBy: ":")[0].trimmingCharacters(in: .whitespaces)
            let topPredictionScore:Float? = Float(topPrediction.components(separatedBy: ":")[1].trimmingCharacters(in: .whitespaces))
            if (topPredictionScore != nil && topPredictionScore! > 0.10) {
                if topPredictionName == "fist-UB-RHand" {
                    var scrollHeight: CGFloat = self.webView.scrollView.contentSize.height - self.webView.bounds.size.height
                    if (0.0 > scrollHeight) {
                        scrollHeight = 0.0
                    }
                    self.webView.scrollView.setContentOffset(CGPoint(x: 0.0, y: scrollHeight), animated: true)
                }
                
                if topPredictionName == "FIVE-UB-RHand" {
                    self.webView.scrollView.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
                }
            }
        }
    }
}

