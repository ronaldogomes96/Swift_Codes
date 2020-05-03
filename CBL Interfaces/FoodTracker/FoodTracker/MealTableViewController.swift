//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Ronaldo Gomes on 03/05/20.
//  Copyright © 2020 Ronaldo Gomes. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: Propeties
    
    //Array de objetos do tipo meal
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Cria o botao de edicao fornecido pelo sistema
        navigationItem.leftBarButtonItem = editButtonItem
        
        //Carrega os dados gerais da refeicao
        loadSampleMeals()
    }
    
    //MARK: Navigation
    
    //Verifica qual o caminho de escolha
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        
        //Caso for esse caminho, nao é necessario alterar a aparencia da cena de detalhes
        case "AddItem":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        
        //Caso seja esse o caminho, é necessario alguns ajustes
        case "ShowDetail":
            
            //Obtem o viewcontroller de destino
            guard let mealDetailViewController = segue.destination as? MealViewController else{
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            //Obtem a celula selecionada
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            //Obtem o caminho do indice da celula selecionadax
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            
            //Procura esse caminho no array de objetos de meals
            let selectedMeal = meals[indexPath.row]
            
            //Exibicao de destino
            mealDetailViewController.meal = selectedMeal
        
        //Caso padrao
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Actions
    
    //Adiciona uma nova refeicao colocada pelo usuario a lista de refeicoes
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal{
            
            //Verifica se uma linha na visualização da tabela está selecionada, e é executada quando esta editando uma refeicao existente
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                
                //Atualizando uma refeicao existente
                
                //Substitui o antigo objeto pelo novo editado
                meals[selectedIndexPath.row] = meal
                //Substitui na celula correspondente
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            //Caso nao, entao é uma nova meal
            else{

                //Verifica o local em que a nova refeicao sera colocada
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                //Isso adiciona a nova refeição à lista existente de refeições no modelo de dados
                meals.append(meal)
                
                //Insere a nova refeicao na table view
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        }
        
    }

    // MARK: Private methods
    
    //Carrega os dados do aplicativo
    private func loadSampleMeals(){
        
        //Cria as variaveis com as fotos
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        //Cria a instancia da classe meal de cada foto
        guard let meal1 = Meal(name: "Caprese salad", photo: photo1, rating: 4) else{
            fatalError("Unable to instantiate meal1")
        }
        guard let meal2 = Meal(name: "Chicken and Potatoas", photo: photo2, rating: 5) else{
            fatalError("Unable to instantiate meal2")
        }
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else{
            fatalError("Unable to instantiate meal3")
        }
        
        //Adiciona no array de objetos
        meals += [meal1, meal2, meal3]
    }
    
    //MARK: Metodos
    
    //Informa o numero de secoes que tera na table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Numero de linhas que tera em uma determinada secao
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Identificador na storyboard
        let cellIdentifier = "MealTableViewCell"
        
        //Celula especifica
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else{
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        //Busca a refeicao especifica no array
        let meal = meals[indexPath.row]
        
        //Exibicao dos dados correspondentes
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    
    //Editando o botao de editar da table view e permite o scroll para o lado pra deletar
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //Caso seja o delete
        if editingStyle == .delete{
            
            //Remove o meal do array de objetos
            meals.remove(at: indexPath.row)
            //Exclui na linha correspondente da tabela
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert{
            
        }
    }
    
    //Permite a edicao da linha
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


}
