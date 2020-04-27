import Foundation

//guard verifica se a condição é true 
//Caso não, entra no else
//O else tem que ter um retorno ou um throw
func verificaNumero(num: Int?){
    guard let numero = num else {
        print("Valor nao valido")
        return 
    }
    print("O numero é \(numero)")
}
//Entao podemos passar qualquer coisa, inclusive nil
verificaNumero(num: 12)

//Erros podem ser criados em enums parra ser usados posteriormentes
enum errosOperacoes: Error{
    case raizNegativa
    case dividoPorZero
} 
var num1: Double = -1
var num2: Double = 0
var num3: Double = 2

func operacoes (n1: Double, n2: Double, n3: Double) throws -> (Double , Double){
    if n1 == -1{
        //Ele lança essa exepction caso entre na condição
        throw errosOperacoes.raizNegativa
    }else if n2 == 0{
        //Da mesma forma aqui
        throw errosOperacoes.dividoPorZero
    }
    else{
        //Caso nao, entra no else
        return (sqrt(n1), n3/n2)
    }
}

//Precisa do do try catch quando existe a possibilidade de um erro
do {
    //O try onde pode haver algum tipo de erro
    let resultado = try operacoes(n1: 3, n2: num2, n3: num3)
    //Caso não tenha erro, ele continua e não executa o catch
    print("O resultado é \(resultado)")
//O catch pode ter varios erros diferentes
}catch let raiz as errosOperacoes{
    print("Opa foi lançado o erro \(raiz)")
//O ultimo erro não precisa ser especifico
}catch{
    print("Opa foi lançado um erro \(error)")
}

//Loops
//Em um for sobre um array podemos pegar o index e o valor
var arr = ["Ronaldo", "Joao", "Israel", "Maria", "Levi"]
for (index, valor) in arr.enumerated(){
    print("O \(index + 1) nome é \(valor)")
}
//Funciona tambem em dicionario, usando o key
