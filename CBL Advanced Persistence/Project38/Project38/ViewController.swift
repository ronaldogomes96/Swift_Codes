//
//  ViewController.swift
//  Project38
//
//  Created by Ronaldo Gomes on 19/10/20.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    // Objeto que pode criar, ler, atualizar e excluir objetos Core Data inteiramente na memória, antes de gravar de volta no banco de dados de uma vez.
    var container: NSPersistentContainer!
    //Array de objetos do tipo commit que serao salvos
    var commits = [Commit]()
    //Predicate serve com um filtro de querys
    var commitPredicate: NSPredicate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cria o persistent container, deve ser passado o nome do projeto, pois é onde a base de dados esta no momento.
        container = NSPersistentContainer(name: "Project38")
        //carrega o banco de dados salvo se existir ou o cria de outra forma
        container.loadPersistentStores { storeDescription, error in
            //Nao permite a duplicada de atributos
            self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
        //Chama a funcao que busca commits no github
        performSelector(inBackground: #selector(fetchCommits), with: nil)
        loadSaveData()
        
        //Botao que permite o usuario filtrar algo
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(changeFilter))

    }
    
    //Busca os commits na url do github
    @objc func fetchCommits() {
        
        //Tranforma a url em string
        if let data = try? String(contentsOf: URL(string: "https://api.github.com/repos/apple/swift/commits?per_page=100")!) {
            //Passa o data para o parse do json
            let jsonCommits = JSON(parseJSON: data)

            //Le os commits do json
            let jsonCommitArray = jsonCommits.arrayValue

            //print("Received \(jsonCommitArray.count) new commits.")

            //Volta para a thread principal
            DispatchQueue.main.async { [unowned self] in
                //Para cada commit do array de objetos
                for jsonCommit in jsonCommitArray {
                    //Pega a configuracao da classe do model, passando o container atual
                    let commit = Commit(context: self.container.viewContext)
                    //Envia para a configuracao de objetos de commit
                    self.configure(commit: commit, usingJSON: jsonCommit)
                }

                self.saveContext()
                loadSaveData()
            }
        }
    }
    
    //Configura o objeto commit de acordo com os dados de cada json
    func configure(commit: Commit, usingJSON json: JSON) {
        //Passa os argumentos no formato key - value
        commit.sha = json["sha"].stringValue
        commit.message = json["commit"]["message"].stringValue
        commit.url = json["html_url"].stringValue

        //Faz o parse de ISO8601 para o tipo date
        let formatter = ISO8601DateFormatter()
        commit.date = formatter.date(from: json["commit"]["committer"]["date"].stringValue) ?? Date()
    }
    
    //Salva as mudancas na memoria para a base dados
    func saveContext() {
        //Garante que existe alguma mudanca para ser salva
        if container.viewContext.hasChanges {
            //Tem que ser colocado num bloco do-try-catch pois pode gerar um erro
            do {
                //Salva na base dados
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
            
        }
    }
    
    //Carrega os dados no core data
    func loadSaveData() {
        //Cria um fetch request para o commit
        let request = Commit.createFetchRequest()
        //Objeto que organiza como os dados irao ser carregados, nesse caso de acordo com o date
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        
        //Informa o predicate do request feito, no caso o tipo filtro
        request.predicate = commitPredicate
        
        do {
            //Faz o load da base de dados de acordo com o request ja configurado
            commits = try container.viewContext.fetch(request)
            //print("Got \(commits.count) commits")
            tableView.reloadData()
        } catch {
            //Caso falhe
            print("Fetch failed")
        }
    }
    
    @objc func changeFilter() {
        let ac = UIAlertController(title: "Filter commits…", message: nil, preferredStyle: .actionSheet)

        //Sao opcoes que quando clicadas acionam a closure
        ac.addAction(UIAlertAction(title: "Show only fixes", style: .default) { [unowned self] _ in
            //Filtra com essa mensagem em string. Funciona como uma query de banco de dados
            self.commitPredicate = NSPredicate(format: "message CONTAINS[c] 'fix'")
            self.loadSaveData()
        })
        
        ac.addAction(UIAlertAction(title: "Ignore Pull Requests", style: .default) { [unowned self] _ in
            self.commitPredicate = NSPredicate(format: "NOT message BEGINSWITH 'Merge pull request'")
            self.loadSaveData()
        })
        
        ac.addAction(UIAlertAction(title: "Show only recent", style: .default) { [unowned self] _ in
            let twelveHoursAgo = Date().addingTimeInterval(-43200)
            //%@ indica a variavel que vem apos a string
            self.commitPredicate = NSPredicate(format: "date > %@", twelveHoursAgo as NSDate)
            self.loadSaveData()
        })
        
        ac.addAction(UIAlertAction(title: "Show all commits", style: .default) { [unowned self] _ in
            self.commitPredicate = nil
            self.loadSaveData()
        })

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Commit", for: indexPath)

        let commit = commits[indexPath.row]
        cell.textLabel!.text = commit.message
        cell.detailTextLabel!.text = commit.date.description

        return cell
    }

}

