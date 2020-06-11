//
//  Project39Tests.swift
//  Project39Tests
//
//  Created by Ronaldo Gomes on 06/06/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import XCTest
@testable import Project39

class Project39Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    //Funcao que verifica se todas as palavras foram carregadas
    func testAllWordsLoaded(){
        let playData = PlayData()
        
        /*
            XCTAssertEqual verifica se o primeiro parametro é igual ao segundo
            Caso nao seja, o teste falhara e imprimira a mensagem "allWords must be 0"
         */
        XCTAssertEqual(playData.allWords.count, 18440, "allWords must be 18440")
    }
    
    //Funcao que verifica se a palavra apareceu no numero correto de vezes
    func testWordCountsAreCorrect() {
        let playData = PlayData()
        
        //Verifica se cada palavra aparece neste numero de vezes
        XCTAssertEqual(playData.wordCounts.count(for: "home"), 174, "Home does not appear 174 times")
        XCTAssertEqual(playData.wordCounts.count(for: "fun"), 4, "Fun does not appear 4 times")
        XCTAssertEqual(playData.wordCounts.count(for: "mortal"), 41, "Mortal does not appear 41 times")
    }
    
    //Verifica se o numero de palavras esta correto
    func testUserFilterWorks() {
        
        let playData = PlayData()
        
        playData.applyUserFilter("100")
        //Indica que 495 palavras aparecem pelo menos 100 vezes
        XCTAssertEqual(playData.filteredWords.count, 495)
        
        playData.applyUserFilter("1000")
        XCTAssertEqual(playData.filteredWords.count, 55)

        playData.applyUserFilter("10000")
        XCTAssertEqual(playData.filteredWords.count, 1)
        
        //Indica que a palavra teste aparece 56 vezes
        playData.applyUserFilter("test")
        XCTAssertEqual(playData.filteredWords.count, 56)
        
        playData.applyUserFilter("swift")
        XCTAssertEqual(playData.filteredWords.count, 7)
        
        playData.applyUserFilter("objective-c")
        XCTAssertEqual(playData.filteredWords.count, 0)
    }
    
    //Verifica a velocidade e desempenho
    func testWordsLoadQuickly() {
        measure {
            _ = PlayData()
        }
    }
}
