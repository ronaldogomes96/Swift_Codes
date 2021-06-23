//
//  Perceptron.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 16/06/21.
//

import Foundation

class Perceptron {
    private var weights = [Double]()
    private var rate: Double
    private var epochs: Int
    
    init(rate: Double = 0.2, epochs: Int = 10000) {
        self.rate = rate
        self.epochs = epochs
    }
    
    func predict(data: [Double], isTrain: Bool = false) -> Int {
        var sumOfWeightsMultipliedData: Double = 0.0
        var xData = data
        
        // Caso nao seja o treino, tem que adicionar o valor do bias
        if !isTrain {
            xData.append(-1)
        }
        
        for (position, x) in xData.enumerated() {
            sumOfWeightsMultipliedData += x * weights[position]
        }
        
        return degree(sum: sumOfWeightsMultipliedData)
    }
    
    func train(data: [[Double]], targets: [Int]) {
        var hadErros = [Bool]()
        var xData = data
        var y = targets
        
        for index in 0..<xData.count {
            // Adiciona os bias ao fim de cada linha
            xData[index].append(-1)
        }
        
        // Inicializando o vetor de pesos com valores aleatorios
        xData[0].forEach { _ in
            weights.append(Double.random(in: -1...1))
        }
        
        
        for epoch in 0...epochs {
            hadErros = []
            
            print("\n\nEpoch \(epoch + 1)")
            
            // Randomiza o dataset, juntamente com os valores de Y
            (xData, y) = randomizeDataset(x: xData, y: y)
            
            // Interacao em cada linha da matriz
            for (positionLine, x) in xData.enumerated() {
                let yPredict = predict(data: x, isTrain: true)
                
                print("Predict \(yPredict) - Y \(y[positionLine])")
                
                if yPredict != y[positionLine] {
                    updateWeights(x: xData[positionLine], y: y[positionLine], yPredict: yPredict)
                    hadErros.append(true)
                } else {
                    hadErros.append(false)
                }
            }
            
            // Caso nao exista erro, entao o treinamento termina
            if !hadErros.contains(true) {
                return
            }
        }
        
    }
    
    private func degree(sum: Double) -> Int {
        return sum >= 0 ? 1 : 0
    }
    
    private func updateWeights(x: [Double], y: Int, yPredict: Int) {
        let error = y - yPredict
        
        // Para cada posicao, atualiza o peso de acordo com a formula: w = w + (nex)
        for index in 0..<x.count {
            weights[index] += (rate * Double(error) * x[index])
        }
    }
    
    private func randomizeDataset(x: [[Double]], y: [Int]) -> ([[Double]], [Int]) {
        var indexs = Array(0...x.count - 1)
        var randomX = [[Double]]()
        var randomY = [Int]()
        
        while(!indexs.isEmpty) {
            let randomIndex = indexs.randomElement()!
            
            if let i = indexs.firstIndex(of: randomIndex) {
                indexs.remove(at: i)
            }
            
            randomY.append(y[randomIndex])
            randomX.append(x[randomIndex])
        }
        
        return (randomX, randomY)
    }
}
