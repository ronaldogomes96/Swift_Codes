/*:
 [Primeiros Passos](@previous)
 
 # Operadores Básicos
 
 **Swift** da suporte a maioria dos operadores padrões de C e adiciona várias melhorias para evitar erros comuns de programação.
 
 
 # Operador de atribuição
 
 Já usamos o operador de atribuição diversas vezes nos exemplos anteriores. O operador de atribuição é usado para inicializar uma variável e/ou atualizar o seu valor.
 
 > **Prática:**
 > Criar uma variável e associar um valor a ela.
 */

//
var nome = "Ronaldo"
//

/*:
 # Operadores aritiméticos
 
 **Swift** suporta quatro operadores aritiméticos padrões para os tipo numéricos.
 * Adição (+)
 * Subtração (-)
 * Mutiplicação (*)
 * Divisão (/)
 
 > **Prática:**
 > Realizar as quatro operações citadas acima e atribuir a uma variável.
 */

//
//

/*:
 # Operadores de atribuição compostos
 
 Assim como em outras linguagens Swift da suporte a junção do operador de atribuição com os operadores aritiméticos.
 * Adição (+=)
 * Subtração (-=)
 * Mutiplicação (*=)
 * Divisão (/=)
 
 > **Prática:**
 > Inicializar uma variável e realizar as quatro operações citadas acima.
 */

//
//

var a = 15
a += 1

/*:
 # Operadores de comparação
 
 Assim como em outras linguagens Swift da suporte a todos os operadores de comparação padrões.
 * Equal to (a == b)
 * Not equal to (a != b)
 * Greater than (a > b)
 * Less than (a < b)
 * Greater than or equal to (a >= b)
 * Less than or equal to (a <= b)
 
 > **Operador de identidade:**
 > Além dos operadores padrões citado acima, exite o operador de identidade (=== e !==), que verificam se duas referências apontam para o mesmo objeto.

 > **Prática:**
 > Realzar um teste booleano para cada operador citado acima.
 */

//
//

/*:
 # Operadores de intervalo (Range operators)
 
 **Swift** torna fácil a criação de intervalos (Ranges) com o uso do operadores de intervalo.
 
 * Intervalos fechados - Um intervalo fechado (a...b) define um intervalo de `a` até `b` incluindo os dois valores.
 * Intervalos semi-aberto - Um intervalo semi-aberto (a..<b) define um intervalo de `a` até `b` que não inclui o `b`
 
 
 > **Prática:**
 > Criar um intervalo fechado e outro intervalo semi-aberto.
 */
//
//
let inter = 1...10

1..<10
//: [Estruturas Condicionais](@next)
