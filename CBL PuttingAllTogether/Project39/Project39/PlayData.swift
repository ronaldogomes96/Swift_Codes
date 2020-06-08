//
//  PlayData.swift
//  Project39
//
//  Created by Ronaldo Gomes on 06/06/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation

class PlayData {
    
    //Todas as palavras do arquivo
    var allWords = [String]()
    //A quantidade de vez que cada palavra aparece
    var wordCounts: NSCountedSet!
    //Palavras filtradas pelo usuario
    private (set) var filteredWords = [String]()

    
    init() {
        if let path = Bundle.main.path(forResource: "plays", ofType: "txt") {
            if let plays = try? String(contentsOfFile: path) {
                //Pega todos os caracteres do arquivo
                allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
                
                //Filtra somente strings com algum valor
                allWords = allWords.filter { $0 != "" }
                
                //Conjunto de palavras sem haver duplicada
                wordCounts = NSCountedSet(array: allWords)
                //Atualiza allWords por ordem
                let sorted = wordCounts.allObjects.sorted { wordCounts.count(for: $0) > wordCounts.count(for: $1) }
                allWords = sorted as! [String]
            }
        }
    }
    
    //Aplica o filtro que o usuario ira digitar, ou de numero de palavras ou do numero de vezes que ela aparece
    func applyUserFilter(_ input: String) {
        
        //Se ele for um numero
        if let userNumber = Int(input){
            applyFilter { self.wordCounts.count(for: $0) >= userNumber }
        }
        //Se for uma string
        else {
            applyFilter { $0.range(of: input, options: .caseInsensitive) != nil }
        }
    }
    
    //Funcao que faz a mudanca na variavel filterwords
    func applyFilter(_ filter: (String) -> Bool) {
        filteredWords = allWords.filter(filter)
    }
}
