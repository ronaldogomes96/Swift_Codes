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
        XCTAssertEqual(playData.allWords.count, 0, "allWords must be 0")
    }
}
