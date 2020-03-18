// Operandos aritmeticos
// + - * / % 
//Swift nao permite a mistura de tipos diferentes
// O + pode ser usado para diversas funções
var nome = "Ronaldo"
var nomeCompleto = nome + "Gomes"
let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf //Junção de arrays
//Pemite os operandos compostos
// += -= *= /=
var frase = "Estou estudando "
frase += "Swift" 

//Operadores de comparação
// == != > < >= <=
//Funciona para strings
print("Ronaldo" >= "Gomes") //Verifica pela ordem alfabetica
//Condicionais
let firstCard = 11
let secondCard = 10
if firstCard + secondCard == 2 {
    print("Aces – lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}
var weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
default:
    print("Enjoy your day!")
}

//Existem tambem os condicionais
//&& and  || or
//Operador ternario
print(firstCard == secondCard ? "Cards are the same" : "Cards are different")

//Operador de range
//Existem duas formas de criar range em swift
// ..< que nao inclui o fim 1..<4 que fica 1 2 3 
//... que inclui o fim 1...4 que fica 1 2 3 4