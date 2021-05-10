//
//  Models.swift
//  ObjectDetectionTests
//
//  Created by Ronaldo Gomes on 07/05/21.
//

import Foundation
import CoreML
import Vision

enum MLNameModels: String, CaseIterable {
    
    case mobileNetV2 = "MobileNetV2"
    case mobileNetV2FP16 = "MobileNetV2FP16"
    case mobileNetV2Int8LUT = "MobileNetV2Int8LUT"
    case resnet50 = "Resnet50"
    case resnet50FP16 = "Resnet50FP16"
    case resnet50Headless = "Resnet50Headless" //Nao funciona
    case resnet50Int8LUT = "Resnet50Int8LUT"
    case squeezeNet = "SqueezeNet" //Melhor
    case squeezeNetFP16 = "SqueezeNetFP16"
    case squeezeNetInt8LUT = "SqueezeNetInt8LUT"
    case inceptionv3 = "Inceptionv3"
    case yOLOv3 = "YOLOv3"
    case yOLOv3FP16 = "YOLOv3FP16"
    case yOLOv3Int8LUT = "YOLOv3Int8LUT"
    case yOLOv3Tiny = "YOLOv3Tiny" //Nao funciona
    case yOLOv3TinyFP16 = "YOLOv3TinyFP16"
    case yOLOv3TinyInt8LUT = "YOLOv3TinyInt8LUT"
    
    var mlModel: MLModel {
        switch self {
        case .mobileNetV2:
            return try! MobileNetV2(configuration: MLModelConfiguration()).model
        case .mobileNetV2FP16:
            return try! MobileNetV2FP16(configuration: MLModelConfiguration()).model
        case .mobileNetV2Int8LUT:
            return try! MobileNetV2Int8LUT(configuration: MLModelConfiguration()).model
        case .resnet50:
            return try! Resnet50(configuration: MLModelConfiguration()).model
        case .resnet50FP16:
            return try! Resnet50FP16(configuration: MLModelConfiguration()).model
        case .resnet50Headless:
            return try! Resnet50Headless(configuration: MLModelConfiguration()).model
        case .resnet50Int8LUT:
            return try! Resnet50Int8LUT(configuration: MLModelConfiguration()).model
        case .squeezeNet:
            return try! SqueezeNet(configuration: MLModelConfiguration()).model
        case .squeezeNetFP16:
            return try! SqueezeNetFP16(configuration: MLModelConfiguration()).model
        case .squeezeNetInt8LUT:
            return try! SqueezeNetInt8LUT(configuration: MLModelConfiguration()).model
        case .inceptionv3:
            return try! Inceptionv3(configuration: MLModelConfiguration()).model
        case .yOLOv3:
            return try! YOLOv3(configuration: MLModelConfiguration()).model
        case .yOLOv3FP16:
            return try! YOLOv3FP16(configuration: MLModelConfiguration()).model
        case .yOLOv3Int8LUT:
            return try! YOLOv3Int8LUT(configuration: MLModelConfiguration()).model
        case .yOLOv3Tiny:
            return try! YOLOv3Tiny(configuration: MLModelConfiguration()).model
        case .yOLOv3TinyFP16:
            return try! YOLOv3TinyFP16(configuration: MLModelConfiguration()).model
        case .yOLOv3TinyInt8LUT:
            return try! YOLOv3TinyInt8LUT(configuration: MLModelConfiguration()).model
        
        }
    }
}

