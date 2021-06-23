//
//  ClassificationDatas.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 22/06/21.
//

import Foundation

struct ClassficationData {
    
    // MARK: - Perceptron
    func runAnd() {
        let and: [[Double]] = [[1, 0],
                               [0, 1],
                               [0, 0],
                               [1, 1]]

        let andTargets = [0, 0, 0 ,1]
        
        let perceptron = Perceptron()
        perceptron.train(data: and, targets: andTargets)
        
        print(perceptron.predict(data: [0, 0])) //0
    }
    
    func runInternetDatabase() {
        let data = [ [0.3, 0.7],
                     [-0.6, 0.3],
                     [-0.1, -0.8],
                     [0.1, -0.45] ]

        let targets = [1, 0, 0 ,1]
        
        let perceptron = Perceptron()
        perceptron.train(data: data, targets: targets)
        
        print(perceptron.predict(data: [0.7, 0.9])) //1
    }
}
