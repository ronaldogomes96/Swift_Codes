//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Ronaldo Gomes on 01/05/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

    //MARK: Meal Class Tests
    
    //Teste para o inicializador do meal.swift, positivo
    func testMealInitializationSucceeds(){
        
        //Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        //Classificacao mais alta
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    //Teste para o inicializador do meal.swift, negativo
    func testMealInitializationFails(){
        
        //Classificacao negativa
        let negativeRatingMeal = Meal.init(name: "Negarive", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // Rating exedeu o maximo
        let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
        //String vazia
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
    }
}
