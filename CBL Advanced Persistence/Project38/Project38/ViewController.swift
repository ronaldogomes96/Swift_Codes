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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cria o persistent container, deve ser passado o nome do projeto, pois é onde a base de dados esta no momento.
        container = NSPersistentContainer(name: "Project38")
        //carrega o banco de dados salvo se existir ou o cria de outra forma
        container.loadPersistentStores { storeDescription, error in
            //Caso haja um erro
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
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


}

