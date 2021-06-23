//
//  KNN.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 19/06/21.
//

import Foundation

class KNN {
//    private let k: Int
//    private var data = [[Double]]()
//    private var targets = [Double]()
//    
//    init(KNeighbors: Int) {
//        self.k = KNeighbors
//    }
//    
//    func train(data: [[Double]], targets: [Double]) {
//        self.data = data
//        self.targets = targets
//    }
//    
//    func predict(x: [Double]) -> Double {
//        var kDistances = [Double]()
//        
//        for dataLine in 0...data.count {
//            var sum = 0.0
//            for dataColumn in 0...x.count {
//                sum += pow(x[dataColumn] - data[dataLine][dataColumn], 2.0)
//            }
//            
//            let newDistance = sqrt(sum)
//            
//            kDistances = getKMinorDistancesFor(newDistance: newDistance, oldDistances: kDistances)
//        }
//        
//        
//    }
//    
//    private func getKMinorDistancesFor(newDistance: Double, oldDistances: [Double], ) -> [Double] {
//        var orderDistances = oldDistances
//        
//        if orderDistances.isEmpty {
//            orderDistances.append(newDistance)
//            return orderDistances
//        }
//        
//        if orderDistances.count <= k {
//            orderDistances = orderDistancesArray(newValue: newDistance, actualDistances: orderDistances)
//        } else {
//            if newDistance > orderDistances[k - 1] {
//                return orderDistances
//            }
//            else {
//                orderDistances.removeLast()
//                
//                orderDistances = orderDistancesArray(newValue: newDistance, actualDistances: orderDistances)
//            }
//        }
//        
//        return orderDistances
//    }
//    
//    private func orderDistancesArray(newValue: Double, actualDistances: [Double]) -> [Double] {
//        var newDistanceArray = actualDistances
//        for index in 0..<newDistanceArray.count {
//            if newValue < newDistanceArray[index] {
//                newDistanceArray.insert(newValue, at: index)
//            }
//            else if index == newDistanceArray.endIndex {
//                newDistanceArray.append(newValue)
//            }
//        }
//        
//        return newDistanceArray
//    }
//    
//    private mostFrequentTarget(distances: [Double]) {
//        
//    }
}
