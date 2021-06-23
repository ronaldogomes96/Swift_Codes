//
//  RegressionData.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 22/06/21.
//

import Foundation

struct RegressionData {
    
    // MARK: - Linear Regression
    func runInternetDatabase() {
        // Dataset
        let x: [[Double]] = [[0, 1],
                             [5, 1],
                             [25, 5], [35, 11], [45, 15], [55, 34], [60, 35]]
        let y: [Double] = [4, 5, 14, 32, 22, 38, 43]
        
        // Pre processing
        let statistic = Statistic()
        let xScalar = statistic.normalize(data: x)
        let xTest = statistic.trasnformForNormalized(data: [15 ,2])
        
        // Train
        let regression = LinearRegression()
        regression.train(data: xScalar, targets: y)
        
        // Predict
        print(regression.predict(data: xTest)) //20
    }
    
    func runPression() {
        // Dataset
        var pressao = ReadFiles.read(fileName: "pressao", type: "txt")
        
        // Data clean
        pressao.removeFirst()
        let x = pressao.compactMap { [Double($0.first!)!] }
        let y = pressao.compactMap { Double($0.last!) }
        
        // Pre processing
        let statistic = Statistic()
        let xScalar = statistic.normalize(data: x)
        let xTest = statistic.trasnformForNormalized(data: [42])

        // Train
        let regression = LinearRegression()
        regression.train(data: xScalar, targets: y)

        // Predict
        print(regression.predict(data: xTest)) //128
    }
    
    func runFirstDegreeEquation() {
        // Dataset
        var fisrtDegree = ReadFiles.read(fileName: "EquacaoPrimeiroGrau", type: "csv")
        
        // Data clean
        fisrtDegree.removeFirst()
        let x = fisrtDegree.compactMap { [Double($0.first!)!] }
        let y = fisrtDegree.compactMap { Double($0.last!) }
        
        // Pre processing
        let statistic = Statistic()
        let xScalar = statistic.normalize(data: x)
        let xTest = statistic.trasnformForNormalized(data: [-10])
        
        // Train
        let regression = LinearRegression()
        regression.train(data: xScalar, targets: y)

        // Pre processing
        print(regression.predict(data: xTest))
    }
    
    func runFish() {
        // Dataset
        var fish = ReadFiles.read(fileName: "peixe", type: "txt")
        
        // Data clean
        fish.removeFirst()
        let x = fish.compactMap { [Double($0[0])!, Double($0[1])!] }
        let y = fish.compactMap { Double($0.last!) }
        
        // Pre processing
        let statistic = Statistic()
        let xScalar = statistic.normalize(data: x)
        let xTest = statistic.trasnformForNormalized(data: [83, 27]) // 83,27
        
        // Train
        let regression = LinearRegression(epochs: 1000)
        regression.train(data: xScalar, targets: y)

        // Predict
        print(regression.predict(data: xTest)) //4015
    }
}
