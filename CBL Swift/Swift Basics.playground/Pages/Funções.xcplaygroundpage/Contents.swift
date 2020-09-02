/*:
 [Controle de Fluxo](@previous)

 # Funções
 
 Funções são conjuntos de código auto-contidos que realizam uma determinada tarefa. Funções são identificadas por um nome, que deve explicitar o seu propósito. É possível "chamar" as funções definidas por seu nome, para que realizem sua tarefa quando for necessário.
 
 > ![](Functions.png)
 
 > **Prática:**
 > Declare uma função chamada de sayHello que irá receber o nome de uma pessoa e irá retornar uma saudação com o nome recebido.
 
*/
 
 func sayHello(nome:String) -> String {
    print("Hello \(nome)!")
    return "Hello \(nome)!"
 }
 
 sayHello(nome: "Davi")
/*:
  Para declararmos funções com mais de um parâmetro, basta separarmos os parâmetros por virgulas.
  
  > **Prática:**
  > Declara uma função chamada de `sayHello` que irá receber o nome de uma pessoa, um booleano indicando se essa pessoal já foi cumprimentada e irá retornar uma saudação apropriada com o nome recebido.
*/
 
 func sayHello(nome:String, alreadyGreet:Bool) -> String {
    if alreadyGreet {
        return "Hello again \(nome)"
    }
    
    return "Hello \(nome)!"
 }
 
 sayHello(nome: "Davi", alreadyGreet: true)
 
 
/*:
  > **Prática:**
  > Declara uma função chamada de `sum` que irá receber 2 números inteiros e irá retornar a soma dos 2 valores.
  
*/
 
 //
func sum( num1: Int, num2:Int) -> Int{
    return num1 + num2
}
sum(num1: 2, num2: 5)
 //
 //
 
/*:
  ### Tipos de retornos
  
  Funções podem retornar qualquer um dos tipos de dados citados nas lições anteriores, entre eles estão: Tuplas, Intervalos (Range), Enumerados e estruturas definidas pelo programador.
  
  ### Parâmetros nomeados
  
  Assim como é Objective-C, parâmetros em Swift são nomeados. Cada parâmetro em uma função possui um **nome externo** que é usado por quem chama a função e um **nome interno** que é usado internamente na implementação da função.
  
  > Nomes externos podem ser omitidos usando um _. Caso nenhum **nome externo** seja especificado o **nome interno** será utilizado de ambas as formas.
  
  > **Prática:**
  > Vamos criar um função chamada `sayHi(to:and:)` que irá imprimir uma saudação para os nomes recebidos.
  
*/

func sayhi( _ to: String, _ and: String) -> String{
    return "Hi \(to) and \(and)"
}
 
sayhi("Joao", "Maria")
 
 func sayHi(_ nome:String) -> String {
    return "Hi \(nome)"
 }
 
 sayHi("Davi")
 
 
 
 //
 //
 
 
 
 
/*:
  
  > **Prática:**
  > Vamos criar um função chamada `greet(_:)` que irá imprimir uma saudação para o nome recebido, porém ela não deve conter nome externo.

*/
 
 //
 //
 //

 
/*:
  ### Parâmetros In-Out
  
  Por padrão os valores dos parâmetros em funções são cópias imutáveis dos valores originais que foram recebidos. Ocorrendo um erro em tempo de compilação se tentarmos muda-los, mas em alguns casos é desejável que as alterações feitas dentro de uma função sejam propagadas além da sua execução e isso é possível anotando nossos parâmetros como `inout`.
  
  > Parâmetros `inout` não são passados por referência, na verdade em Swift é usado um modelo copy-in copy-out, onde os valores alterados dentro da função são copiados de volta a variável original.
  
  > **Prática:**
  > Declarar uma função que receba dois números `inout` e faça a troca de seus valores, em seguida verificar se seus valores foram trocados.
  
*/

 var int1 = 10
 var int2 = 20
 
 func swapValues(_ num1: inout Int, _ num2: inout Int) {
    let temp = num1
    num1 = num2
    num2 = temp
 }
 
 swapValues(&int1, &int2)
 
 print("int1 = \(int1) e int2 = \(int2)")
 
 
/*:
  
  # Tipos de funções
  
  Diferente de outras linguagens, em **Swift** funções possuem um tipo que é composto pelo tipos dos seus parâmetros e o tipo do seu retorno. Dessa forma é possível passar funções como parâmetro para outras funções, retornar funções a partir de outras funções e atribuir funções para outras variáveis.
  
  Para a função `sayHello` podemos expressar o seu tipo com a seguinte notação.
  ````
  (String) -> (String)
  ````
  Para a função `sayHello(_:alreadyGreeted:)` podemos expressar o seu tipo com a seguinte notação.
  ````
  (String, Bool) -> (String)
  ````
  
  > **Prática:**
  > Para cada função declarada anteiormente criar uma variável compatível com o tipo da função.
*/
 
 var funcao: (String) -> (String) = sayHello
 
 funcao("Davi")

/*:
  # Closures
  
  Agora que entendemos como expressar tipos de funções, podemos atribuir funções à variáveis e passar e retornar funções a partir de outras funções. Esse tipo de comportamento recebe a denominação de **closures**. Closures são blocos de códigos auto-contidos que podem ser usados durante a execução da sua aplicação e uma de suas principais caracteristicas é a habilidade de capturar e referenciar variáveis no contexto em que foram definidas.
  
  ### map, filter & reduce
  
  Para entendermos melhor como **closures** funcionam vamos aplicá-las em um contexto funcional usando as funções `map`, `filter` e `reduce`.
  
  ### map
  Muitas vezes é necessário realizar transformação de valores em Arrays e geralmente realizamos essa tarefa iterando nossa coleção e armazenando as transformações em um Array auxiliar. Com a função `map` podemos realizar essas mesmas transformações de forma mais segura e menos verbosa.
  
  > **Prática:**
  > Declarar um Array de Inteiros e aplicar uma transformação usando `map` que retorne um Array que contenha cada valor ao quadrado.

*/
 
 let integers = [1,2,3,4,5,6,7,8,9,10]
 
 let arrayDobrado = integers.map { (valor) -> Int in
    print(valor)
    return valor * 2
 }
 
/*:
  ### filter
  Outra operação bastante comum é criar um novo Array a partir de elementos que atendam a uma certa condição. Para isso temos a função `filter` que recebe como parâmetro uma função que retorna um booleano indicando se o valor avalido deve ser incluido no Array resultante.
  
  > **Prática:**
  > Filtrar os números pares do Array de Inteiros criado anteriormente.
*/
 
let pares = integers.filter { (valor) -> Bool in
    valor % 2 == 0
 }
 
/*:
  ### reduce
  Por fim temos `reduce`, essa função é usada para combinar os elementos de um Array em um novo valor. Começamos com fornecendo um valor inicial e uma função que irá combinar os valors subsequentes.
  
  > **Prática:**
  > Realizar a soma dos Inteiros do Array declarado anteriormente.
*/
 
 let somatorio = integers.reduce(0) { (valorPrevio, valor) -> Int in
    return valorPrevio + valor
 }

/*:
  > **Prática:**
  > Implementar a função filter.
*/
 
 func customFilter(array:[Int], completionHandler: (Int) -> (Bool)) ->[Int] {
    var resultArray = [Int]()
    
//    for i in array where completionHandler(i) {
//        resultArray.append(i)
//    }
    
    for i in array {
        if completionHandler(i) {
            resultArray.append(i)
        }
    }
    return resultArray
 }
 
 customFilter(array: integers) { (valor) -> (Bool) in
    valor % 2 == 0
 }
 
 func funcao(valor:Int) -> Int? {
    return nil
 }
 
 
 
