/*:
 [Operadores Básicos](@previous)
 
 # Estruturas Condicionais
 
 Em alguns casos é ideal que um certo trecho de código seja executada apenas se alguma condição seja satisfeita. Para esses casos **Swift** oferece duas estruturas condicionais básicas: `if` e `switch`.
 
 
 # If
 
 Na sua forma mais simples o `if` checa se uma condição é verdadeira e executa um trecho de código em seguida.
 
 > **Prática:**
 > Criar uma variável que armazena a temperatura atual em Fortaleza e em seguida exibe uma mensagem se a temperatura for maior que 30 graus.
 */


//
//

if 10 < 20 {
    print("Verdade!")
}

let nome = "Davi"



/*:
 ### else
 Também é possível oferecer um conjunto de alternativos de condições usando as contruções `else` e `else if`.
 
 > **Prática:**
 > Adicionar uma condição que verifica se a temperatura está entre 20 e 30 graus, uma condição `else` e por fim exibir uma mensagem apropriada para cada condição.
 
 > **Bônus:**
 > Pesquisar como verificar se a temperatura está entre 20 e 30 graus usando Intervalos.
 */

//
//
let temp = 9

if temp >= 20 && temp <= 30 {
    print("Agradável")
}else if temp > 30 {
    print("Tá Quente!")
}else {
    print("Tá frio")
}


/*:
 ### Operadoes ternários.
 Para uma verificação simples que retornam algum valor *Swift* oferece os operadores ternários. Sua contrução obedece o seguinte padrão: *<checagem> ? <retorno-verdadeiro> : <retorno-falso>*
 
 > **Prática:**
 > Usar o operador ternário para verificar se a temperatura em Fortaleza está abaixo de 10 graus e exibir a mensagem apropriada.
 */

//
//
temp < 10 ? "Muito Firo!" : "Outra"

/*:
 # Switch
 `switch` são usados para comparar uma variável a um conjunto possível de padrões.
 
 > Um `switch` deve conter todas as possibilidades de valores para a variável que está sendo avaliada.
 
 > **Prática:**
 > 
 */
switch nome {
    
case "Davi":
    print("Sou eu!")
    
case "Daniel":
    print(nome)
default:
    break
}

enum Temperatura {
    case frio
    case quente
}

let tempEnum = Temperatura.frio

switch tempEnum {
case .frio :
    print("frio")

case .quente :
    print("quente")
}

enum Light {
    case on
    case off
    
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}

var luz = Light.on
luz.toggle()
luz.toggle()

enum Alimentacao {
    case carnivoro
    case herbivoro
    
    var stringDescription: String {
        switch self {
        case .carnivoro:
            return "Sou carnivoro"
        case .herbivoro:
            return "Sou herbivoro"
        }
    }
    
    func description() -> String {
        switch self {
        case .carnivoro:
            return "Sou carnivoro"
        case .herbivoro:
            return "Sou herbivoro"
        }
    }
}

let alimentacao = Alimentacao.carnivoro
print(alimentacao.description())
print(alimentacao.stringDescription)
/*:
 ### Range
 Além de valores simples é possível usar `switch` para verificar se um determinado valor está contido em um intervalo.
 
 > **Prática:**
 >
 */

//
//

if 0...10 ~= temp {
    print("Entre 0 e 10")
}

switch temp {
case 0...10:
    print("Entre 0 e 10")
case 11...20:
    print("Entre 11 e 20")
case 21...30:
    print("Entre 21 e 30")
default:
    break
}

/*:
 ### Tuplas
 Também é possível avaliar *tuplas* de valores em um `switch`.
 
 > **Prática:**
 > Para um ponto (x, y) representado por uma tupla, verificar se esse ponto está na origem, no eixo-x, no eixo-y e o quadrante que o ponto está contido.
 
 ![](coordinateGraphSimple.png)
 */

//
//

typealias Coord = (x: Float, y: Float)
let coordenada: Coord = (x: 15, y: 10)

switch coordenada {
case (0, 0):
    print("Origem")
case (_, 0):
    print("No eixo x")
case (0, _):
    print("No eixo y")
    
case let (x,y) where x > 0 && y > 0:
    print("Primeiro Quadrante")
    
default:
    break
}


//: [Coleções](@next)
