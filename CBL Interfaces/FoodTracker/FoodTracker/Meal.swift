//
//  Meal.swift
//  FoodTracker
//
//  Created by Ronaldo Gomes on 02/05/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //MARK: Propeties
    
    var name : String
    var photo: UIImage?
    var rating : Int
    
    //MARK: Archiving Paths
    
    //Este é um diretório em que seu aplicativo pode salvar dados para o usuário
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    
    struct PropertyKey {
        
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
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
    
    //MARK: NSCoding
    
    //Prepara as informações da classe para serem arquivadas
    func encode(with coder: NSCoder) {
        
        //Codificam o valor de cada propriedade na classe Meal e as armazenam com sua chave correspondente.
        coder.encode(name, forKey: PropertyKey.name)
        coder.encode(photo, forKey: PropertyKey.photo)
        coder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder: NSCoder) {
        
        //Decodifica o nome
        guard let name = coder.decodeObject(forKey: PropertyKey.name) as? String else{
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        //Decodifica a photo
        let photo = coder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        //Decodifica o rating
        let rating = coder.decodeInteger(forKey: PropertyKey.rating)
        
        //Transmite os valores das constantes criadas enquanto arquiva os dados salvos.
        self.init(name: name, photo: photo, rating: rating)
    }
}
