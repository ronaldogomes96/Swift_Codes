//
//  main.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 16/06/21.
//

import Foundation

// Perceptron Data
let data = [ [0.3, 0.7],
             [-0.6, 0.3],
             [-0.1, -0.8],
             [0.1, -0.45] ]

let targets = [1, 0, 0 ,1]

let and: [[Double]] = [[1, 0],
                       [0, 1],
                       [0, 0],
                       [1, 1]]

let andTargets = [0, 0, 0 ,1]


// Linear regression data
let x: [[Double]] = [[0, 1], [5, 1], [15, 2], [25, 5], [35, 11], [45, 15], [55, 34], [60, 35]]
let y: [Double] = [4, 5, 20, 14, 32, 22, 38, 43]



let perceptron = Perceptron()

perceptron.train(data: and, targets: andTargets)

print(perceptron.predict(data: [0, 0]))

//let regression = LinearRegression()
//regression.train(data: x, targets: y)
