import Foundation


//Extensions são formas de adicionar funcionalidades a tipos ja existentes
//Uma das maiores funcionalidades é poder extender protocolos

protocol Ordem {
    func doSomething()
}
//Na extension ja implementamos o metodo do protocolo
extension Ordem {
    func doSomething(){
        print("Limpe a casa")
    }
}
//Entao nao precisamos implementar onde for usado
struct ordemMae: Ordem{
    func myMetodo(){
        doSomething()
    }
}

let mae = ordemMae()
mae.myMetodo()


//Classes em swift so permitem herança simples
//Porem podemos fazer herança multipla com protocolos


//Downcasting é quando uma variavel é convertida para um subtipo
//as? Verifica se o subtipo pode ser convertido
//as! Força o subtipo a ser convertido, porem pode quebrar o programa
let value: Any = "Ronaldo"
if let name = value as? String {
    print(name)
}

//Generics
//Permite que escreva funçoes de tipos flexiveis
//Um bom exemplo é uma funçao que troca os valores entre duas variaveis
//<T> informa que pode ser de qualquer tipo

func trocaValores<T>( _ a :inout T, _ b: inout T){
    let troca = a
    a=b
    b=troca
}

//Primeiro com strings
var nome1 = "Maria"
var nome2 = "Joao"
trocaValores(&nome1, &nome2)
print("Nome 1 \(nome1) e Nome 2 \(nome2)")

//Agora com Int
var num1 = 10
var num2 = 20
trocaValores(&num1, &num2)
print("Numero 1 \(num1) e Numero 2 \(num2)")

