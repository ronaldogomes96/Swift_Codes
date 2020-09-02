import Foundation
import UIKit
/*:
 [Extensions](@previous)
 # Tratamento de Erros

 Em Swift, erros são representados por valores em que o tipo estão conformes o protocolo Error. Esse protocolo indica que um tipo pode ser usado para tratamento de erros.

 Enums são a melhor estrutura para modelar um grupo de erros semelhantes, ou relacionados a uma mesma operação, com valores associados que fornecem uma informação adicional sobre a natureza do erro comunicado. Por exemplo, podemos representar as condições de erro de uma maquina de vendas.
*/

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

/*:
 Lançar (em inglês, throw) um erro permite que o programa indique que algo inesperado aconteceu e que o fluxo normal foi interrompido. O termo "throw" é usado em Swift para lançar um erro. Por exemplo, o seguinte código lança um erro para indicar que é necessário inserir 5 moedas na maquina de vendas:
*/

throw VendingMachineError.insufficientFunds(coinsNeeded: 5)

/*:
 ## Propagando erros usando Throwing Functions.
 
 Para indicar que uma função, método ou inicializador pode lançar um erro, é necessário escrever a palavra reservada "throw" na declaração da função depois dos seus parâmetros. Uma função marcada com a palavra "throws" é chamada Throwing Function. Se a função especifica um tipo de retorno, escreve-se "throws" antes da seta de retorno (->).
 
    func capazDeLancarErros() throws -> String
    func incapazDeLancarErros() -> String
 
 Uma throwing function propaga os erros que são lançados dentro de seu escopo para o escopo acima (escopo em que a throwing function foi chamada).
 Somente throwing functions podem propagar erros. Quaisquer erros que forem lançados dentro de uma função que não tem a palavra "throws" na sua declaração deve ser tratado dentro do escopo da própria função.
 
 No exemplo abaixo, a classe VendingMachine tem um método vend(itemNamed:) que lança o VendingMachineError para cada caso de erro especificado.
*/

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}

/*:
 A implementação da função vend(itemNamed:) usa o termo guard para sair do escopo do método e lançar os erros caso a caso.
 
Porque a função vend(itemNamed:) propaga qualquer erro que lançar, qualquer código que chama esse método deve obrigatoriamente tratar o erro lançado, seja com do-catch, try? ou try!, ou continuar propagando o erro lançado. Por exemplo, a função abaixo buyFavoriteSnack(person:vendingMachine:) lança erros, e qualquer erro que a função vend(itemNamed:) lançar vai propagar para o escopo em que a função buyFavoriteSnack(person:vendingMachine:) é chamada.
*/

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

/*:
 Nesse exemplo, a função buyFavoriteSnack(person: vendingMachine:) busca pelo item favorito da pessoa especificada nos parametros, e tenta compra-lo chamando a função vend(itemNamed:),que também lança erros. Já que a função vend(itemNamed:) é uma throwing function, ela deve ser chamada com a palavra reservada try antes dela.
 
 Throwing initializers podem propagar erros da mesma maneira que throwing functions. Por exemplo, o inicializador para o struct PurchasedSnack na lista abaixo chama uma throwing function como parte de sua inicialização, e trata qualquer erro que for lançado propagando esse erro para o escopo que chamou o seu initializer.
*/

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

/*:
 ## Tratando Erros usando Do-Catch
 
 No exemplo abaixo, a função buyFavoriteSnack(person:vendingMachine:) é chamada com a expressão "try" porque a função pode lançar um erro. Se um erro for lançado, a execução do código imediatamente entra no escopo do "catch" com o erro específico como parametro.
*/

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}

// Prints "Insufficient funds. Please insert an additional 2 coins."
/*:
 ## Desacoplando o tratamento de erros
 
 O catch não precisa necessariamente tratar todos os erros possíveis em um lugar só. Se algum erro não for tratado, ele será propagado para o escopo acima dele. Nesse caso, o escopo acima é obrigado a tratar o erro que foi lançado.
*/

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Invalid selection, out of stock, or not enough money.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}

/*:
 ## Tratando todos os casos de erro da mesma maneira
*/

func fetchDataFromDisk() throws -> Data? {
    // try to fetch data from disk
    return nil
}

func fetchDataFromServer() throws -> Data? {
    // try to fetch data from server
    return nil
}

func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

/*:
 ## Desabilitando propagação de erros
*/

func loadImage(atPath path: String) throws -> UIImage? {
    // try to read image file and load it in UIImage
    return nil
}

let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")

/*:
## Especificando Cleanup Actions

A palavra reservada "defer"
É possível definir que algumas linhas de código devem ser obrigatoriamente executadas exatamente antes de um erro ser lançado dentro de uma função usando a palavra reservada "defer". Assim, é possível fazer qualquer cleanup ou ação necessária indenpendentemente de um erro ser lançado ou não. Por exemplo, você pode usar o defer com um código que fecha um arquivo caso haja algum erro durante a sua edição.

Ações definidas dentro do escopo do defer não devem conter break, return, continue, ou throw. Além disso, são executadas em ordem inversa, ou seja, de cima pra baixo. A última linha de código executa primeiro, depois a penúltima, e assim por diante até chegar na primeira linha de código do defer.
*/

func exists(_ filename: String) -> Bool {
    // check if filename exists
    return true
}

struct File {
    let filename: String
    
    func readline() throws -> String? {
        //try read line one by one
        return nil
    }
}

func open(_ filename: String) -> File {
    return File(filename: filename)
}

func close(_ file: File) {
    //close file and clean memory
}

func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            print(line)
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}

//: [Access Control](@next)








/*:
 # Exemplo da Máquina de Café
*/

import UIKit

/*:
 ## Enum que define tipos de erro possíveis
*/
enum CoffeeMachineError: Error {
    case notEnoughCoins(required: Int)
    case outOfStock
}

/*:
 ## Enum que representa os tipos de cafés, estoque, e preço.
 Feito com fins didáticos. Na prática isso não faz sentido. Normalmente esse tipo de info vem de um servidor e fica persistida no App com CoreData ou FileManager.
*/
enum Coffee: String {
    case espresso = "Espresso"
    case pingado = "Pingado"
    case capuccino = "Capuccino"
    
    var price: Int {
        switch self {
        case .espresso:
            return 5
        case .pingado:
            return 10
        case .capuccino:
            return 20
        }
    }
    
    var stock: Int {
        switch self {
        case .espresso:
            return 20
        case .pingado:
            return 50
        case .capuccino:
            return 0
        }
    }
    
}

/*:
 ## Função comprar café
 
 Essa função é do tipo _Throwing Function_ que pode lançar erros especificados em algum enum. No nosso caso, erros descritos no enum CoffeeMachineError.
 
 Entrada:
 - coffee: tipo de café que se deseja comprar
 - coins: dinheiro inserido na maquina
*/
func buyCoffee(_ coffee: Coffee, coins: Int) throws {
    
    if coffee.stock > 0 { //verifica estoque do café especificado na chamada da função
        
        //verifica preço do café especificado na chamada da função e vê se a quantidade de moedas inseridas é o bastante
        if coins < coffee.price {
            
            //Caso o preço do café seja maior que o dinheiro inserido na máquina, lança erro para esse caso
            throw CoffeeMachineError.notEnoughCoins(required: coffee.price)
        } else {
            print("☕️ \(coffee.rawValue)")
        }
        
    } else {
        
        //Caso o café especificado não tenha estoque, lança erro para esse caso
        throw CoffeeMachineError.outOfStock
    }

}



/*:
 ## Chamada da Função e Tratamento de Erros em Swift
 
 A chamada de uma _Throwing Function_ sempre requer a palavra reservada _try_ antes dela.
 
 Caso a função _Throwing Function_ execute sem erros, o código entra no escopo da palavra reservada _do_ e executa todos os comandos descritos nele. Caso ocorra algum erro, a execução da _Throwing Function_ é interrompida e desviada para o escopo do _catch_, executando os códigos escritos dentro do catch.
*/

do {
    try buyCoffee(.espresso, coins: 5)
    print("Your Coffee is Ready!\n")
} catch {
    print("👺",error)
}

/*:
 É possível fazer várias chamadas a _Throwing Functions_ usando _try_ dentro de um mesmo _do-catch_
 
 Nesse caso, o primeiro erro que for lançado desviará a execução para dentro do _catch_, independentemente de em qual função ele ocorrer. A execução dos _try_ anteriores ao que lançou erro não é afetada.
 */

do {
    try buyCoffee(.pingado, coins: 12)
    try buyCoffee(.capuccino, coins: 20)
    try buyCoffee(.espresso, coins: 5)
} catch {
    print("👺",error)
}

//: [Generics](@next)
