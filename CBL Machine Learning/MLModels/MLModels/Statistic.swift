//
//  Statistic.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 22/06/21.
//

import Foundation

class Statistic {
    func normalize(data: [[Double]]) -> [[Double]] {
        var xData = data
        var xMin = Double.infinity
        var xMax = 0.0
        
        for index in 0..<xData.count {
            if xData[index].min()! < xMin {
                xMin = xData[index].min()!
            }
            if xData[index].max()! > xMax {
                xMax = xData[index].max()!
            }
        }
        
        for index in 0..<xData.count {
            for (pos, x) in xData[index].enumerated() {
                xData[index][pos] = (x - xMin) / (xMax - xMin)
            }
        }
        
        return xData
    }
    
    func standardize(data: [[Double]]) -> [[Double]] {
        var xData = data
        
        for index in 0..<xData.count {
            let mean = mean(xData: xData[index])
            let std = standardDeviation(xData: xData[index], mean: mean)
            
            for (pos, x) in xData[index].enumerated() {
                xData[index][pos] = (x - mean) / std
            }
        }
        
        return xData
    }
    
    func mean(xData: [Double]) -> Double {
        var sumOfX = 0.0
        for (_, x) in xData.enumerated() {
            sumOfX += x
        }
        
        return sumOfX / Double(xData.count)
    }
    
    func standardDeviation(xData: [Double], mean: Double) -> Double {
        var squareResults = 0.0
        
        for (_, x) in xData.enumerated() {
            squareResults += (pow((x - mean), 2.0))
        }
        
        return sqrt((squareResults / Double(xData.count)))
    }
}
