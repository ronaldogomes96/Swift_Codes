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
}
