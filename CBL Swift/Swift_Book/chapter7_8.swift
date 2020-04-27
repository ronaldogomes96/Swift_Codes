
//Tuplas podem ser heterogenias porem com tamanho definido
let tupla1 = ("one", 2 , "tree", 4)
print(tupla1.2) 

//Outra forma de referenciar uma tupla, com chaves
let tupla2 = (first: "one", second: 2, third: "tree")
print(tupla2.third)

//Uma função pode retornar uma tupla
func retornaTupla () -> (Int, String) {
    return (5 , "Ronaldo")
}
let tupla3 = retornaTupla()
print(tupla3)

//Tuplas podem ser usadas para trocar variaveis
var a = 1
var b = 2
var c = 3
(a , b , c) = (c , b , a)
print(a , b , c)

//Enuns sao formas de agrupar valores
enum Direcao{
    case cima
    case baixo
    case direita
    case esquerda
}
//Forma de printar um valor de uma enum
print(Direcao.direita)

//ENUNS
//Enums podem receber valores
enum Action {
    case pular
    case chutar
    case andar (distancia: Float)
}
print(Action.chutar)
print(Action.andar(distancia: 3.43))

//Enuns podem ter valores chaves
enum JupiterMoon: Int {
    case Io = 1
    case Calisto
    case Ganimedes
}
print(JupiterMoon(rawValue: 3)!)

//Enuns podem ter um construtor que inicia algum valor
//Tambem podem conter funções
enum Coordenadas {
    case norte(Int)
    case sul(Int)
    case leste(Int)
    case oeste(Int)

    init?(degree: Int){
        switch degree{
            case 0...5:
                self = .norte(degree)
            case 6...10:
                self = .leste(degree)
            case 11...15:
                self = .oeste(degree)
            case 16...20:
                self = .sul(degree)
            default:
                return nil
        }
    }

    func value ()  -> Int? {
        switch self{
            case .norte(let degree):
                return degree
            case .sul(let degree):
                return degree
            case .leste(let degree):
                return degree
            case .oeste(let degree):
                return degree
        }
    }
}

var direcao = Coordenadas(degree: 2)
print(direcao!)
print(direcao!.value()!)
direcao = Coordenadas(degree: 80)
// print(direcao!.value()!) Da um erro enorme 

//Enuns podem ficar dentro de outras enuns
