//
//  KNNRegression.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 24/06/21.
//

import Foundation

class KNNRegression: KNN {
    // A unica diferenca da KNN de regressao é que nesta funcao é calculada a media dos K vizinhos
    override func mostFrequentTarget(y: [Double], kIndexs: [Int]) -> Double {
        let yFrequency = kIndexs.map { y[$0] }
        let statistic = Statistic()
        return statistic.mean(xData: [yFrequency])
    }
}
