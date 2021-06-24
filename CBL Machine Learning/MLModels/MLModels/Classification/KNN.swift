//
//  KNN.swift
//  MLModels
//
//  Created by Ronaldo Gomes on 19/06/21.
//

import Foundation

class KNN {
    private let k: Int
    private var data = [[Double]]()
    private var targets = [Double]()
    private var kDistances = [Double]()
    private var kIndexsClasses = [Int]()
    
    init(KNeighbors: Int) {
        self.k = KNeighbors
    }
    
    func train(data: [[Double]], targets: [Double]) {
        self.data = data
        self.targets = targets
    }
    
    func predict(x: [Double]) -> Double {
        for dataLine in 0...data.count {
            var sum = 0.0
            for dataColumn in 0...x.count {
                sum += pow(x[dataColumn] - data[dataLine][dataColumn], 2.0)
            }
            
            let newDistance = sqrt(sum)
            
            // Temho que passar a distancia e retornar o indice da classe no target
            // Talvez transformar em variavel de classe
            updateKValues(for: newDistance, inPosition: dataLine)
        }
        
        return mostFrequentTarget()
    }
    
    private func updateKValues(for newDistance: Double, inPosition index: Int) {
        if kDistances.isEmpty {
            kDistances.append(newDistance)
            kIndexsClasses.append(index)
        }
        else if kDistances.count <= k {
            orderArrays(for: newDistance, and: index)
        }
        else if newDistance < kDistances.last! {
            kDistances.removeLast()
            kIndexsClasses.removeLast()
            orderArrays(for: newDistance, and: index)
        }
    }
    
    private func orderArrays(for newValue: Double, and position: Int) {
        for index in 0..<kDistances.count {
            if newValue < kDistances[index] {
                kDistances.insert(newValue, at: index)
                kIndexsClasses.insert(position, at: index)
            }
            else if index == kDistances.endIndex {
                kDistances.append(newValue)
                kIndexsClasses.append(position)
            }
        }
    }
    
    private func mostFrequentTarget() -> Double {
        let y = kIndexsClasses.map { targets[$0] }
        let yMappedItems = y.map { ($0, 1) }
        let yDict = Dictionary(yMappedItems, uniquingKeysWith: +)
        let mostFrequenty = yDict.filter { $0.value == yDict.values.max() }
        return mostFrequenty.first?.key ?? 0
    }
}
