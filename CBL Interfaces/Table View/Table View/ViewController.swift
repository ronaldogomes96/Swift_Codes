//
//  ViewController.swift
//  Table View
//
//  Created by Ronaldo Gomes on 30/04/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var fruits: [String] = []
    var alphabetizedFruits = [String: [String]]()
    let cellIdentifier = "CellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fruits = ["Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Pear", "Kiwi", "Strawberry", "Mango", "Walnut", "Apricot", "Tomato", "Almond", "Date", "Melon", "Water Melon", "Lemon", "Coconut", "Fig", "Passionfruit", "Star Fruit", "Clementin", "Citron", "Cherry", "Cranberry"]
        
        alphabetizedFruits = alphabetizeArray(array: fruits)

    }
    
    private func alphabetizeArray(array: [String]) -> [String: [String]] {
        var result = [String: [String]]()
         
        for item in array {
            
            let firstLetter = item.first!.uppercased()
             
            if result[firstLetter] != nil {
                result[firstLetter]!.append(item)
            } else {
                result[firstLetter] = [item]
            }
        }
         
//        for (key, var value) in result {
//            result[key] = value.sort({ (a, b) -> Bool in
//                (a.lowercaseString) < (b.lowercaseString)
//            })
//        }
         
        return result
    }
    
    
    //Retorna o numero de secoes (grupo de linhas) que tera nesta table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return alphabetizedFruits.keys.count
    }
    
    //Retorna o numero de linhas que tera em cada secao
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = alphabetizedFruits.keys
         
        // Sort Keys
        let sortedKeys = keys.sorted(by: { (a, b) -> Bool in
            return true
        })
         
        // Fetch Fruits
        let key = sortedKeys[section]
         
        if let fruits = alphabetizedFruits[key] {
            return fruits.count
        }
         
        return 0
    }
    
    // Criacao da celula da table View
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
         
        // Fetch and Sort Keys
        let keys = alphabetizedFruits.keys.sorted( by: { (a, b) -> Bool in
            true
        })
         
        // Fetch Fruits for Section
        let key = keys[indexPath.section]
         
        if let fruits = alphabetizedFruits[key] {
            // Fetch Fruit
            let fruit = fruits[indexPath.row]
             
            // Configure Cell
            cell.textLabel?.text = fruit
        }
         
        return cell
    }
    
    //Mostra o titulo em cada secao
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        // Fetch and Sort Keys
        let keys = alphabetizedFruits.keys.sorted( by: { (a, b) -> Bool in
            true
        })
         
        return keys[section]
    }
    
    //Metodo delegate, e mostra na tela qual a fruta que foi clicada
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Fetch and Sort Keys
        let keys = alphabetizedFruits.keys.sorted( by: { (a, b) -> Bool in
            true
        })
         
        // Fetch Fruits for Section
        let key = keys[indexPath.section]
         
        if let fruits = alphabetizedFruits[key] {
            print(fruits[indexPath.row])
        }
    }

}

