/*:
 [Optionals](@previous)
 
 # Enumerations
 
 Um Enumeration define um tipo para um grupo de valores associados, permitindo trabalhar com eles de uma maneira type-safe dentro do seu código.
 
 Enumerations são tipos de primeira classe, ou seja:
 * Podem ser retorno de funções
 * Podem ser passadas com paramêtros em funções
 * Podem ser construídas em tempo de execução
 
 Além de adotar funcionalidades tradicionalmente suportadas apenas por classes, tais quais:
 * Inits
 * Funções de instância e estáticas
 * Podem ser extendidas
 * Assinar protocolos
 * Possuír variavéis computadas
 
 
 ### Sintaxe
 > **Prática:**
 > Vamos declarar um enumeration de pontos cardeais.
 */
// Um conjunto limitado de itens

enum Cardinal {
    case south
    case north
    case west
    case east
}

enum Planet {
    case mercury, venus, earth, mars
}

/*:
 Cada enumeration define um novo tipo, e como outros tipos em Swift seus nomes devem começar com uma letra maiúscula.
 
 > **Prática:** Vamos agora atribuir a variável *direction* um *Cardinal*.
 */

let direction = Cardinal.south

//let direction: Cardinal = .south


/*:
 ### Switch e Enums
 Enums podem ser usados com Switches de maneira muito simples.
 
 > Um switch deve ser exaustivo quando utilizado enums, quando não for apropriado um caso para cada enum, você pode utilizar o *default*
 
 > **Prática:** Vamos criar um switch que imprima uma String de acordo com o *Cardinal* dado.
 */

switch direction {
case .north:
    print("go to the north son")
default:
    print("go wherever you want")
}

/*:
 > Podemos também como comentado, atribuir variavéis computadas aos nossos Enums
 */

extension Cardinal {
    var phrase: String {
        switch self {
        case .north:
            return "go to the north son"
        default:
            return "go wherever you want"
        }
    }
}

print(Cardinal.north.phrase)


/*:
 ### Iterando entre cases de Enumeration
 
 Para alguns enums, é interessante que tenhamos uma coleção com todos os possiveis casos, para isso, tudo que você precisa fazer é assinar o protocolo `CaseIterable`.
 
 > **Prática:**
 > Vamos declarar um Enum que assine o protocolo e iterar sob seus casos.
 */

enum Animals: CaseIterable {
    case Dog, Cat, Mouse, Horse, Cow
}

for animal in Animals.allCases {
    print(animal)
}

/*:
 ### Associated Values
 No **Swift** Enumerations podem associar valores de qualquer tipo a seus cases.
 Isso permite:
 * Armazenar informações adicionais ao case
 * Informações variadas a cada uso dentro do código
 * Associar tipos diferentes para cada case
 
 Exemplo:
 
 
 ![Barcode](Barcode.png)
 ![QRCode](qrcode.png)
 */

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
productBarcode = .QRCode("ABCDDEFJGLA")


switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check)")
case .QRCode(let productCode):
    print("QR Code: \(productCode)")
}

/*:
 ### Raw Values
 
 Permite valores padrões para os cases de um enumeration.
 
 > Raw Values são sempre do mesmo tipo
 */

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}


/*:
 > Atribuição implícita
 */

enum Planets: Int {
    case mercury = 1, venus, earth, mars
}

enum CompassPoint: String {
    case north
    case south
    case west
    case east
}
//: [Classes e Structs](@next)
