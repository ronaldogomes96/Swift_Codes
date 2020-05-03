//
//  Meal.swift
//  FoodTracker
//
//  Created by Ronaldo Gomes on 02/05/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Propeties
    
    var name : String
    var photo: UIImage?
    var rating : Int
    
    
    //MARK: Initializations
    
    init?(name: String, photo: UIImage?, rating: Int){
        
        //A inicialização falhará se não houver nome ou se a classificação for negativa ou maior que 5
        //
        guard !name.isEmpty else {
            return nil
        }
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        //Inicializa as propiedades armazenadas
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    
}
