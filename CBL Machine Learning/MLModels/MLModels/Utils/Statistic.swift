//
//  Statistic.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 22/06/21.
//

import Foundation

class Statistic {
    // Variaveis de classe que servem para guardar os valores do objeto
    private var mean: Double = 0.0
    private var std: Double = 0.0
    private var xMin = Double.infinity
    private var xMax = 0.0
    
    // MinMax Scaler
    // Formula: x = (x - xMin) / (xMax - xMin)
    // Todas as variaveis ficam entre 0 e 1. Caso exista valor negativo, fica entre -1 e 1
    func normalize(data: [[Double]]) -> [[Double]] {
        var xData = data
        
        // Verifica o max e min de toda o dataset
        for index in 0..<xData.count {
            if xData[index].min()! < xMin {
                xMin = xData[index].min()!
            }
            if xData[index].max()! > xMax {
                xMax = xData[index].max()!
            }
        }
        
        // Calcula a formula para cada elemento
        for index in 0..<xData.count {
            for (pos, x) in xData[index].enumerated() {
                xData[index][pos] = (x - xMin) / (xMax - xMin)
            }
        }
        
        return xData
    }
    
    // Transforma os valores para normalizacao, de acordo com os valores ja salvos do dataset
    func trasnformForNormalized(data: [Double]) -> [Double] {
        var xData = data
        
        for (pos, x) in xData.enumerated() {
            xData[pos] = (x - xMin) / (xMax - xMin)
        }
        
        return xData
    }
    
    // Padronizacao - Z score
    // Formula: z = x - u / o
    // O objetivo é fazer o dataset ficar com media 0 e desvio padrao 1
    func standardize(data: [[Double]]) -> [[Double]] {
        var xData = data
        mean = mean(xData: xData)
        std = standardDeviation(xData: xData, mean: mean)

        for index in 0..<xData.count {
            for (pos, x) in xData[index].enumerated() {
                xData[index][pos] = (x - mean) / std
            }
        }

        return xData
    }
    
    // Calcula a media do dataset
    func mean(xData: [[Double]]) -> Double {
        var sumOfX = 0.0
        let numberOfElements = xData.count * xData[0].count
        
        for index in 0..<xData.count {
            for (_, x) in xData[index].enumerated() {
                sumOfX += x
            }
        }
        
        return sumOfX / Double(numberOfElements)
    }
    
    // Calcula o desvio padrao do dataset
    func standardDeviation(xData: [[Double]], mean: Double? = nil) -> Double {
        let mean = mean ?? self.mean(xData: xData)
        var squareResults = 0.0
        let numberOfElements = xData.count * xData[0].count
        
        for index in 0..<xData.count {
            for (_, x) in xData[index].enumerated() {
                squareResults += (pow((x - mean), 2.0))
            }
        }
        
        return sqrt((squareResults / Double(numberOfElements)))
    }
}
