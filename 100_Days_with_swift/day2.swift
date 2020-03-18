// Arrays
let Pai = "Joao"
let Mae = "Maria"
let filho = "Jose"
let filha = "Ana"

let familia = [Pai, Mae, filha, filho]
print(familia[2]) //Ana
//Sets
// Sao como arrays, porem com duas diferenças
//1. Os itens sao armazenados de forma aleatoria
//2. Nao pode haver os mesmos elementos mais de uma vez
let cores = Set(["azul", "amarelo", "rosa"])
let cores2 = Set(["azul", "amarelo", "rosa", "amarelo", "azul"])
//So armazena "azul", "amarelo", "rosa"
//Tuples
//Tambem parecem arrays, mas com algumas diferenças
// Todos os elementos precisam ser do mesmo tipo
//Nao pode adicionar nem remover elementos apos a crição, porem pode mudar eles
var nome = (primeiro: "Ronaldo", ultimo: "Gomes")
print(nome.primeiro) //Ronaldo
print(nome.0) //Ronaldo

//Dicionarios
//Podem ser acessados pelas 'keys'
let altura = [
    "Joao": 1.78,
    "Maria": 1.73
]
print(altura["Joao"]) //Joao
//Pode-se criar uma collection vazia
//Dicionario
var teams = [String: String]() //Pode se adicionar depois
//Arrays 
var results = [Int]()
//Set, que é um pouco diferente
var words = Set<String>()

//Enums
//Sao formas de agrupar valores
enum Resultado {
    case successo
    case falha
}
let resul1 = Resultado.successo
let resul2 = Resultado.falha
//Tambem podem armazenar valores associados
enum Atividade {
    case chato
    case correr(destino: String)
    case conversar(assunto: String)
    case cantar(volume: Int)
}
//Entao pode mudar o valor
let talk = Atividade.conversar(assunto:"Futebol")
// Tambem pode ser criados valores para os enums
enum Planeta: Int {
    case mercurio
    case venus
    case terra
    case marte
}
let earth = Planeta(rawValue: 2) //Terra
//Ou voce pode iniciar o numero da sequencia
enum Planet: Int {
    case mercurio = 1 
    case venus
    case terra
    case marte
}