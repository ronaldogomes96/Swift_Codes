//
//  DMC.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 03/07/21.
//

import Foundation

class DMC {
    // Dicionario com a classe do centroide e as coordenadas do centroide
    private var centroids = [Double: [Double]]()
    
    func train(data: [[Double]], targets: [Double]) {
        let uniqueY = Set(targets)
        
        // Para cada valor unico de Y temos que calcular o centroide dele
        for y in uniqueY {
            
            var sumOfXM = [Double]()
            // Cria a instancia especifica do dicionario de centroide
            centroids[y] = [Double]()
            
            for (position, xData) in data.enumerated() {
                // Caso a linha seja do y especifico
                if targets[position] == y {
                    // Calculo da somatoria
                    for (index, x) in xData.enumerated() {
                        if sumOfXM.count != xData.count {
                            sumOfXM.append(x)
                        } else {
                            sumOfXM[index] += x
                        }
                    }
                }
            }
            
            for x in sumOfXM {
                // Calculo do centro de massa
                centroids[y]?.append(x / Double(sumOfXM.count))
            }
        }
    }
    
    func predict(data: [Double]) -> Double {
        var yResult = 0.0
        var minEuclidianDistance = Double.infinity
        
        // Calcula a distancia euclidiana para cada centroide
        for y in centroids {
            var sum = 0.0
            for (index, xTrain) in y.value.enumerated() {
                sum += pow(data[index] - xTrain, 2.0)
            }
            
            let newDistance = sqrt(sum)
            
            if newDistance < minEuclidianDistance {
                minEuclidianDistance = newDistance
                yResult = y.key
            }
        }
        
        // Retorna o menor
        return yResult
    }
}
