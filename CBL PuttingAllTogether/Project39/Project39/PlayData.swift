//
//  PlayData.swift
//  Project39
//
//  Created by Ronaldo Gomes on 06/06/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import Foundation

class PlayData {
    var allWords = [String]()
    
    init() {
        if let path = Bundle.main.path(forResource: "plays", ofType: "txt") {
            if let plays = try? String(contentsOfFile: path) {
                //Pega todos os caracteres do arquivo
                allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
                
                //Filtra somente strings com algum valor
                allWords = allWords.filter { $0 != "" }
            }
        }
    }
}
