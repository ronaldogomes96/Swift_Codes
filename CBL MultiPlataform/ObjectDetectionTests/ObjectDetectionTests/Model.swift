//
//  Model.swift
//  ObjectDetectionTests
//
//  Created by Ronaldo Gomes on 07/05/21.
//

import UIKit
import CoreML
import Vision

class Model {
    
    func results(for model: MLNameModels, image: UIImage) -> [String] {
        guard let model = try? VNCoreMLModel(for: model.mlModel) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        var imageResults = [VNClassificationObservation]()
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            
            imageResults = results.filter({ result in
                result.confidence > 0.1
            })
            print(imageResults.first?.confidence)
        }
        
        guard let ciImage = CIImage(image: image) else {
            fatalError("Cannot convert to CIImage")
        }
        
        let handle = VNImageRequestHandler(ciImage: ciImage)
        
        do {
            //Faz o request da imagem com o coreML request configurado
            try handle.perform([request])
        } catch {
            print(error)
        }
        
        
        return imageResults.map { $0.identifier }
    }
}
