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
        var sumOfWeightsMultipliedData: Double = 0.0
        
        for (position, x) in data.enumerated() {
            sumOfWeightsMultipliedData += x * weights[position]
        }
        
        return sumOfWeightsMultipliedData
    }
    
    func train(data: [[Double]], targets: [Double]) {
        var errors = [Double]()
        var coast = [Double]()
        
        // Inicializando o vetor de pesos com valores aleatorios
        data[0].forEach { _ in
            weights.append(Double.random(in: -1...1))
        }
        
        for epoch in 0...epochs {
            // Interacao em cada linha da matriz
            for (position, xData) in data.enumerated() {
        
                // A cada interacao é calculado o erro, gradiente descedente e entao atualizado os pesos
                let result = predict(data: xData)
                let error = result - targets[position]
                let gradientVector = gradientDescentVector(xData: xData, erro: error)
                
                errors.append(error)
                atualizeWeights(gradientVector: gradientVector)
            }
            
            print("Epoch \(epoch) weight \(weights) \n\n")
            
            // Atualiza o array de custo
            coast.append(calculateCoast(errors: errors))
            if epoch >= 1 {
                
                // Se o custo esta estabilizado, entao o treinamento termina
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
        // Para cada posicao, atualiza o peso de acordo com a formula: w = w - ((n / m) * gradiente)
        for index in 0..<weights.count {
            weights[index] -= ((rate / Double(gradientVector.count)) * gradientVector[index])
        }
    }
    
    private func calculateCoast(errors: [Double]) -> Double {
        var quadractureErros = 0.0
        for error in errors {
            quadractureErros += pow(error, 2.0)
        }
        
        // Retorna o erro de custo de acordo com o MSE
        return quadractureErros / Double((2 * errors.count))
    }
}
