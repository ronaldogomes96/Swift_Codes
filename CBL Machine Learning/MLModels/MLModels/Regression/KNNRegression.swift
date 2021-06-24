//
//  KNNRegression.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 24/06/21.
//

import Foundation

class KNNRegression: KNN {
    override func mostFrequentTarget(y: [Double], kIndexs: [Int]) -> Double {
        let yFrequency = kIndexs.map { y[$0] }
        let statistic = Statistic()
        return statistic.mean(xData: [yFrequency])
    }
}
