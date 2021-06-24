//
//  ClassificationDatas.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 22/06/21.
//

import Foundation

struct ClassficationData {
    
    // MARK: - Perceptron
    func perceptron_runAnd() {
        // Dataset
        let and: [[Double]] = [[1, 0],
                               [0, 1],
                               [0, 0],
                               [1, 1]]

        let andTargets = [0, 0, 0 ,1]
        
        // Train
        let perceptron = Perceptron()
        perceptron.train(data: and, targets: andTargets)
        
        // Predict
        print(perceptron.predict(data: [0, 0])) //0
    }
    
    func perceptron_runInternetDatabase() {
        // Dataset
        let data = [ [0.3, 0.7],
                     [-0.6, 0.3],
                     [-0.1, -0.8],
                     [0.1, -0.45] ]

        let targets = [1, 0, 0 ,1]
        
        // Train
        let perceptron = Perceptron()
        perceptron.train(data: data, targets: targets)
        
        // Predict
        print(perceptron.predict(data: [0.7, 0.9])) //1
    }
    
    // MARK: - KNN
    func knn_runInternetDatabase() {
        // Dataset
        let data = [ [0.3, 0.7],
                     [-0.6, 0.3],
                     [-0.1, -0.8],
                     [0.1, -0.45] ]

        let targets: [Double] = [1, 0, 0 ,1]
        
        // Train
        let knn = KNN(KNeighbors: 1)
        knn.train(data: data, targets: targets)
        
        // Predict
        print(knn.predict(x: [0.7, 0.9])) //1
    }
}
