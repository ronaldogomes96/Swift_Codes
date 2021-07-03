//
//  DMC.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 03/07/21.
//

import Foundation

class DMC {
    private var centroids = [Double: [Double]]()
    
    func train(data: [[Double]], targets: [Double]) {
        let uniqueY = Set(targets)
        
        for y in uniqueY {
            var sumOfXM = [Double]()
            centroids[y] = [Double]()
            
            for (position, xData) in data.enumerated() {
                if targets[position] == y {
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
                centroids[y]?.append(x / Double(sumOfXM.count))
            }
        }
    }
    
    func predict(data: [Double]) -> Double {
        var yResult = 0.0
        var minEuclidianDistance = Double.infinity
        
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
        
        return yResult
    }
}
