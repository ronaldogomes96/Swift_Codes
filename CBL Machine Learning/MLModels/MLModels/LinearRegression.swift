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
    
    init(rate: Double = 0.2, epochs: Int = 10000) {
        self.rate = rate
        self.epochs = epochs
    }
    
    func predict(data: [Double], isTrain: Bool = false) -> Double {
        var sumOfWeightsMultipliedData: Double = 0.0
        var xData = data
        
        // Caso nao seja o treino, tem que adicionar o valor do bias
        if !isTrain {
            xData.append(-1)
        }
        
        for (position, x) in xData.enumerated() {
            sumOfWeightsMultipliedData += x * weights[position]
        }
        
        return sumOfWeightsMultipliedData
    }
    
    func train(data: [[Double]], targets: [Double]) {
        var errors = [Double]()
        var xData = data
        var y = targets
        var coast = [Double]()
        
        for index in 0..<xData.count {
            // Adiciona os bias ao fim de cada linha
            xData[index].append(-1)
        }
        
        // Inicializando o vetor de pesos com valores aleatorios
        xData[0].forEach { _ in
            weights.append(Double.random(in: -1...1))
        }
        
        for epoch in 0...epochs {
            
            // Randomiza o dataset, juntamente com os valores de Y
            (xData, y) = randomizeDataset(x: xData, y: y)
            
            // Interacao em cada linha da matriz
            for (position, x) in xData.enumerated() {
        
                // A cada interacao é calculado o erro, gradiente descedente e entao atualizado os pesos
                let yPredict = predict(data: x, isTrain: true)
                let error = y[position] - yPredict
                let gradientVector = gradientDescentVector(x: x, erro: error)
                
                errors.append(error)
                atualizeWeights(gradientVector: gradientVector)
            }
            
            print("Epoch \(epoch) weight \(weights) \n\n")
            
            // Atualiza o array de custo
            coast.append(calculateCoast(errors: errors))
            if epoch >= 1 {
                print(coast)
                // Se o custo esta estabilizado, entao o treinamento termina
                if abs((coast[epoch] - coast[epoch - 1])) < 3{
                    break
                }
            }
        }
    }
    
    
    private func gradientDescentVector(x: [Double], erro: Double) -> [Double] {
        var gradientVector = [Double]()
        for index in 0..<x.count {
            gradientVector.append(x[index] * erro)
        }
        
        return gradientVector
    }
    
    private func atualizeWeights(gradientVector: [Double]) {
        // Para cada posicao, atualiza o peso de acordo com a formula: w = w - ((n / m) * gradiente)
        for index in 0..<weights.count {
            weights[index] += ((rate) * gradientVector[index])
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
    
    private func randomizeDataset(x: [[Double]], y: [Double]) -> ([[Double]], [Double]) {
        var indexs = Array(0...x.count - 1)
        var randomX = [[Double]]()
        var randomY = [Double]()
        
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
