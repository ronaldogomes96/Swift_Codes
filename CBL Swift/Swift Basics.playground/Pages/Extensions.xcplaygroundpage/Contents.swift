
import Foundation
/*:
 [Protocols](@previous)
 
 # Extensões
 * Adicionam novas funcionalidades a tipos existentes.
 * Permite extender tipos que não temos acesso ao código fonte.
 
 ### Podemos com extensões:
 
 1. Adicionar propriedades computadas de instância e tipo.
 2. Definir métodos de instância e de tipo.
 3. Prover novos iniciadores.
 4. Definir novos tipos aninhados.
 5. Fazer com que um tipo existente entre em conformidade com protocolos.
 6. Definir implementações padrão para métodos definidos em protocolos.
 */
 

/*:
 ### Sintaxe
 */

class someClass { }

extension someClass { }


/*:
 ### Propriedades Computadas
 */

extension Double {
    
    var km: Double { return self / 1_000.0 }
    
    var m: Double { return self }
    
    var cm: Double { return self * 100.0 }
    
    var mm: Double { return self * 1_000.0 }
    
    var ft: Double { return self * 3.28084 }
}

let km = 600.0.cm

/*:
 ### Inicializadores
 */
extension Date {
    init(day: Int, month: Int, year: Int) {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        let calendar = Calendar.current
        self = calendar.date(from: components) ?? Date()
    }
}

let date = Date(day: 10, month: 05, year: 1991)

/*:
 ### Métodos
 */

extension Int {
    func sum(_ num: Int) -> Int {
        return self + num
    }
}

let num = 2
2.sum(3)

/*:
 > Métodos de Mutação
 */

extension Int {
    mutating func square() {
        self = self * self
    }
}

var sq = 2
sq.square()
sq

//: [Tratamento de Erros](@next)
