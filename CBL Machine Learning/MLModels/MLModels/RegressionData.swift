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
        let x: [[Double]] = [[0, 1],
                             [5, 1],
                             [25, 5], [35, 11], [45, 15], [55, 34], [60, 35]]
        let y: [Double] = [4, 5, 14, 32, 22, 38, 43]
        
        let regression = LinearRegression()
        let statistic = Statistic()

        let xScalar = statistic.normalize(data: x)
        print(xScalar)
        regression.train(data: xScalar, targets: y)
        
        let xTest = statistic.trasnform(data: [15 ,2])
        print(regression.predict(data: xTest)) //20
    }
    
    func runPression() {
        var pressao = ReadFiles.read(fileName: "pressao", type: "txt")
        
        pressao.removeFirst()
        
        let xPressao = pressao.compactMap { [Double($0.first!)!] }
        let yPressao = pressao.compactMap { Double($0.last!) }
        print(xPressao)
        print(yPressao)
        
        let regression = LinearRegression()
        let statistic = Statistic()

        let xScalar = statistic.normalize(data: xPressao)
        print(xScalar)
        regression.train(data: xScalar, targets: yPressao)

        let xTest = statistic.trasnform(data: [42])
        print(regression.predict(data: xTest)) //128
    }
    
    func runFirstDegreeEquation() {
        var fisrtDegree = ReadFiles.read(fileName: "EquacaoPrimeiroGrau", type: "csv")
        
        fisrtDegree.removeFirst()
        
        let x = fisrtDegree.compactMap { [Double($0.first!)!] }
        let y = fisrtDegree.compactMap { Double($0.last!) }
        print(x)
        print(y)
        
        let regression = LinearRegression()
        let statistic = Statistic()

        let xScalar = statistic.normalize(data: x)
        regression.train(data: xScalar, targets: y)

        let xTest = statistic.trasnform(data: [-10])
        print(regression.predict(data: xTest))
    }
}
