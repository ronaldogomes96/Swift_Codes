
/*
    Construindo um classificador de acoes corporais com o create ml
 
     - Pode ser feita como uma classificacao normal de machine learning, usando
     videos de acoes de pessoas fazendo movimentos.
     - Com isso seu app pode reconhecer movimentos corporais
     - Nao funciona com movimento de animais ou moveis
     - Para gerar o modelo, segue tres passos
        1 -> Juntar uma base de dados separados por diferentes movimentos
        2 -> Usar o create ml para treino
        3 -> Salvar e usar o modelo coreml gerado pelo create ml
 
    - Nao usar videos com mais de um movimento corporal, pois isso confunde o machine learning
    - O modelo usa toda o corpo
    - Separar em pastas com os nomes dos trainers
    - Podemos usar arquivos json para separar os espacos de tempo do video, de acordo com o movimento
 
 */

//Exemplo de json

/*
[
    {
        "file_name": "Montage1.mov",
        "label": "Squats",
        "start_time": 4.5,
        "end_time": 8
    }
]
*/

/*
     - O parametro action duration no create ml informa a duracao do movimento que sera treinado
     - A deteccao dos movimentos humanos é feito com o Vision
     - Para fazer o treinamento é usado 18 landymarks, que sao coordenadas x e y
     - Algumas dicas para melhorar seu modelo machine learning é
     - Usar mais de 50 exemplos por classe
     - Dados variados
 */
//Codigos usados

//Pegando poses no geral

import Vision
let request = VNDetectHumanBodyPoseRequest()

//Pegando poses de um video

import Vision
let videoURL = URL(fileURLWithPath: "your-video-file.MOV")
let startTime = CMTime.zero
let endTime = CMTime.indefinite

let request = VNDetectHumanBodyPoseRequest(completionHandler: { request, error in
    let poses = request.results as! [VNRecognizedPointsObservation]
})

let processor = VNVideoProcessor(url: videoURL)
try processor.add(request)
try processor.analyze(with: CMTimeRange(start: startTime, end: endTime))

//Pegando poses de uma imagem

import Vision
let request = VNDetectHumanBodyPoseRequest()
// Use either one from image URL, CVPixelBuffer, CMSampleBuffer, CGImage, CIImage, etc. in image request handler, based on the context.
let handler = VNImageRequestHandler(url: URL(fileURLWithPath: "your-image.jpg"))

try handler.perform([request])
let poses = request.results as! [VNRecognizedPointsObservation]

//Fazendo a predicao

import Vision
import CoreML

// Assume pose1, pose2, ..., have been obtained from a video file or camera stream.
let pose1: VNRecognizedPointsObservation
let pose2: VNRecognizedPointsObservation
// ...

// Get a [1, 3, 18] dimension multi-array for each frame
let poseArray1 = try pose1.keypointsMultiArray()
let poseArray2 = try pose2.keypointsMultiArray()
// ...

// Get a [60, 3, 18] dimension prediction window from 60 frames
let modelInput = MLMultiArray(concatenating: [poseArray1, poseArray2], axis: 0, dataType: .float)

//Classe de predicao final


import Foundation
import CoreML
import Vision

@available(iOS 14.0, *)
class Predictor {
    /// Fitness classifier model.
    let fitnessClassifier = FitnessClassifier()

    /// Vision body pose request.
    let humanBodyPoseRequest = VNDetectHumanBodyPoseRequest()

    /// A rotation window to save the last 60 poses from past 2 seconds.
    var posesWindow: [VNRecognizedPointsObservation?] = []
    init() {
        posesWindow.reserveCapacity(predictionWindowSize)
    }

    /// Extracts poses from a frame.
    func processFrame(_ samplebuffer: CMSampleBuffer) throws -> [VNRecognizedPointsObservation] {
        // Perform Vision body pose request
        let framePoses = extractPoses(from: samplebuffer)

        // Select the most promiment person.
        let pose = try selectMostProminentPerson(from: framePoses)

        // Add the pose to window
        posesWindow.append(pose)

        return framePoses
    }

    // Make a prediction when window is full, periodically
    var isReadyToMakePrediction: Bool {
        posesWindow.count == predictionWindowSize
    }

    /// Make a model prediction on a window.
    func makePrediction() throws -> PredictionOutput {
        // Prepare model input: convert each pose to a multi-array, and concatenate multi-arrays.
        let poseMultiArrays: [MLMultiArray] = try posesWindow.map { person in
            guard let person = person else {
                // Pad 0s when no person detected.
                return zeroPaddedMultiArray()
            }
            return try person.keypointsMultiArray()
        }

        let modelInput = MLMultiArray(concatenating: poseMultiArrays, axis: 0, dataType: .float)

        // Perform prediction
        let predictions = try fitnessClassifier.prediction(poses: modelInput)

        // Reset poses window
        posesWindow.removeFirst(predictionInterval)

        return (
            label: predictions.label,
            confidence: predictions.labelProbabilities[predictions.label]!
        )
    }
}
