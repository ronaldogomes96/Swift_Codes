/*:
 [Coleções](@previous)
 
 # Estruturas de Controle de Fluxo
 
 **Swift** provê um conjunto de estruturas para controle de fluxo dentro da sua aplicação. Além das estruturas condicionais explicadas anteriormente, também é possível contar com estruturas de repetições tais como: `for-in`, `while` e `repeat-while`.
 
 # For-In
 Loops `for` são usados para iterar sequências como: Ranges e Coleções.
 
 > **Prática:**
 > Iterar nos valores de um Intervalo e imprimir seus valores.
 */
//
//

for i in 0...10 {
    
}

/*:
 Para iterar em coleções usamos a mesma lógica acima, mas no lugar de um Intervalo iremos usar a coleção que iremos percorrer.
 
 > **Prática:**
 > Iterar um Array com o nome de alguns de seus colegas do BEPiD e imprimir seus valores.
 */
//
//
var aeroportos = ["FOR", "SBAM", "SBGO"]

for (i, aeroporto) in aeroportos.enumerated() {
    print("\(i),\(aeroporto)")
}


/*:
 > **Prática:**
 > Iterar o Array acima e imprimir também o índice associado ao nome.
 */

//
//


/*:
 Também é possível iterar sobre os elementos de um Dicionário, onde cada iteração retorna uma tupla (chave, valor).

 > **Prática:**
 > Recriar o Dicionário de aeroportos da seção de **Coleções** e imprimir o código e o nome associado a ele.
 */
//




//

/*:
 ### where
 
 É usado para selecionar quais casos irão executar o trecho de código dentro do loop.
 
 > **Prática:**
 > Iterar um **Intervalo** de números e imprimir os valores pares.
 */

//
//

for i in 1...10 where i % 2 == 0 {
    print(i)
}

if 1...20 ~= 10 {
    print("BLA")
}

//repeat {
//    
//} while true




/*:
 # While & Repeat-While
 
 São duas estruturas de repetição baseadas em testes booleanos, `while` e `repeat-while` verificam se a condição de repetição é verdadeira no inicio e no final do laço respectivamente, caso a condição seja verdadeira o trecho de código contido dentro do laço é executado.
 */
var i = 0

while i <= 10 {
    print(i)
    i += 1
}

i = 0

print("repeat while")

repeat {
    print(i)
    i += 1
} while i <= 10


//: [Funções](@next)
