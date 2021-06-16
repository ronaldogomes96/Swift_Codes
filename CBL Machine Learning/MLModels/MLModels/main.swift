//
//  main.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 16/06/21.
//

import Foundation

let data = [ [0.3, 0.7],
             [-0.6, 0.3],
             [-0.1, -0.8],
             [0.1, -0.45] ]

let targets = [1, 0, 0 ,1]

let perceptron = Perceptron()

perceptron.train(data: data, targets: targets)
