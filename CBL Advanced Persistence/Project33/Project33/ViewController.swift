//
//  ViewController.swift
//  Project33
//
//  Created by Ronaldo Gomes on 16/10/20.
//

import UIKit
import CloudKit

class ViewController: UITableViewController {
    
    static var isDirty = true
    //Instancia do modelo de dados
    var whistles = [Whistle]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "What's that Whistle?"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWhistle))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //Limpa a tableview a cada ciclo
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }

        if ViewController.isDirty {
            loadWhistles()
        }
    }

    //Carrega os dados do cloudkit
    func loadWhistles() {
        
        //Objeto que filtra os valores
        let pred = NSPredicate(value: true)
        //diz ao CloudKit qual campo queremos classificar e se o queremos crescente ou decrescente.
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        //Cria uma query com predicado e descricao ja feitas para o objeto do tipo "Whistles"
        let query = CKQuery(recordType: "Whistles", predicate: pred)
        query.sortDescriptors = [sort]
        
        //Cria a operacao de query no cloudkit
        let operation = CKQueryOperation(query: query)
        //Informamos as chaves que queremos
        operation.desiredKeys = ["genre", "comments"]
        //E o numero de resultados
        operation.resultsLimit = 50
        
        //Cria o objeto do tipo whistle
        var newWhistles = [Whistle]()
        
        //Isso receberá um valor CKRecord para cada registro baixado, e ira converter isso em um objeto Whistle.
        operation.recordFetchedBlock = { record in
            let whistle = Whistle()
            whistle.recordID = record.recordID
            whistle.genre = record["genre"]
            whistle.comments = record["comments"]
            //Insere no array de whistle
            newWhistles.append(whistle)
        }
        
        //Isso será chamado pelo CloudKit quando todos os registros forem baixados
        operation.queryCompletionBlock = { [unowned self] (cursor, error) in
            //Voltamos para a thread principal pois vamos mudar a interface
            DispatchQueue.main.async {
                if error == nil {
                    //Informa que nao precisa fazer o reload da table view
                    ViewController.isDirty = false
                    //Atualiza o objeto da classe
                    self.whistles = newWhistles
                    self.tableView.reloadData()
                } else {
                    //Caso haja um erro, jogamos um alerta na tela
                    let ac = UIAlertController(title: "Fetch failed", message: "There was a problem fetching the list of whistles; please try again: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
        
        //Faz a chamada para o cloudKit
        CKContainer.default().publicCloudDatabase.add(operation)
    }

    @objc func addWhistle() {
        let vc = RecordWhistleViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //Faz a formatacao do texto da celula
    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]

        let titleString = NSMutableAttributedString(string: "\(title)", attributes: titleAttributes)

        if subtitle.count > 0 {
            let subtitleString = NSAttributedString(string: "\n\(subtitle)", attributes: subtitleAttributes)
            titleString.append(subtitleString)
        }

        return titleString
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.whistles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.attributedText =  makeAttributedString(title: whistles[indexPath.row].genre, subtitle: whistles[indexPath.row].comments)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

