import Foundation

//Closures
//Sao blocos de codigos que podem ser armazenados e transmitidos em seu programa
//Funcionam como uma função
//Podem inclusive gerar erros

enum myErros: Error{
    case DivisaoPorZero
}

let dividirInts = { (x: Int, y:Int) throws -> Int in
    if y==0 {
        throw myErros.DivisaoPorZero
    }
    return x/y
}
do {
    //tem como diferenca a nao necessidade de informar o nome dos parametros
    let resultOk = try dividirInts(10,2)
    print(resultOk)

    let resultErrado = try dividirInts(2,0)
    print(resultErrado)
} catch {
    print("Impossivel divisao por 0")
}

//Podemos passar closures como parametros para funçõoes
//Podemos tambem retornar closures
func aoQuadrado (x: Int) -> (() -> Int) {
    let quadrado = { x*x }
    return quadrado
}
let treePow = aoQuadrado(x: 3)
let fivePow = aoQuadrado(x: 5)
print(treePow())
print(fivePow())
