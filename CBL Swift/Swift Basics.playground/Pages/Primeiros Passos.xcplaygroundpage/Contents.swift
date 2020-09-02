/*:
 # Swift
 
 É a nova linguagem de programação para iOS, OS X, Watch OS e tvOS. Foi criada por [Chris Lattner](https://en.wikipedia.org/wiki/Chris_Lattner) e apresentada em 2014 durante a WWDC. É uma linguagem **multiparadigma** e tem como influência linguagens como: Objective-C, Rust, Haskell entre outras.
  
 
 # Contantes e Variáveis
 
 A declaração de contantes e variáveis associam um nome a um valor.
 
 ### Variáveis
 > **Prática:**
 > Vamos declarar uma variável chamada *nomeCompleto* e associar seu nome a ela.
 */

//
//
var nomeCompleto = "Davi Cabral de Oliveira"

/*:
 Como é de se esperar variáveis podem ter seu valor alterado.
 
 > **Prática:** Vamos agora atribuir o nome de sua dupla a variável *nomeCompleto*.
 */

//
//
nomeCompleto = "Daniel"
nomeCompleto
/*:
 ### Constantes
 Para declara uma contante basta usarmos a palavra reservada *let* ao invés de *var*. Vale lembrar que constantes não podem ter seu valor alterado depois de sua primeira atribuição.
 
 > Sempre que o valor de uma variável não for mudar durante o seu tempo de vida devemos declarar ela como uma constante.
 
 > **Prática:** Vamos criar a constante *nomeCurso* com o nome do seu curso.
 */

//
//
let nomeCurso = "Ciência da Computação"

/*:
 # Anotação de tipos e Inferência de tipos
 
 **Swift** é uma linguagem fortemente tipada e de verificação estática de tipos, por isso o tipo de uma variável não é alterado depois de sua atribuição inicial. Como pode ser observado nos exemplos acima, devido ao mecanismo de *inferência de tipos* não presicamos declarar explicitamente o tipo de cada variável que criamos.
 
 > Na grande maioria das vezes o mecanismo de *inferência de tipos* é capaz de descobrir o tipo correto de uma variável.
 
 > **Prática:**
 > Vamos declara uma constante do tipo String explicitando o seu tipo.
 */

//
//

let string: String = "Minha String"

/*:
 # Tipos de Dados
 
 **Swift** tem um sistema de tipos rico, possuindo representação para os tipos mais comuns como: Inteiros, números de ponto-flutuante, Booleanos, String, Caracteres.
 
 > **Prática:**
 > Vamos declara uma variável de cada tipo citado acima.
 */

//
//
let int: Int = 10
let float: Float = 15.0
let double: Double = 20.0
let char: Character = "A"

/*:
 ### Tuplas
 
 Tupla, é um tipo de dado composto usado para agrupar outros tipos. Elas podem ser usadas como qualuqer outro tipo de dado e também usadas como parâmetro e/ou retorno de funções.
 
 > **Prática:**
 > Declarar uma tupla que contenha as coordenadas x e y de um ponto.
 */

//
//
let coordenada: (x:Float, y:Float) = (10.0, 300)

/*:
 > Ao declarar um tupla podemos nomear seus elementos.
 
 > **Prática:**
 > Melhore a compreensão da tupla criada anteriormente dando nomes aos seus elementos.
 */

//
//
//let coordenada: (x: Float, y: Float) = (x: 10.5, y: 300)


/*:
 # Type Aliases
 
 *Type Aliases* definem um nome alternativo para um tipo já existente. *Type Aliases* são criados com a palavra reservada **typealias**
 
 > **Prática:**
 > Dê um identificador significativo para a tupla que você criou anteriormente.
 */

//
//
typealias Coordenada = (x: Float, y: Float)
let c: Coordenada = (x: 15, y: 300)
c.x
c.y




//: [Operadores Básicos](@next)
