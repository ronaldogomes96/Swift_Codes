/*:
 [Estruturas Condicionais](@previous)
 
 # Coleções
 
 **Swfit** oferece três tipo de coleções: **Arrays**, **Sets** e **Dictionaries**. Arrays são coleções de valores ordenados, Sets é uma coleção que armazena valores únicos de forma não ordenada e enfim Dictionaries é uma coleção não ordenada que armazena valores na forma *chave-valor*.
 
 Assim como em outros tipos de variáveis coleções só podem armazenar valores do mesmo tipo. Na declaração de coleções podemos usar as palavras reservadas **var** para declarar coleções que podem modificadas e **let** para declarar coleções não mutáveis.
 
 ![](CollectionTypes.png)
 
 # Array
 Vamos começar analisando **Arrays**, que são coleções que armazenam valores de mesmo tipo e ordenadamente.
 
 > **Prática:**
 > Vamos declarar um array de inteiros mutável e outro não mutável.
 */

//
//
var inteiros = [Int](1...10)
let constInteiros = [Int](1...10)

/*:
 ### Literais
 
 Além dos inicializadores oferecidos, é possível criar novos Arrays usando a notação de literais. Literais são escritos como uma lista de valores, separadas por vírgulas entre colchetes.
 
        [valor1, valor2, valor3]
 
 > **Prática:**
 > Declarar uma lista de compras do tipo String usando a notação literal.
 */

//
//

var listaCompras = ["Arroz", "Feijão", "Carne"]



/*:
 Como é de se esperar existem diversos métodos para obter informações de um Array.
 
 > **Prática:**
 > Vamos verificar se nossa lista de compras está vazia e caso contrário vamos informar quantos itens ela contém.
 */

//
//

listaCompras.isEmpty

/*:
 Também é possível adicionar novos itens em um Array usando o método `append(_:)`
 
 > **Prática:**
 > Adicionar mais um item a lista de compras usando o método `append(_:)`
 */
//
//
listaCompras.append("Ovos")
/*:
 Para acessar os objetos que estão armazenados em um Array podemos usar a sintaxe de *subscripts*, passando o índice do elemento que queremos acessar dentro de colchetes após o nome do Array.
 
 > **Prática:**
 > Acessar o primeiro item da sua lista de compras.
 
 > **Prática:**
 > Acessar os dois primeiros itens da lista de compras usando um intervalo.
 */
//
//
listaCompras[1]
listaCompras[1...3]

/*:
 Para atualizar um valor no Array basta acessar o índice desejado usando a sintaxe de *subscripts* e atribuir um novo valor em seu lugar. Deletar itens também é bastante simples, basta usarmos o método `removeAtIndex(_:)`.
 
 > **Prática:**
 > Atualizar algum item da sua lista de compras.
 
 > **Prática:**
 > Remover algum item da sua lista de compras.
 */
//
//
listaCompras.remove(at: 2)
listaCompras
listaCompras[2] = "Biscoitos"
listaCompras

/*:
 # Dictionary
 
 **Dictionaries** armazenam associações não ordenadas num formato *chave-valor*, onde cada valor está associado a uma chave única.
 
 > **Prática:**
 > Vamos declarar um Dictionary de [String : Inteiros] mutável e outro não mutável usando a sintaxe de inicialização.
 */
//
//

var varDict = [String : Int]()
let dict = ["um" : 1, "dois" : 2]
dict["dois"]

/*:
 Assim como Arrays, Dictionaries também possuem uma sintaxe de inicialização usando literais. Literais são escritos como uma lista de pares *chave-valor*, separadas por vírgulas entre colchetes.
 
        [chave1 : valor1, chave2 : valor2, chave3 : valor 3]
 
 > **Prática:**
 > Vamos declarar um Dictionary [String : String] com a abreviação do [aeroporto](https://pt.wikipedia.org/wiki/Lista_de_aeroportos_internacionais#Brasil) como chave e a cidade como valor.
 */
//
//

//
//

var aeroportos = [String : String]()

/*:
 Para adicionar objetos em dicionários basta definir a chave desejada entre colchetes após o nome da variável e atribuir um valor a essa chave.
 
 > **Prática:**
 > Adicionar mais um par *chave-valor* no dicionários de aeroportos.
 */

//
//

aeroportos["FOR"] = "Fortaleza"
aeroportos
aeroportos["SBAM"] = "Amapá"
aeroportos
/*:
 Para remover pares de um dicionário basta acessarmos a chave desejada usando a sintaxe de *subscript* e atribuir `nil` a ela ou usar o método `removeValueForKey(_:)`.
 
 > **Prática:**
 > Remover um par *chave-valor* no dicionários de aeroportos.
 */

//
//

aeroportos.removeValue(forKey: "FOR")
aeroportos

/*:
 # Passagem por Valor
 
 Coleções em **Swift** são implementadas usando uma `struct` e por isso toda vez que atribuímos uma coleção a outra variável é feita uma cópia da variável original.
 
 > **Prática:**
 > Definir um Array de Inteiros e em seguida atribuir este Array a uma segunda variável. Realize alguma operação explicada anteriormente na segunda variável e analise o resultado.
 */

//
//
var aeroportos2 = aeroportos

//: [Estruturas de Controle de Fluxo](@next)
