//
//  ViewController.swift
//  HitList
//
//  Created by Ronaldo Gomes on 15/10/20.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //Representa um único objeto armazenado em Core Data; deve ser usado para criar, editar,
    //salvar e excluir de seu armazenamento persistente de Core Data
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "The List"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Fazendo o carregamento do core data
        
        
        /*
         Antes de fazer qualquer coisa com Core Data, você precisa de um contexto de objeto gerenciado. Buscar não é diferente! Como antes, você obtém o app delegate e obtém uma referência para seu contêiner persistente para colocar as mãos em seu NSManagedObjectContext.
         */
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        /*
         Como o nome sugere, NSFetchRequest é a classe responsável por buscar dos dados principais. As solicitações de busca são poderosas e flexíveis. Você pode usar solicitações de busca para buscar um conjunto de objetos que atendam aos critérios fornecidos (ou seja, me dê todos os funcionários que vivem em Wisconsin e estão na empresa há pelo menos três anos), valores individuais (ou seja, me dê o nome mais longo no banco de dados) e Mais.
         As solicitações de busca têm vários qualificadores usados ​​para refinar o conjunto de resultados retornados. Por enquanto, você deve saber que NSEntityDescription é um desses qualificadores obrigatórios.
         Definir uma propriedade de entidade de solicitação de busca ou, alternativamente, inicializá-la com init (entityName :), busca todos os objetos de uma entidade específica. Isso é o que você faz aqui para buscar todas as entidades Person. Observe também que NSFetchRequest é um tipo genérico. Este uso de genéricos especifica o tipo de retorno esperado de uma solicitação de busca, neste caso NSManagedObject.
         */
        let fechRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        /*
         Você entrega a solicitação de busca ao contexto do objeto gerenciado para fazer o trabalho pesado. fetch (_ :) retorna uma matriz de objetos gerenciados que atendem aos critérios especificados pela solicitação de busca.
         */
        do {
            people = try managedContext.fetch(fechRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }

    //Implementando a funcao de adicionar nome com uma alert controller
    @IBAction func addName(_ sender: UIBarButtonItem) {
        
        //Cria o objeto do alert
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        //Closure de save
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                       [unowned self] action in
            guard let textField = alert.textFields?.first,
                  let nameToSave = textField.text else {
                return
            }
            
            //Chamando a funcao de salvar no core data
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        
        //Closure do cancelamento
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    //Funcao que salva no core data
    func save(name: String) {
    
        //Faz a instancia do app delegate
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        /*
         Antes de salvar ou recuperar qualquer coisa de seu armazenamento de dados principais, primeiro você precisa colocar as mãos em um NSManagedObjectContext. Você pode considerar um contexto de objeto gerenciado como um “bloco de notas” na memória para trabalhar com objetos gerenciados.
         Pense em salvar um novo objeto gerenciado no Core Data como um processo de duas etapas: primeiro, você insere um novo objeto gerenciado em um contexto de objeto gerenciado; quando estiver satisfeito, você "confirma" as alterações no contexto do objeto gerenciado para salvá-lo no disco.
         O Xcode já gerou um contexto de objeto gerenciado como parte do modelo do novo projeto. Lembre-se de que isso só acontece se você marcar a caixa de seleção Use Core Data no início. Este contexto de objeto gerenciado padrão vive como uma propriedade do NSPersistentContainer no delegado do aplicativo. Para acessá-lo, primeiro você obtém uma referência ao delegado do aplicativo.
         */
        let managedContext = appDelegate.persistentContainer.viewContext
        
        /*
         Você cria um novo objeto gerenciado e o insere no contexto do objeto gerenciado. Você pode fazer isso em uma etapa com o método estático de NSManagedObject: entity (forEntityName: in :).
         Você pode estar se perguntando do que se trata um NSEntityDescription. Lembre-se antes, NSManagedObject era chamado de classe de metamorfo porque pode representar qualquer entidade. Uma descrição de entidade é a parte que liga a definição de entidade de seu Modelo de Dados a uma instância de NSManagedObject em tempo de execução.
         */
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        
        /*
         Com um NSManagedObject em mãos, você define o atributo de nome usando a codificação de valor-chave. Você deve soletrar a chave KVC (nome neste caso) exatamente como ela aparece em seu Modelo de Dados, caso contrário, seu aplicativo irá travar no tempo de execução.
         */
        person.setValue(name, forKey: "name")
        
        /*
         Você confirma suas alterações para pessoa e salva no disco chamando save no contexto do objeto gerenciado. Observe que o salvamento pode gerar um erro, e é por isso que você o chama usando a palavra-chave try em um bloco do-catch. Finalmente, insira o novo objeto gerenciado no array people para que ele apareça quando a visualização da tabela for recarregada.
         */
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let person = people[indexPath.row]
        //Procura pela chave-valor, no core data que foi definido como name
        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell
    }
}

