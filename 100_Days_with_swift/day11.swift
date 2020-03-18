//Protocolos são uma maneira de descrever quais propriedades e métodos algo deve ter
protocol Identifiable {
    //Pode ter os metodos get e set
    var id: String { get set }
}
//Podem ser usados em structs

//Em funções
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

//Protocolos podem ser herdados de varios outros protocolos
protocol Payable {
    func calculateWages() -> Int
}
protocol NeedsTraining {
    func study()
}
protocol HasVacation {
    func takeVacation(days: Int)
}
//Podemos criar um unico protocolo que herda de todos os outros
protocol Employee: Payable, NeedsTraining, HasVacation { }

//Extenções permitem criar metodos para tipos ja existentes
extension Int {
    //Extenção de Int
    func squared() -> Int {
        return self * self
    }
}
//Entao temos o novo metodo
let number = 8
print(number.squared())

//Podemos juntar protocolos e extensão e fazer metodos default
//Cria o protocolo
protocol Identificador {
    var id: String { get set }
    //Cria o metodo a ser usado
    func identify()
}
//Cria a extensão do protocolo
extension Identifiable {
    //Faz o metodo
    func identify() {
        print("My ID is \(id).")
    }
}
//Entao podemos usar o protocolo
struct User: Identifiable {
    var id: String
    //Nao precisamos colocar o metodo pois ele ja esta na extensão
}
let twostraws = User(id: "twostraws")
twostraws.identify()