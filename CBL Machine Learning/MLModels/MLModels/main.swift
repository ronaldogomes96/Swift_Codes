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
let x: [[Double]] = [[0, 1],
                     [5, 1],
                     [25, 5], [35, 11], [45, 15], [55, 34], [60, 35]]
let y: [Double] = [4, 5, 14, 32, 22, 38, 43]

//var pressao = ReadFiles.read(fileName: "pressao", type: "txt")
//
//pressao.removeFirst()
//
//let xPressao = pressao.compactMap { [Double($0.first!)!] }
//let yPressao = pressao.compactMap { Double($0.last!) }
//print(xPressao)
//print(yPressao)

//print([0..<pressao.count])
//print([pressao[0..<pressao.count][0]])
//print(pressao[1][0..<pressao[0].count - 1])

// [15, 2] 20


//let perceptron = Perceptron()
//
//perceptron.train(data: and, targets: andTargets)
//
//print(perceptron.predict(data: [0, 0]))

//let regression = LinearRegression()
//let sta = Statistic()
//
//let newx = sta.normalize(data: xPressao)
//print(newx)
//regression.train(data: newx, targets: yPressao)
//let n = sta.normalize(data: [[42]])
//print(regression.predict(data: n[0]))
//print(regression.predict(data: sta.normalize(data: [[5,1]])[0]))


let regression = LinearRegression()
let sta = Statistic()

let newx = sta.normalize(data: x)
print(newx)
regression.train(data: newx, targets: y)
//let n = sta.normalize(data: [[42]])
//print(regression.predict(data: n[0]))
//print(regression.predict(data: sta.normalize(data: [[5,1]])[0]))
