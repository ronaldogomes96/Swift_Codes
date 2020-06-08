//
//  ViewController.swift
//  Project39
//
//  Created by Ronaldo Gomes on 06/06/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var playData = PlayData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Adiciona o botao para subir a alert
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playData.filteredWords.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //Imprime cada palavra que o usuario digitou na tela
        let word = playData.filteredWords[indexPath.row]
        cell.textLabel!.text = word
        cell.detailTextLabel!.text = "\(playData.wordCounts.count(for: word))"
        return cell
    }
    
    @objc func searchTapped() {
        
        //Cria o alert controler
        let ac = UIAlertController(title: "Filter...", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Filter", style: .default) {[unowned self] _ in
            let userInput = ac.textFields?[0].text ?? "0"
            self.playData.applyUserFilter(userInput)
            self.tableView.reloadData()
        })
        
        ac.addAction(UIAlertAction(title : "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
}

