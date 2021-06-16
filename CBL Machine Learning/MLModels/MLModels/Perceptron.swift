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
        var sumOfWeights: Double = 0.0
        
        for (position, x) in data.enumerated() {
            sumOfWeights += x * weights[position]
        }
        
        return degree(sum: sumOfWeights)
    }
    
    func train(data: [[Double]], targets: [Int]) {
        var sumOfWeights: Double = 0.0
        var hadErros = [Bool]()
        
        data[0].forEach { _ in
            weights.append(Double.random(in: -1...1))
        }
        
        for epoch in 0...epochs {
            hadErros = []
            
            for (positionLine, line) in data.enumerated() {
                for (posi, x) in line.enumerated() {
                    sumOfWeights += x * weights[posi]
                }
                
                let sinal = degree(sum: sumOfWeights)
                print("\(sinal) \(targets[positionLine])")
                
                if sinal != targets[positionLine] {
                    updateWeights(xData: data[positionLine], expectSinal: targets[positionLine], realSinal: sinal)
                    hadErros.append(true)
                } else {
                    hadErros.append(false)
                }
            }
            
            print("Epoch \(epoch) \nWeights \(weights)\n\n")
            
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
        for (position, x) in xData.enumerated() {
            weights[position] = weights[position] + (rate * Double(error) * x)
        }
    }
}
