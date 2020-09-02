import Foundation

/*:
 [Tratamento de Erros](@previous)
 
 # Generics

 Código Genérico permite que você escreva funções ou tipos flexíveis e reutilizáveis que podem funcionar com qualquer tipo, relacionado aos requisitos que você define. Você pode escrever código que evita duplicação e expressa suas intenções de uma maneira clara e abstrata.

 Generics é uma das funcionalidades mais poderosas da linguagem Swift, e muitas das libs padrões da linguagem são construídas com código genérico. Na verdade, você já tem usado generics (mesmo não tendo implementado) durante seu estudo de Swift, mesmo que não perceba. Por exemplo, os tipos Array e Dictionary em Swift são ambos coleções genéricas. Você pode criar um array que contém valores elementos do tipo Int, ou um array que contém elementos do tipo String da mesma forma. Similarmente, voc6e pode criar um dicionário que guarda valores de um tipo especifico, e não há limitações para a escolha desse tipo.

 ## O problema que Código Genérico Resolve
 
 Observe a função não genérica abaixo, que faz a troca dos valores de duas variáveis inteiras uma pela outra.
*/
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}

/*:Essa função faz uso de parametros in-out para fazer a troca dos valores a e b, como explicado no tópico de Propriedades In-Out.

A função swapTwoInts(_ : _ :) troca o valor original de _b_ pelo valor de _a_, e o valor original de _a_ pelo de _b_. Você pode chamar essa função para trocar os valores de duas variáveis do tipo Int:
*/
//var someInt = 3
//var anotherInt = 107
//print(someInt,anotherInt)
//swapTwoInts(&someInt, &anotherInt)
//print(someInt,anotherInt)
/*:
 A função swapTwoInts(_ : _ :) é útil, mas só pode ser usada em valores do tipo Int. Se você quiser trocar os valores de duas variáveis do tipo String, ou Double, você consegue fazer isso escrevendo mais funções, como abaixo:
*/
func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let tempA = a
    a = b
    b = tempA
}

//var a = "A"
//var b = "B"
//print(a,b)
//swapTwoStrings(&a, &b)
//print(a,b)

/*:
 Note que o corpo de swapTwoInts(_ : _ :), swapTwoString(_ : _ :), e swapTwoDoubles(_ : _ :) são exatamente iguais. A única diferença é o tipo dos valores que cada função aceita. (Int, String, e Double).
 
 É mais útil, e consideravelmente mais flexível, escrever uma única função que troca dois valores de qualquer tipo. Código genérico (ou Generics) permite que você escreva uma função que faça isso. (Uma versão genérica dessas funções é definida abaixo):

_NOTA_

 Em todas as três funções, os tipos de _a_ e _b_ tem que ser exatamente o mesmo. Se _a_ e _b_ não forem do mesmo tipo, não é possível trocar os seus valores. Swift é uma linguagem _type-safe_ - isso quer dizer que a linguagem não permite (por exemplo) que uma variável do tipo String receba um valor do tipo Double, ou qualquer tipo diferente. Qualquer tentativa de uma operação assim resultará em um Erro em tempo de compilação. Uma variável de um determinado tipo _T_ só pode receber valores desse mesmo tipo _T_.
 
 ## Funcões Genéricas
 Funções genéricas podem funcionar com parâmetros de qualquer tipo. Abaixo está a implementação genérica da função swapTwoInts(_ : _ :), chamada agora de swapTwoValues(_ : _ :)
*/
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

//var a = "A"
//var b = "B"
//print(a,b)
//swapTwoValues(&a, &b)
//print(a,b)

//let json: [String : Any] = [
//    "numero" : 9,
//    "nome": "Gabi",
//    "dicionario": [
//        "key" : "value"
//    ]
//]
//
//if let numero = json["nome"] as? Int {
//    print(numero + 1)
//}

/*:
 O corpo da função swapTwoValues(_ : _ :) é identica ao do corpo do swapTwoInts(_ : _ :). Entretanto, a primeira linha da função swapTwoValues(_ : _ :) é um pouco diferente da primeira linha da função swapTwoInts(_ : _ :). Comparando as duas linhas temos:
*/
func nonGenericSwapTwoInts(_ a: inout Int, _ b: inout Int) {}
func genericSwapTwoValues<T>(_ a: inout T, _ b: inout T) {}
/*:
 A versão genérica da função usa um tipo _placeholder_ (chamado T, nesse caso) em vez de ter o nome de um tipo de fato (Int, String, ou Double por exemplo). O nome do tipo _placeholder_ não diz nada sobre qual tipo a variável T deve ser, mas diz que ambos _a_ e _b_ devem ser do mesmo tipo T, seja lá qual for o tipo que T representa. O tipo que será usado de fato no lugar de T é determinado sempre que a função swapTwoValues(_ : _ :) é chamada.
 
 Outra diferença entre uma função genérica e uma função não genérica é que o nome da função genérica (swapTwoValues(_ : _ :)) é seguido pelo nome do tipo _placeholder_ (T) dentro de _angle brackets_ (<T>).
 Os _angle brackets_ sinalizam que T é o nome de um tipo _placeholder_ na definição da função swapTwoValues(_ : _ :). Por conta de T ser um _placeholder_, a linguagem Swift não vai procurar pela definição de fato de um tipo chamado T.

 A função swapTwoValues(_ : _ :) pode agora ser chamadad do mesmo jeito que swapTwoInts, com a diferença que os paramêtros da função podem receber valores de qualquer tipo, contanto que esses valore sejam do mesmo tipo um do outro. Sempre que a função swapTwoValues(_ : _ :) for chamada, o tipo que assumirá o lugar de T será inferido a partir dos valores passados nos paramêtros da chamada a função.

 Nos dois exemplo abaixo, T é inferido para ser Int e String respectivamente:
*/
var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)

var someString = "A"
var anotherString = "B"
swapTwoValues(&someString, &anotherString)
/*:0
 _NOTA_

 A função swapTwoValues(_ : _ :) definida acima é inspirada por uma função genérica chamada swap, que é parte da lib padrão da linguagem Swift, e está automaticamente disponível para uso no desenvolvimento dos seus Apps. Se você precisar do comportamento da função swapTwoValues(_ : _ :) no seu próprio código, você pode usar a função padrão _swap( _ : _ :)_ em vez de criar sua própria implementação.
 
 ## Type Parameters
 
 No exemplo swapTwoValues( _ : _ :) acima, o tipo placeholder T é um exemplo de Type Parameter. Type Parameters especificam e nomeiam um tipo _placeholder_, e são escritos imediatamente após o nome da função genérica, entre _angle brackets_ (como em <T>).

 Quando você especificar um type parameter, você pode usar isso para definir o tipo dos parametros de uma função (como os parametros _a_ e _b_ no exemplo anterior), ou como o tipo de retorno da função, como a notação de tipo no corpo da função. Em cada caso, o type parameter é substituído pelo tipo de fato que é inferido quando a função quando é chamada.

 Você pode provê mais de um type parameter escrevendo múltiplos nomes como type parameter dentro de _angle brackets_, separado por vírgulas. (<T, U, V, X>)

 ## Nomeando Type Parameters
 
 Na maioria dos casos, type parameters tem nomes descritivos, como Key e Value no Dictionary<Key, Value> e Element no Array<Element>, que nos comunica qual a relação entre os type parameters e a função genérica em que eles são usados. Entretanto, quando não é uma relação significativa entre eles, tradicionalmente eles são nomeados usando uma única letra como T, U, e V, como usado no exemplo anterior.

_NOTA_

 Sempre nomeie type parameters com CamelCase começando com letra maiúscula para indicar que eles são um _placeholder_ para um tipo, e não um valor.

 ## Tipos Genéricos
 
 Em adição a funções genéricas, em Swift você pode definir seus próprios Tipos Genéricos. Tipos Genéricos são classes, structs e enums que podem trabalhar com qualquer tipo, de maneira similar a Array e Dictionary.
 
 Essa sessão irá mostrar como escrever uma coleção genérica chamada Pilha. Uma Pilha é conjunto ordenado de valores, parecido com um array, mas com operações mais restritas. Um array permite que novos items sejam inseridos e removidos em qualquer lugar no array. Uma Pilha, entretanto, só permite que novos itens sejam adicionados após o último elemento, ou seja, no fim da coleção (essa operação é conhecida como _push_). Similarmente, uma Pilha só permitem que itens sejam removidos no fim da coleção, ou seja, só é possível remover o último item da coleção (essa operação é conhecida como _pop_). Essa estrutura é conhecida por ter ter comportamento LiFo (Last In, First Out) pois o último elemento adicionado é o primeiro a ser removido.

_NOTA_

 O conceito de uma stack é usada pela class UINavigationController para modelar as view controllers na sua hierarquia de navegação. Você pode chamar o método `pushViewController(_ : animated :)` da classe `UINavigationController` para adicionar (push) uma view controller na pilha da navigationController, ou você pode chamar o método `popViewControllerAnimated(_ :)` para remover (pop) uma view controller da pilha de navegação da navigationController. Uma pilha é um modelo de coleção útil sempre que você precisa de um comportamento estritamente _last in, first out_ para gerenciá-la.
 Observe o exemplo abaixo, que implementa uma pilha não genérica de valores inteiros:
*/
struct IntStack {
    private var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}
/*:
 Essa estrutura usa uma propriedade do tipo Array chamado _items_ para armazenar valores na pilha, e implementa dois métodos, _push_ e _pop_, para adicionar e remover valores da pilha. Esses métodos estão marcados como mutating porque eles modificam valores originais da própria struct, que são, no caso, os elementos do array _items_.

 O tipo IntStack mostrado acima só pode ser usado com valores do tipo Int. Seria muito mais útil definir um tipo genérico Stack, que pode gerenciar pilhas contendo elementos de qualquer tipo.

Observe abaixo uma versão genérica do mesmo cóigo:
*/
struct Stack<Element> {
    private var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
/*:
 Note como a versão genérica da Pilha é essencialmente a mesma que a da versão não genérica, mas contendo um type parameter chamado Element, em vez de um tipo Int. Esse type parameter está escrito entre _angle brackets_ (<Element>) logo após o nome da struct.

 Element define um placeholder para um tipo ser provido depois. Esse tipo futuro pode ser referido como Element em qualquer lugar dentro da definição do strcut. Nesse caso, Element é usado como um placeholder em três lugares:
 
 Para criar uma propriedade chamada _items_, que é inicializada com um array vazio de valores do tipo Element
 Para especificar que o método `push(_ :)` tem um único parametro chamado item, que deve ser do tipo Element
 Para especificar que o valor retornado pelo método `pop()` será um valor do tipo Element
 Porque é um tipo genérico, Stack pode ser usada para criar uma pilha de qualquer tipo válido em Swift, de maneira semelhante a um array ou dicionário.
 
 Você pode criar uma nova pilha escrevendo o tipo a ser armazenado na pilha dentro de _angle brackets_. Por exemplo, para criar uma nova pilha de Strings, você escreve Stack<String>():

*/
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
/*:
 Remover o valor de uma pilha também o retorna. Por exemplo, se removermos um valor da pilha atual, o valor retornado será "cuatro".
*/
//print(stackOfStrings.pop())
/*:
 
 ## Extendendo um Tipo Genérico
 
 Quando você extende um tipo genérico, você não precisa prover a lista de type parameter como parte da definição da extensão. Em vez disso, a lista de type parameter da definição original fica disponível no corpo da extensão, e os nomes originis dos type parameters são usados para se referir aos type parameters da definição original.
 
 O exemplo a seguir extende o tipo genérico Stack para adicionar uma propriedade computada read-only chamada topItem, que retorna o item do topo da pilha sem removê-lo da pilha:

*/
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
/*:
 A propriedade topItem retorna um valor opcional do tipo Element. Se a pilha estiver vazia, topItem retorna nil; se a pilha não estiver vazia, topItem retorna o item final do array de itens.

 Note que essa extensão não define uma lista de type parameter. Em vez disso, o nome do type parameter existente do tipo Stack, Element, é usado na extensão para indicar o tipo da propriedade topItem, que também é opcional.

 A propriedade computada topItem pode agora ser usada em qualquer instancia de Stack para acessar ou buscar o item do topo da pilha sem removê-lo.
*/
//if let topItem = stackOfStrings.topItem {
//    print("Top item:",topItem)
//}
/*:
 (?)
 Extensões de um tipo generico também podem requerir que instancias daquele tipo extendido sejam satisfeitas para que possam ganhar nova funcionalidade, como explicado na sessão de Extensions com Generic Where abaixo.
 Extensions of a generic type can also include requirements that instances of the extended type must satisfy in order to gain the new functionality, as discussed in Extensions with a Generic Where Clause below.

 ## Type Constraints
 A função swapTwoValues(_ : _ :) e o tipo Stack podem trabalhar com qualquer tipo. Entretanto, às vezes é útil reforçar certos type constraints nos tipo que podem ser usados quando implementando funções e tipo genéricos. Type constraints especificam que um type parameter tem que herdar de uma classe específica, ou estar em conformidade com um protocolo específico.

 Por exemplo, o tipo Dictionary em Swift impõe uma limitação nos tipos que podem ser usados como chaves. Como explicado na sessão Dictionaries, o tipo da chave de um dicionário em Swift deve estar em conformidade com o protocolo Hashable. Isso quer dizer que tal tipo deve prover uma maneira de fazer com que cada valor possa ser indexado por uma chave garantidamente única. Um Dictionary precisa que cada chave seja hashable, para que assim seja possível checar se determinada chave já contém um valor. Sem esse requerimento, não seria possível inserir ou substituir um valor para uma determinada chave num Dicionário, nem seria possível garantir a leitura de determinado valor indexado pela chave.

 Esse requisito é implementado pela utilização de um type constraint no tipo key (chave) da definição de Dictionary, que especifica que o tipo da chave deve estar em conformidade com o protocolo Hashable, um protocolo especial definido na lib padrão de Swift. Todos os tipos básicos de Swift (String, Int, Double, e Bool) são hashable por padrão.
 
 Type constraints em Generics são muito poderosos. Você pode definir seus próprios type constraints quando cria um tipo Generico, e implementar comportamentos no seu código a partir de conceitos abstratos como Hashable.
 
 ## Sintaxe de Type Constraint
 
 Você define um type constraint escrevendo o nome de uma classe ou protocolo logo após o nome do type parameter, separado por dois pontos, como parte da lista de type parameters.

*/
class SomeClass { }
protocol SomeProtocol { }

func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // corpo
}

/*:
 A função acima tem dois parametros. O primeiro, T, tem um type constraint que requer que T seja uma subclasse de SomeClass. O segundo type parameter, U, tem um type constraint que requer que U esteja em conformidade com o protocolo SomeProtocol.

 ## Type Constraints em Ação
 
 Aqui está uma função não genérica chamada findIndex(ofString:in:), que acha o index de um elemento específico dentro de um array de Strings. Se o elemento buscado não for encontrado, a função retorna nil.
*/
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
/*:
 Uso:
*/
let strings = ["cat", "dogs", "llama", "parakeet"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is:",foundIndex)
}
/*:
 Esse tipo de função seria útil se implementada para arrays de tipos genéricos. Você pode implementá-la substituindo o tipo do array e do valor a ser encontrado por T. Note que o retorno da função continua sendo Int? porque o index de qualquer array é do tipo Int, independente do tipo dos seus elementos.
*/
func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}


/*:
 A função acima não compila, porque nem sempre será possível comparar dois valores em Swift com o operador ==, mesmo que eles sejam do mesmo tipo. Um exemplo disso é se você criar uma estrutura que representa um modelo complexo de dados, e o significado de "igual a" para aquela estrutura não é algo que a linguagem consegue inferir. Portanto, porquê o corpo da função findIndex tem um uso do operador ==, definir T sendo um type parameter genérico sem type constraints não garante que o código funcionará para todas as chamadas dessa função.
 
 Existe uma solução! A linguagem Swift tem por padrão um protocolo chamado Equatable, que requer que qualquer tipo que conforme a ele implemente o operador "igual a" (==) e o oposto dele (!=) para que seja possível comparar dois valores daquele mesmo tipo. Todos os tipos padrões em Swift são equatable por padrão.

 Qualquer tipo que é Equatable pode ser usado sem problemas na função findIndex, porque é garantido que tais tipos suportam o operador (==). Parar expressar esse fato adicionamos o type constraint Equatable como parte da definição de type parameters da versão genérica da função:
*/



/*:
 Assim, definimos que T pode ser qualquer tipo que conforme com o protocolo Equatable, e que consequentemente tem implementado o operador ==.
 Exemplos de uso da função findIndex genérica
*/
let doubleIndex: Int? = findIndex(of: 9.4, in: [3.14159, 0.1, 0.35])

let stringIndex: Int? = findIndex(of: "Andrea", in: ["Mike", "Malcom", "Andrea"])

print(doubleIndex!)
print(stringIndex!)

/*:
 ## Associated Types
 
 Quando definimos um protocolo, às vezes é útil declarar um ou mais associated types como parte da definição. Um associated type define um espaço reservado (placeholder) para um outro tipo que é usado como parte do protocolo que está sendo definido. O tipo que será de fato utilizado no lugar desse associated type não é especificado até que o protocolo que o contém seja adotado. Para utilizar esse recurso, usamos a palavra reservada associatedtype.

 ## Associated Types em Ação
 
Vamos implementar um protocolo Container que tem um associated type Item na sua definição:
*/
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
/*:
 O protocolo acima define que todo Tipo que assinar o protocolo Container deve satisfazer 3 requisitos:

 - Deve ser possível adicionar um novo item ao container utilizando a implementação do método append(_:).
 - Deve ser possível acessar a quantidade de items do container através da propriedade count.
 - Deve ser possível acessar qualquer item dentro do container via index utilizando subscript.

 Esse protocolo não especifica nenhum tipo específico de Item para o Container. Ele só especifica as operações e funcionalidades mínimas que uma classe ou struct deve implementar para que ela seja considerada um Container.

 Qualquer tipo que conforma com o protocolo Container deve ser capaz de especificar o tipo dos valores que ele armazena. Especificamente, ele deve se certificar que o Container só aceita append e subscript desse tipo em particular dentro da sua estrutura.

 Para satisfazer esses requisitos, o protocolo Container precisa de uma maneira para se referir aos elementos que ele aceita, sem saber qual o tipo específico desses elementos. O protocolo deve especificar que o valor passado para o método append(_:) tem o mesmo tipo que os elementos do container, e o mesmo tipo que é retornado no subscript.

 É para garantir isso que o protocolo Container declara um associated type chamado Item, escrito como associatedtype Item. O protocolo não define qual tipo esse Item será, entretanto define que seja lá qual for o tipo definido para Item, ele será utilizado no lugar de Item em todos os lugares onde Item tiver sido utilizado dentro do protocolo.

 Vamos implementar abaixo uma versão não genérica da struct IntStack que assina o protocolo Container:
*/
struct IntStackContainer {
    
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
}

extension IntStackContainer: Container {
    
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
    
}

//var stack = IntStackContainer()
//stack.push(10)
//stack.push(9)
//stack.push(8)
//stack.append(11)
//print(stack[3])
/*:
 Versão genérica:
*/
struct StackContainer<Element: Equatable> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

//extension StackContainer: Container {
//
//    typealias Item = Element
//    mutating func append(_ item: Element) {
//        self.push(item)
//    }
//    var count: Int {
//        return items.count
//    }
//    subscript(i: Int) -> Element {
//        return items[i]
//    }
//
//}

//var s = StackContainer<String>()
//s.append("Eita")
//s.append("Godzilla")
//print(s.count)
//print(s[1])
/*:
 
 ## Adicionando Constraints a um Associated Type
 
 Você pode adicionar type constraints a um associated type em um protocolo para requerir que os tipos que assinam esse protocolo satisfaçam essas constraints. Por exemplo, o código abaixo diz que Item deve ser Equatable.

*/
protocol ContainerEquatable {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

extension StackContainer: ContainerEquatable {
    
    typealias Item = Element
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
    
}

//: [Controle de Acesso](@next)
