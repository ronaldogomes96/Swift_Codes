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
    
    init(KNeighbors: Int = 3) {
        self.k = KNeighbors
    }
    
    func train(data: [[Double]], targets: [Double]) {
        // O treinamento da KNN consiste apenas em guardar os valores recebidos
        self.data = data
        self.targets = targets
    }
    
    func predict(x: [Double]) -> Double {
        for dataLine in 0..<data.count {
            var sum = 0.0
            for dataColumn in 0..<x.count {
                // Somatoria dos valores de (xi - xj)ˆ2
                // Onde xi é o valor do x para predicao e xj é o valor de x da base de treino
                sum += pow(x[dataColumn] - data[dataLine][dataColumn], 2.0)
            }
            
            // Calcula a distancia euclidiana como a raiz da somatoria
            let newDistance = sqrt(sum)
            
            // Processo que verifica se a distancia esta dentro das K menores e
            // se sim coloca na posicao ordenada do array, alem de guardar o index do respectivo target
            updateKValues(for: newDistance, inPosition: dataLine)
        }
        
        return mostFrequentTarget(y: targets, kIndexs: kIndexsClasses)
    }
    
    private func updateKValues(for newDistance: Double, inPosition index: Int) {
        // Caso vazio, iniciamos os arrays
        if kDistances.isEmpty {
            kDistances.append(newDistance)
            kIndexsClasses.append(index)
        }
        // Caso menor que k, colocamos ele na ordem correta
        else if kDistances.count <= k {
            orderArrays(for: newDistance, and: index)
        }
        // Caso seja menor que o ultimo (Logo o maior valor), remove o ultimo e add o novo valor em ordem
        else if newDistance < kDistances.last! {
            kDistances.removeLast()
            kIndexsClasses.removeLast()
            orderArrays(for: newDistance, and: index)
        }
    }
    
    private func orderArrays(for newValue: Double, and position: Int) {
        // Ordena o array do menor valor para o maior
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
    
    func mostFrequentTarget(y: [Double], kIndexs: [Int]) -> Double {
        // Acha os Y com os indices dos menores valores
        let y = kIndexs.map { y[$0] }
        // Array de tuplas com o valor do target e seu indice
        let yMappedItems = y.map { ($0, 1) }
        // Dicionario com as tuplas, porem com valores unicos. Ou seja, se um valor aparece duas vezes, ele tera o valor 2
        let yDict = Dictionary(yMappedItems, uniquingKeysWith: +)
        // O respectivo dic do maior valor
        let mostFrequenty = yDict.filter { $0.value == yDict.values.max() }
        // Retorna a key(target) do maior valor
        return mostFrequenty.first?.key ?? 0
    }
}
