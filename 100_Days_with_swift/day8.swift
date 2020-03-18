//STRUCTS
//Sao estruturas que permitem a criação de variveis e funções
//que podem ser usadas depois
//Variaveis dentro de structs sao chamadas de stored properties
//Ja variaveis que rodam um codigo sao chamdas de computed property
struct Sport {
    var name: String
    var isOlympicSport: Bool
    //olympicStatus retorna uma string, porem depende de outro valor
    //o que a caracteriza como computed property
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}

var tennis = Sport(name: "Tennis", isOlympicSport: true)
print(tennis.name)
//Como variavel, ela pode ser mudada
tennis.name = "Tennis de Mesa"

//Property observers
//é quando um codigo é executado antes ou depois que uma propiedade é alterada
struct Progress {
    var task: String
    var amount: Int {
        //A cada mudança da propiedade, é executada esse codigo
        //didSet é responsavel por isso
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}
var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100

//Funções dentro de structs sao chamadas metodos
//Funcionam da mesma forma que uma função normal
//Podem usar propiedades da struct
struct City {
    var population: Int
    func collectTaxes() -> Int {
        return population * 1000
    }
}
let london = City(population: 9_000_000)
print(london.collectTaxes()) //é a forma de chamar os metodos
//Mutating methods
//Por padrao, metodos nao podem mudar propiedades da struct
//Para isso acontecer, temos que usar a keyword mutating
struct Person {
    var name: String
    //Entao autorizamos a mudança da propriedade
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}
var person = Person(name: "Ed")
//Entao é permitida a mudança
person.makeAnonymous()

//Properties and methods of strings
let string = "Do or do not, there is no try."
print(string.count) //Numero de letras
print(string.hasPrefix("Do")) //Retorna true se começa com essas letras
print(string.uppercased()) //Transforma tudo em maiusculo
print(string.sorted()) //Mostra as strings em ordem em um array
//Nenhum desses metodos mudam a variavel original
//Properties and methods of arrays
var toys = ["Woody"]
print(toys.count) //Numero de elementos do array
toys.append("Buzz") //Adiciona ao fim do array
print(toys.firstIndex(of: "Buzz")) //Retorna o index no array
print(toys.sorted()) //Mostra o array em ordem alfabetica
toys.remove(at: 0) //Remove do array a posição 0