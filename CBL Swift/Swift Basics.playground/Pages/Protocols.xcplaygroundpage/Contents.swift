import Foundation
/*:
 [Classes e Structs](@previous)
 
 # Protocolos
 
 Definem um conjunto de métodos, propriedades e inicializadores
 
 * Podem ser adotados por classes, structs e enums
 * Quando tipo adota um protocolo é dito que está em conformidade com o protocolo
 
 Exemplo:
 */
protocol OneProtocol {
   // Implementação do protocolo
}

protocol OtherProtocol {
   // Implementação do protocolo
}

struct All: OneProtocol, OtherProtocol {}

/*:
 ### Propriedades
 
 * Um protocolo pode requerer que os tipos que o adotam provenham propriedades de instância e de tipo.
 * Não se especifica se uma propriedade é armazenada ou computada
 * Apenas é especificado nome e tipo
 * Também especifica-se os acessos a propriedade (`{get}`, `{get set}`
 
 */

protocol Mammal {
    var numberOfLegs: Int { get }
    var monthsPregnant: Int { get set }
}

class Cow: Mammal {
    
    var numberOfLegs: Int {
        return 4
    }
    
    var monthsPregnant: Int = 9
}


/*:
 ### Métodos
 * Protocolos podem especificar métodos de instância e de tipo
 * Não é permitido definir valores padrão para parâmetros de métodos especificados em protocolos.
 
 > Protocolos podem especificar um inicializador para classes.
 > Sempre devemos marcar a implementação do iniciador com required.
 */

protocol LivingThing {
    var birth: Date { get set }
    var death: Date? { get set }
    var age: Int { get }
    
    init(birth: Date, death: Date?)
    func die()
    static func calculateAge(birth: Date, death: Date?) -> Int
}

class Human: LivingThing {
    
    var birth: Date
    var death: Date?
    
    var age: Int {
        return Human.calculateAge(birth: birth, death: death)
    }
    
    required init(birth: Date, death: Date?) {
        self.birth = birth
        self.death = death
    }
    
    func die() {
        death = Date()
    }
    
    static func calculateAge(birth: Date, death: Date?) -> Int{
        let ageInterval = death != nil ? death! : Date()
        let calendar = Calendar.current
        return calendar.dateComponents([.year], from: birth, to: ageInterval).year ?? 0
    }
}

let human = Human(birth: Date(timeIntervalSince1970: 1), death: Date(timeIntervalSince1970: 3400000000))
human.age

/*:
 ### Associated Types
 * São placeholders para tipos usados nas definições do protocolo;
 * O tipo só será definido quando o protocolo for adotado;
 * São definidos usando a palavra chave associatedtype;
 > 
 */

protocol Container {
    associatedtype Item
    
    var items: [Item] { get }
    func append(_ item: Item)
}


class Bag: Container {
    typealias Item = Int
    
    var items: [Int] = []
    
    func append(_ item: Int) {
        items.append(item)
    }
}
//: [Extensions](@next)
