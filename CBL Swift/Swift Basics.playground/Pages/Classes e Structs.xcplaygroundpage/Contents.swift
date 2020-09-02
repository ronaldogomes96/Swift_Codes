/*:
 [Enumerations](@previous)
 
 # Classes e Structs
 
 Classes e Structs são estruturas flexíveis que constituem o código do nosso programa, você pode definir propriedades e métodos que adicionam funcionalidades as suas classes e estruturas.
 
 No **Swift** não há necessidade de criar arquivos de interface e implementação separados, classes e structs são definidas em um único arquivo.
 
 ### Coisas em comum:
 
 * Definem propriedades
 * Definem métodos
 * Definem construtores
 * Podem ser extendidos para expandir funcionalidades
 * Podem assinar protocolos
 
 ### Diferencial de Classes:
 * Herança
 * Deinitializers permitem que instancias liberem recursos
 * Type Casting permite que você avalie e interprete o tipo de uma instância de classe em tempo de execução
 * Mais de uma referência para a instância de uma classe
 
 > Structs são **Value Types** e são passados por cópia, enquanto classes são **Reference Types** e são passado por referência, o que significa que structs não usam o contador de referência.
 > Exemplo:
 */

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var frameRate = 0.0
    var name: String?
}

/*:
 > Structs possuem inicializadores auto-gerados com todas as propriedades
 */

/*:
 ### Refêrencia vs Valor
 
 Em **Swift** Classes e Closures são Reference Types, todo o resto é Value Type
 > Exemplo:
 */

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048

print(hd.width)

let videoMode = VideoMode()
let anotherMode = videoMode
anotherMode.frameRate = 24.0
print(videoMode.frameRate)

/*:
 > **Quando usar structs:**
 * Quando queremos encapsular dados relativamente simples
 * Quando Propriedades do modelo também são **Value Types**
 * Quando o modelo não precisa herdar nenhuma propriedade ou comportamentos de modelos existentes ( Pode ser alcançado através de protocolos também )
 * Quando os dados encapsulados devem ser copiados e não referenciados
 > Exemplo:
 */


struct point {
    var x: Double
    var y: Double
    var z: Double
}




/*:
 ## Propriedades
 ### Stored Properties
 Uma constante ou variável que é parte de um instância de classe ou struct
 > Exemplo:
 */

class FixedLengthRange {
    var firstValue: Int
    var length: Int
    
    init(firstValue: Int, length: Int ) {
        self.firstValue = firstValue
        self.length = length
    }
}

var rangeOfThree = FixedLengthRange(firstValue: 0, length: 3)

/*:
 ### Lazy Stored Properties
 
 * É uma propriedade a qual seu valor só é calculado quando é usada a primeira vez
 * Usada onde valores iniciais dependem de fatores externos
 * Usada quando existe uma inicialização custosa ou complexa
 
 A palavra chave é `lazy`
 > Exemplo:
 */

struct Square {
    var size: Double
    lazy var area: Double = {
       return size*size
    }()
}

/*:
 ### Computed Stored Properties
 
 * Não armazenam um valor propriamente dito
 * Provêm um getter e um setter que é opcional
 > Exemplo:
 */

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    var center: Point {
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.width/2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width/2)
            origin.y = newValue.y - (size.height/2)
        }
    }
}

/*:
 ### Read Only Computed Stored Properties
 
 * Computada apenas com o get
 > Exemplo:
 */

struct cube {
    var size: Double
    var area: Double {
        return size * size
    }
}

/*:
 ### Property Observers
 
 * Respondem a mudanças no valor de uma propriedade
 * São chamados sempre que o valor é atribuído, mesmo quando não difere do atual
 * Pode-se adicionar observers para propriedades herdadas
 * Podemos usar os observers willSet e didSet
 
 
 > Exemplo:
 */

var gretting: String = "Yuri" {
    didSet {
        print("Welcome \(gretting)")
    }
    willSet {
        print("Goodbye \(gretting)")
    }
}

gretting = "Karina"

/*:
 ## Métodos
 
 * Funções associadas a classes, structs ou enums
 * Instância vs Tipo
 
 > Exemplo:
 */

struct CalculatorS {
    static func sum(num: Int, num2: Int) -> Int {
        return num + num2
    }
}

class CalculatorC {
    func sum(num: Int, num2: Int) -> Int {
        return num + num2
    }
}

enum CalculatorE {
    case sum
    case subtraction
    case multiply
    case divide

    func operation(num1: Double, num2: Double) -> Double {
        switch self {
        case .sum:
            return num1 + num2
        case .subtraction:
            return num1 - num2
        case .multiply:
            return num1 * num2
        case .divide:
            return num1 / num2
        }
    }
}

/*:
 > Modifique a estrutura para que ela mantenha o estado da operação anterior e caso o segundo número não seja passado ao realizar a operação, utilize o valor já existente na mémoria.
 */

struct Calc {
    var result = 0
    
    mutating func sum(num: Int, num2: Int? = nil) -> Int {
        guard let num2 = num2 else {
            result = num + result
            return result
        }
        result = num + num2
        return result
    }
}





/*:
 
 
 ### Inicialização
 
 * a palavra chave é `init`
 * pode-se customizar a inicialização com passagem de parâmetros
 
 > Exemplo:
 */
import Foundation
//Começar com struct e trocar pra classe
class Person {
    var name: String
    var age: Int
    var birth: Date
    
    init(name: String, age: Int, birth: Date) {
        self.name = name
        self.age = age
        self.birth = birth
    }
}

/*:
 > Se seu modelo possue propriedades que podem ser nulas, declaramos como optionals
 */

class SurveyQuestion {
    var text: String
    var response: String?
    
    init(text: String){
        self.text = text
    }
}

/*:
 ## Herança
 
 * Diferencia classes de outros tipos
 * Maneira de herdar métodos ou propriedades e outras características de outras classe
 
 > Exemplo:
 */

class Part {
    var manufacturer = ""
    var description = ""
    var number = 0
}

class Tire: Part {
    var speed = 0.0
    var rating = 3.5
}

let goodyear = Tire()

/*:
 ### Override
 
 * Você pode sobreescrever, métodos e propriedades
 * Maneira de herdar métodos ou propriedades e outras características de outras classe
 
 > Exemplo:
 */

class Vehicle {
    var description: String {
      return "Traveling at"
    }
    
    func makeNoise() {
        print("Vrummm")
    }
}

class Train: Vehicle {
    override func makeNoise() {
        print("Cho choo")
    }
}

class Car: Vehicle {
    var gear = 1
    var speed = 25.0
    override var description: String {
        return super.description + "at \(speed)Km/h in gear \(gear)"
    }
}

/*:
 > Você pode tornar uma propriedade apenas de leitura para Read and Write através de override, porém não pode transformar uma propriedade Read and Write para apenas leitura
 */

/*:
 > Para prevenir que propriedades ou métodos sejam subscritos ou classes sejam herdadas, adicione o `final`
 */


/*:
 ### Type Casting
 
 * `is` checa o tipo de um valor
 * `as` converte um valor para um tipo diferente
 
 > Exemplo:
 */
let vehicles = [Car(), Train(), Train(), Car()]
print(vehicles[2] is Car)
let testCar = vehicles[0] as! Car
testCar.gear = 2
//: [Protocols](@next)
