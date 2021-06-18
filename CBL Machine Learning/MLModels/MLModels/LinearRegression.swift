//
//  LinearRegression.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 17/06/21.
//

import Foundation

class LinearRegression {
    private var weights = [Double]()
    private var rate: Double
    private var epochs: Int
    
    init(rate: Double = 0.5, epochs: Int = 10000) {
        self.rate = rate
        self.epochs = epochs
    }
    
    func predict(data: [Double]) -> Double {
        var sumOfWeights: Double = 0.0
        
        for (position, x) in data.enumerated() {
            sumOfWeights += x * weights[position]
        }
        
        return sumOfWeights
    }
    
    func train(data: [[Double]], targets: [Double]) {
        var errosr = [Double]()
        var yResust: Double = 0.0
        var coast = [Double]()
        
        data[0].forEach { _ in
            weights.append(Double.random(in: -1...1))
        }
        
        for epoch in 0...epochs {
            for (position, xData) in data.enumerated() {
                for (positionLine, x) in xData.enumerated() {
                    yResust = x * weights[positionLine]
                }
                
                errosr.append(yResust - targets[position])
                let gradientVector = gradientDescentVector(xData: xData, erro: yResust - targets[position])
                atualizeWeights(gradientVector: gradientVector)
            }
            print("Epoch \(epoch) weight \(weights) \n\n")
            coast.append(calculateCoast(errors: errosr))
            if epoch >= 1 {
                //COLOCAR EM MODULO E DIMINUIR
                if abs((coast[epoch] - coast[epoch - 1])) > 0.00005{
                    break
                }
            }
        }
    }
    
    
    private func gradientDescentVector(xData: [Double], erro: Double) -> [Double] {
        var gradientVector = [Double]()
        for x in xData {
            gradientVector.append(x * erro)
        }
        
        return gradientVector
    }
    
    private func atualizeWeights(gradientVector: [Double]) {
        for index in 0..<weights.count {
            weights[index] -= ((rate / Double(gradientVector.count)) * gradientVector[index])
        }
    }
    
    private func calculateCoast(errors: [Double]) -> Double {
        var quadractureErros = 0.0
        for error in errors {
            quadractureErros += pow(error, 2.0)
        }
        
        return quadractureErros / Double((2 * errors.count))
    }
}
