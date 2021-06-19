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
    
    init(rate: Double = 0.5, epochs: Int = 10000) {
        self.rate = rate
        self.epochs = epochs
    }
    
    func predict(data: [Double]) -> Int {
        var sumOfWeightsMultipliedData: Double = 0.0
        
        for (position, x) in data.enumerated() {
            sumOfWeightsMultipliedData += x * weights[position]
        }
        
        return degree(sum: sumOfWeightsMultipliedData)
    }
    
    func train(data: [[Double]], targets: [Int]) {
        var hadErros = [Bool]()
        
        // Inicializando o vetor de pesos com valores aleatorios
        data[0].forEach { _ in
            weights.append(Double.random(in: -1...1))
        }
        
        for epoch in 0...epochs {
            hadErros = []
            
            print("Epoch \(epoch) \nWeights \(weights)\n\n")
            
            // Interacao em cada linha da matriz
            for (positionLine, line) in data.enumerated() {
                let sinal = predict(data: line)
                
                print("\(sinal) \(targets[positionLine])")
                
                if sinal != targets[positionLine] {
                    updateWeights(xData: data[positionLine], expectSinal: targets[positionLine], realSinal: sinal)
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
    
    private func updateWeights(xData: [Double], expectSinal: Int, realSinal: Int) {
        let error = expectSinal - realSinal
        
        // Para cada posicao, atualiza o peso de acordo com a formula: w = w + (nex)
        for (position, x) in xData.enumerated() {
            weights[position] += (rate * Double(error) * x)
        }
    }
}
