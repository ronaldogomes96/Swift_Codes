//
//  ResultsViewController.swift
//  Project33
//
//  Created by Ronaldo Gomes on 17/10/20.
//

import UIKit
import AVFoundation
import CloudKit

class ResultsViewController: UITableViewController {
    
    var whistle: Whistle!
    var suggestions = [String]()
    var whistlePlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Genre: \(whistle.genre!)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(downloadTapped))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        getSuggestions()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Suggested songs"
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return suggestions.count + 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.numberOfLines = 0

        if indexPath.section == 0 {
            //O comentario do usuario sobre a musica
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)

            if whistle.comments.count == 0 {
                cell.textLabel?.text = "Comments: None"
            } else {
                cell.textLabel?.text = whistle.comments
            }
        } else {
            //As sugestoes
            cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)

            if indexPath.row == suggestions.count {
                // this is our extra row
                cell.textLabel?.text = "Add suggestion"
                cell.selectionStyle = .gray
            } else {
                cell.textLabel?.text = suggestions[indexPath.row]
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 && indexPath.row == suggestions.count else { return }

        tableView.deselectRow(at: indexPath, animated: true)

        let ac = UIAlertController(title: "Suggest a song…", message: nil, preferredStyle: .alert)
        ac.addTextField()

        ac.addAction(UIAlertAction(title: "Submit", style: .default) { [unowned self, ac] action in
            if let textField = ac.textFields?[0] {
                if textField.text!.count > 0 {
                    self.add(suggestion: textField.text!)
                }
            }
        })

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    //Adiciona uma nova sugestao ao cloudkit
    func add(suggestion: String) {
        
        //Cria o objeto que sera enviado para o cloudKit, com um nome especifico, nesse caso Suggestions
        //Funciona como um dicionario key-value
        let whistleRecord = CKRecord(recordType: "Suggestions")
        //Faz um vinculo a sugestão de um usuário ao whistle sobre o qual estavam lendo
        let reference = CKRecord.Reference(recordID: whistle.recordID, action: .deleteSelf)
        //os valores que queremos guardar
        whistleRecord["text"] = suggestion as CKRecordValue
        whistleRecord["owningWhistle"] = reference as CKRecordValue
        
        //Entao salvamos esse record no cloudKit, container publico
        CKContainer.default().publicCloudDatabase.save(whistleRecord){ [unowned self] record, error in
            //Voltamos para a thread principal pois queremos atualizar a interface
            DispatchQueue.main.async {
                //Caso nao haja erro
                if error == nil {
                    //colocamos a sugestao no nosso arrays de sugestions
                    self.suggestions.append(suggestion)
                    self.tableView.reloadData()
                }
                //Caso haja erro
                else {
                    //Mostramos que a operacao nao deu certo
                    let ac = UIAlertController(title: "Error", message: "There was a problem submitting your suggestion: \(error!.localizedDescription)", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
            
        }
    }
    
    //Retorna as sugestoes do cloudKit
    func getSuggestions() {
        
        //Faz um vinculo a sugestão de um usuário ao whistle sobre o qual estavam lendo
        let reference = CKRecord.Reference(recordID: whistle.recordID, action: .deleteSelf)
        //Podemos, então, passar isso para um NSPredicate que verificará se há sugestões onde owningWhistle corresponde a esse predicado. Ele filtra de acordo com isso
        let pred = NSPredicate(format: "owningWhistle == %@", reference)
        //diz ao CloudKit qual campo queremos classificar e se o queremos crescente ou decrescente.
        let sort = NSSortDescriptor(key: "creationDate", ascending: true)
        //Cria a query do tipo suggestions, com parametros definidos
        let query = CKQuery(recordType: "Suggestions", predicate: pred)
        query.sortDescriptors = [sort]
        
        //Como queremos todos os campos dos registros, nao precisamos fazer o operation
        
        //Diga a este método qual query executar e onde deve ser executada (ou nil para o padrão) e ele retornará resultados ou um erro.
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { [unowned self] results, error in
            //Caso haja um erro
            if let error = error {
                print(error.localizedDescription)
            }
            //Caso nao haja um erro
            else {
                if let results = results {
                    //Envia os resultados e chama a funcao
                    self.parseResults(records: results)
                }
            }
        }
    }
    
    //Tranforma o resultado em string
    func parseResults(records: [CKRecord]) {
        var newSuggestions = [String]()

        //faz o parse pra string
        for record in records {
             newSuggestions.append(record["text"] as! String)
        }

        //Volta para a thread principal
        DispatchQueue.main.async { [unowned self] in
            //Repassa o array e atualiza a table view
            self.suggestions = newSuggestions
            self.tableView.reloadData()
        }
    }
    
    //Funcao que faz o dowloand do audio do cloudKit
    @objc func downloadTapped() {
        
        //Cria uma animacao de spinner pra indicar o dowload do audio
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.tintColor = UIColor.black
        spinner.startAnimating()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        //Faz o dowlond no cloudKit de acordo com o recordId
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: whistle.recordID) { [unowned self] record, error in
            
            //Caso haja um erro
            if let error = error {
                //Voltamos para a thread principal para mudar a interface
                DispatchQueue.main.async {
                    //mandamos uma mensagem de erro e voltamos para o inicial da funcao
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Download", style: .plain, target: self, action: #selector(self.downloadTapped))

                }
            }
            //Caso nao haja erro
            else {
                //Faz um unwarp do record
                if let record = record {
                    //Faz um unwarp da key do audio como asset
                    if let asset = record["audio"] as? CKAsset {
                        //Passa para o objeto da classe
                        self.whistle.audio = asset.fileURL
                        //Chama a thread principal e chama a funcao de escutar o audio
                        DispatchQueue.main.async {
                            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Listen", style: .plain, target: self, action: #selector(self.listenTapped))
                        }
                    }
                }
            }
        }
    }
    
    //Reproduz o audio
    @objc func listenTapped() {
        do {
            //Busca o audio na url especifca
            whistlePlayer = try AVAudioPlayer(contentsOf: whistle.audio)
            //Reproduz a musica
            whistlePlayer.play()
        } catch {
            //Caso haja um erro, mostra uma mensagem de erro
            let ac = UIAlertController(title: "Playback failed", message: "There was a problem playing your whistle; please try re-recording.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
}
