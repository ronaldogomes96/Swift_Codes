//
//  MyGenresViewController.swift
//  Project33
//
//  Created by Ronaldo Gomes on 17/10/20.
//

import UIKit
import CloudKit

class MyGenresViewController: UITableViewController {

    var myGenres: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveUserDefaults()
        
        title = "Notify me about…"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SelectGenreTableViewController.genres.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let genre = SelectGenreTableViewController.genres[indexPath.row]
        cell.textLabel?.text = genre

        if myGenres.contains(genre) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let selectedGenre = SelectGenreTableViewController.genres[indexPath.row]
            //Caso nao tenha sido escolhido
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                myGenres.append(selectedGenre)
            }
            //Caso tenha sido e deseja remover
            else {
                cell.accessoryType = .none

                if let index = myGenres.firstIndex(of: selectedGenre) {
                    myGenres.remove(at: index)
                }
            }
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }

    //Salva os generos preferidos do usuario no user defaults
    func saveUserDefaults() {
        //Cria o objeto do user defaults
        let defaults = UserDefaults.standard
        
        //Caso exista algo ja salvo
        if let savedGenres = defaults.object(forKey: "myGenres") as? [String] {
            //Colocamos no array da classe
            myGenres = savedGenres
        }
        //Caso nao exista nenhum salvo
        else {
            myGenres = [String]()
        }
    }

    //Salva o array de generos
    @objc func saveTapped() {
        
        //Primeiramente salva no user defaults
        let defaults = UserDefaults.standard
        defaults.setValue(myGenres, forKey: "myGenres")
        
        //Faz a chamada para o cloudKit de todos os subscription
        let database = CKContainer.default().publicCloudDatabase
        database.fetchAllSubscriptions { [unowned self] subscriptions, error in
            
            //Caso nao haja erro na chamada
            if error == nil {
                //Unwarp dos subscriptions
                if let subscriptions = subscriptions {
                    //Fazemos um for pra eliminar todas que ja existem, para nao haveer duplicadas
                    for subscription in subscriptions {
                        database.delete(withSubscriptionID: subscription.subscriptionID) { str, error in
                            if error != nil {
                                // do your error handling here!
                                print(error!.localizedDescription)
                            }
                        }
                    }
                    
                    //Fazemos um for em todos os generos escolhidos para salvar as notificacoes no cloudKit
                    for genre in self.myGenres {
                        //Cria um predicado selecionando os genres igual os escolhidos na classe
                        let predicate = NSPredicate(format:"genre = %@", genre)
                        //Faz uma query pra subscription, para o record type Whistles e como option
                        //firesOnRecordCreation que indica que deve ser notificado a cada novo registro
                        let subscription = CKQuerySubscription(recordType: "Whistles", predicate: predicate, options: .firesOnRecordCreation)
                        
                        //Cria a notificacao em si
                        let notification = CKSubscription.NotificationInfo()
                        notification.alertBody = "There's a new whistle in the \(genre) genre."
                        notification.soundName = "default"
                        
                        //Adiciona a notificacao ao subscription
                        subscription.notificationInfo = notification
                        
                        //Salva no cloudKit
                        database.save(subscription) { result, error in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
            //Caso haja um erro na chamada
            else {
                // do your error handling here!
                print(error!.localizedDescription)
            }
        }
    }
}
