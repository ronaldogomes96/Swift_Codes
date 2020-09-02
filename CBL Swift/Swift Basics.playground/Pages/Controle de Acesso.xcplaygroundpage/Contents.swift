//: [Generics](@previous)
/*:
 # Controle de Acesso
 
 Controle de Acesso restringe o acesso a partes do seu código por outras partes do projeto, ou outros módulos. Essa funcionalidade permite que uma classe A não conheça os detalhes da implementação da classe B, por exemplo, e permite que você defina uma interface especifica entre as duas classes, para que uma possa utilizar os recursos e métodos da outra.
 
 Você pode definir níveis de acesso específicos para tipos individuais (classes, estruturas, enums) como também para propriedades, métodos, initializers, e subscripts pertencentes a esses tipos. Protocolos também podem ser definidos como restritos para um determinado contexto, assim como constantes globais, variáveis e funções.
 
 Além de oferecer vários níveis de acesso diferentes, a linguagem Swift reduz a necessidade de especificar controle de acesso explicito para cada códifo, definindo controle de acesso por padrão para cenários comuns no fluxo de desenvolvimento. De fato, se você está escrevendo um App com um único target, você não precisa especificar níveis de controle de acesso específico nenhum.
 
 Os vários aspectos do seu código que podem ter controle de acesso aplicados a eles (propriedades, tipos, funções, entre outros) são referidos como "entidades" nas sessões abaixo.
    
 ### Modulos e Arquivos Fontes
 
 O modelo de controle de acesso na linguagem Swift é baseado no conceito de módulos e arquivos fonte.
 
 Um módulo é uma única unidade de distribuição de código - um framework ou aplicação que é compilada e distribuída como uma única unidade e que pode ser importada por outro módulo com a palavra chave `import`.
 
 Cada build target (tal como a bundle de um App ou Framework) no Xcode é tratada como um módulo separado em Swift. Se você agrupar aspectos do código do seu app como um framework stand-alone - talvez para encapsular e reutilizar esse código em multiplas aplicações - então tudo que você definir dentro desse framework vai ser parte de um módulo separado quando importado dentro de algum aplicativo, ou quando for usado dentro de um outro framework.
 
 Um arquivo fonte é um único arquivo de código em Swift dentro de um módulo (ou seja, um único arquivo dentro de um App ou Framework). Apesar de ser comum definir tipos individuais em arquivos fonte separados, um único arquivo fonte pode conter as definições de múltiplos tipos, funções e assim por diante.
 
 ### Níveis de Acesso
 
 A linguagem Swift provê 5 níveis de acesso diferentes para as entidades contidas no seu código. Esses níveis de acesso são relacionados ao arquivo fonte em que a entidade for definida, e também relativo ao módulo que o arquivo fonte pertence.
 - O acesso _open_ e _public_ permite que entidades sejam usadas em qualquer arquivo fonte dentro de um mesmo módulo, e também por outro módulo que o importe. Geralmente usamos _open_ ou _public_ quando especificamos a interface publica de um módulo para um framework. A diferença entre _open_ e _public_ é descrita abaixo:
 
 - _open_ é o nível de acesso mais alto (menos restritivo), e privado é o nível de acesso mais baixo (mais restritivo).
 
 - _private_ restringe o uso de uma entidade à entidade que faz a sua declaração, e às extensões dessa entidade que estão no mesmo arquivo. Use _private_ para esconder detalhes da implementação de uma parte específica de uma entidade quando essa entidade for usada em outras entidades.
 
 - _fileprivate_ restringe o uso de uma entidade ao arquivo que a define. Use _fileprivate_ para esconder os detalhes da implementação de uma parte específica de uma funcionalidade quando esses detalhes forem usados fora do arquivo que a implementa.
 
 - _internal_ permite que as entidades sejam usadas em qualquer arquivo fonte dentro do módulo que a define, mas não em um arquivo fonte fora desse módulo. Você geralmente usa _internal_ quando define a estrutura interna de um framework que você está usando.

 O nível de acesso _open_ pode ser aplicado somente à classes e membros de uma classe. O que o difere do nível de acesso _ public_ é permitir que um código fora do módulo possa fazer subclasses e sobrescrita (override) das propriedades de métodos. Marcar uma class como _open_ indica explicitamente que você considerou o impacto de código de outros módulos usando aquela classe como superclasse, e que você implementou seu código preparado para isso.
 
 ### Níveis de Acesso Padrão
 
 Todas as entidades do seu código (com algumas exceções específicas) tem seu nível de acesso padrão definido como _internal_ se você não especificar um nível de acesso. Como um resultado, em muitos casos você não precisa especificar níveis de acesso explícitos no seu código.
 
 ### Níveis de Acesso para Apps que tem um único Target
 
 Quando você constroi um App que tem somente um Target, o código do seu app está geralmente auto-contido dentro do próprio App e não precisa estar disponível para um módulo externo. O nível de acesso padrão _internal_ já faz com que esse requisito seja cumprido. Portanto, você não precisa especificar níveis de acesso dentro do seu código. Porém, você pode querer marcar partes do seu código como fileprivate ou private com o objetivo de esconder detalhes da implementação de outros códigos no seu aplicativo.
 
 ### Níveis de Acesso para Frameworks
 
 Quando você desenvolve um framework, marque a interface pública desse framework como _open_ ou _public_ assim ele poderá ser visto e acessado por outros módulos, como um app que importa esse framework, por exemplo. Denominamos essa interface pública como sendo a API do framework.
 
 Qualquer detalhes internos da implementação do seu framework ainda poderá usar o nível de acesso padrão _internal_ ou pode ser marcado como _private_ se você quer escondê-los de outras partes do código interno do seu framework. Você precisa marcar uma entidade como _open_ ou _public_ somente se você quiser que ela seja parte da API do seu framework.
 
 ### Níveis de Acesso para Targets de Testes Unitários
 
 Quando você implementa um App com um Target de teste unitário, o código do seu App precisa estar disponível para o módulo de testes unitários para poder ser testado. Por padrão, somente entidades marcadas como _open_ ou _public_ são acessíveis a outros módulos. Porém, um Target de Teste Unitário pode acessar qualquer entidade interna, se você marcar o _import_ para um módulo com o atributo _@testable_ e compilar aquele módulo com a opção de testar habilitada.
 
 ### Sintaxe dos Níveis de Acesso

 */

//public class SomePublicClass {}
//internal class SomeInternalClass {}
//fileprivate class SomeFilePrivateClass {}
//private class SomePrivateClass {}

//public var somePublicVariable = 0
//internal let someInternalConstant = 0
//fileprivate func someFilePrivateFunction() {}
//private func somePrivateFunction() {}

/*:
 A não ser que seja especificado, o nível de acesso padrão de uma classe é _internal_:
 
     class SomeInternalClass {}              // implicitly internal
     let someInternalConstant = 0            // implicitly internal

 ### Tipos Customizados
 
 Se você quer especificar um nível de acesso explícito para um tipo customizado, faça isso no trecho em que você define o Tipo. Assim, o novo Tipo poderá ser usado onde seu nível de acesso permitir. Por exemplo, se você define uma classe como _fileprivate_, essa classe só poderá ser usada como o tipo de uma propriedade, como o parametro de um função, ou retorno de uma função dentro do arquivo fonte em que o Tipo foi definido.
 
 O controle de nível de acesso de um Tipo também afeta o nível de acesso padrão dos membros desse Tipo (propriedades, métodos, inicializadores, e subscripts). Se você define o nível de acesso de um tipo como _private_ ou _fileprivate_, o nível de acesso padrão dos seus membros também serão _private_ ou _fileprivate_. Se você definir o nível de acesso do um Tipo como _public_ ou _internal_ (ou não especificar nenhum nível de acesso), o nível de acesso padrão dos membros desse Tipo serão internal por padrão.
 
 _**IMPORTANTE**_
 
 Um Tipo que tem nível de acesso _public_ terá, por padrão, membros com nível de acesso _internal_, e não _public_. Se você quer que o membro de um tipo seja _public_, você deve explicitamente marcar esse membro como _public_. Esse requisito vai assegurar que a API pública de um tipo seja sempre algo que você optou por deixar público, e evita que membros internos sejam publicados na API pública por engano.

*/

public class SomePublicClass {                  // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

class SomeInternalClass {                       // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class SomeFilePrivateClass {        // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class SomePrivateClass {                // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

/*:
 ### Tipos Tupla
 
 No caso de um Tipo definido como uma tupla, o nível de acesso desse Tipo será o nível mais restritivos dos Tipos que formam a tupla. Por exemplo:
 */
 
//typealias Tuple = (SomePrivateClass, SomePublicClass)

/*:
 O nível de acesso das Tuplas é sempre inferido a partir dos tipos que ela é formada, e não podem ser configurados de outra forma.
 
 ### Tipos Função
 
 O nível de acesso de um tipo Função é calculado como o nível de acesso mais restritivo dentre os níveis de acesso dos parametros e retornos da função. Você deve especificar o nível de acesso explicitamente como parte da definição de uma função se o nível de acesso inferido a partir dos tipos de parametro e retorno não bater com o padrão do escopo.
 
 O exemplo abaixo define uma função flobal chamada someFunction(), sem prover um nível de acesso específico para a função em si. Você pode esperar que essa função tenha o nível de acesso padrão _internal_, mas esse não é o caso. Na verdade, someFunction() não vai compilar se escrita da seguinte forma:
 
     func someFunction() -> (SomeInternalClass, SomePrivateClass) {
         // function implementation goes here
     }
 
 O tipo de retorno da função é uma Tupla composta por duas classes definidas anteriormente. Uma dessas classes é definida como _internal_, e a outra como _private_. Portanto, o nível de acesso da Tupla é _private_ (o nível de acesso mímimo dentre os tipos que formam a tupla).
 
 Por conta disso, o tipo de retorno da função é _private_, você deve marcar a definição da função inteira como _private_ para que ela seja válida:
 
     private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
         // function implementation goes here
     }
 
 Não é válido marcar a definição de someFunction() como _public_ ou _internal_, ou usar o valor padrão _internal_, porque eles não batem com o nível de acesso do tipo de retorno.
 
 ### Tipos Enum
 
 Os _cases_ de um _enum_ automaticamente recebem o mesmo nível de acesso do _enum_ a qual eles pertencem. Você não pode especificar níveis de acesso diferentes para cada _case_.
 
 No exemplo abaixo, o _enum_ CompassPoint tem seu nível de acesso explicitado como _public_. Por conta disso, todos seus _cases_ também são _public_:
 */

public enum CompassPoint {
    case north
    case south
    case east
    case west
}

/*:
 ### Raw Values e Associated Values
 
 Os tipos usados por qualquer _raw value_ ou _associated values_ na definição de um _enum_ tem que ter nível de acesso pelo menos tão alto quanto o nível de acesso do _enum_ em si. Por exemplo, você não pode usar um tipo _private_ como _raw value_ de um _enum_ com nível de acesso _internal_.
 
 ### Tipos Aninhados (Nested Types)
 
 O nível de acesso de um _nested type_ é o mesmo que o tipo que o contém, a não ser que o o tipo que o contém seja público. Tipos aninhados definidos dentro de um tipo _publico_ tem automaticamente o nível de acesso _internal_. Se você quer que um _nested type_ tenha nível de acesso _public_ isso deve ser explicitado na declaração do _nested type_.
 The access level of a nested type is the same as its containing type, unless the containing type is public. Nested types defined within a public type have an automatic access level of internal. If you want a nested type within a public type to be publicly available, you must explicitly declare the nested type as public.
*/

public class Type {
    
    class InternalNestedType { } //internal
    
    public class PublicNestedType { } //public
    
}

/*:
 ### Subclasses
 
 Você pode fazer uma subclasse de qualquer classe que possa ser acessada no contexto de acesso atual e que for definida no mesmo módulo que a sua subclasse. Você também pode criar subclasses que qualquer classe de outro módulo que esteja marcada como _open_. Uma subclasse não pode ter um nível de acesso mais alto que a sua superclasse. Por exemplo, você não pode implementar uma subclass _public_ de uma superclass _internal_.
 
 Para classes definidas no mesmo módulo, você pode sobreescrever qualquer membro de uma classe que está visível em determinado contexto de acesso. Para classes que são definidas em outros módulos, você só pode fazer isso para membros e classes marcadas como _open_.
 
 Um _override_ pode fazer com que um membro herdado de uma classe seja mais acessível que a o da sua superclasse. No exemplo abaixo, a classe A é _public_ com um método chamada someMethod() marcado como _fileprivate_. Class B é uma subclasse de A, com o nível de acesso reduzido para _internal_. Apesar disso, a classe B provê um _override_ de someMethod() com o tipo de acesso _internal_, que é maior que o da implementação original.
 An override can make an inherited class member more accessible than its superclass version. In the example below, class A is a public class with a file-private method called someMethod(). Class B is a subclass of A, with a reduced access level of “internal”. Nonetheless, class B provides an override of someMethod() with an access level of “internal”, which is higher than the original implementation of someMethod():
 */

public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {}
}


/*:
 É ainda válido que o membro de uma subclasse chame o membro da sua superclasse que tem nível de acesso menor que o da sua subclasse, contanto que a chamada para o membro da superclasse aconteça dentro do contexto de acesso permitido (ou seja, dentro do mesmo arquivo no caso de _fileprivate_ ou dentro do mesmo módulo no caso do _internal_).
 */

internal class C: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

/*:
 Porque a superclasse A e a subclasse C estão definidas dentro do mesmo arquivo fonte, é válido que a implementação de someMethod() da classe C chame super.someMethod().

 ### Getters and Setters
 
 Getters e Setters automaticamente recebem o mesmo nível de acesso que as constantes, variáveis, propriedades ou subscripts que as definem.
 
 Você pode dar nível de acesso menor a um setter do que ao getter para restringir o acesso de read-write do escopo de uma variável, propriedade ou subscript. Você atribui um nível de acesso menor da seguinte maneira:
 
     private(set) var numberOfEdits = 0

 Essa regra se aplica tanto a stored properties quanto a computed properties. Mesmo que você não escreva explicitamente um getter e um setter para uma stored property, a linguagem Swift sintetiza um getter e setter implicito para você prover acesso ao armazenamento de um stored property. Use _fileprivate(set)_, _private(set)_, e _internal(set)_ para mudar o nível de acesso desse setter sintetizado da mesma maneira que em computed properties.
 
 O exemplo abaixo define uma estrutura chamada TrackedString, que guarda o número de vezes que uma string foi modificada.
 */
 
 struct TrackedString {
     private(set) var numberOfEdits = 0
     var value: String = "" {
         didSet {
            numberOfEdits += 1
         }
     }
 }

/*:
 Se você cria uma TrackedString e modifica o value dessa string algumas vezes, você poderá ler a propriedade numberOfEdits depois para ver quantas vezes ela foi modificada, mas não poderá atribuir um valor a ela manualmente:
*/

var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")
// Prints "The number of edits is 3"

//stringToEdit.numberOfEdits = 0   // Can't do this!

/*:
 Node que você pode atribuir um nível de acesso explícito para ambos getter e setter se necessário. O exemplo abaixo mostra uma versão da TrackString na qual a estrutura é definida com o nível de acesso _public_. Portanto, os membros dessa estrutura (incluindo a propriedade numberOfEdits) tem nível de acesso _internal_ por padrão. Você pode setar o getter da propriedade numberOfEdits como _public_, e o setter como _private_, combinando ambos:
 */

public struct TrackedStringPublic {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

/*:
 ### Initializers
 
 Inicializadores customizados podem ter nível de acesso menor ou igual aos tipos que eles inicializam. A única exceção é para inicializadores obrigatórios (required initializers). Um required initializer deve ter o mesmo nível de acesso da classe que ele pertence.
 
 ### Default Initializers
 
 A linguagem Swift automaticamente provê default initializers sem qualquer argumentos para qualquer estrutura ou classe que provê valores padrões para todas as suas propriedades e não tem pelo menos um initializer.
 
 Um default initializer tem o mesmo nível de acesso que o definido no Tipo, a não ser que o Tipo esteja definido como _public_. Nesse caso, o default initializer será considerado _internal_. Se você quer que um tipo publico possa ser inicializado em outro módulo, você deve especificar um default initializer com nível de acesso _public_.
 */

public class PublicType {
    
    let property: String = "Default Value"
    
    //Uncomment the following line to make the initializer acessible to another modules. (Ouside this Target).
    //public init() { }
    
}

/*:
 
 ### Protocols
 
 Se você quer atribuit um nível de acesso explícito para um tipo protocolo, faça isso quando definir o protocolo. Isso permite que você crie protocolos que podem ser adotados dentro de certos contextos de acesso.
 
 O nível de acesso de cada requisito (propriedade ou funcao) dentro da definição de um protocolo tem automaticamente o mesmo nível de acesso do protocolo. Você não pode definir o nível de acesso do requisito de um protocolo como diferente do que o seu protocolo suporta.
 
 Se você definir um protocolo como _public_, os requisitos desse protocolo tem que ser obrigatoriamente implementados como _public_. Esse comportamento é diferente dos outros tipos, onde os membros de um Tipo _public_ seriam _internal_.
 
 ### Herança de Protocols
 Se você definir um novo protocol que herda de um protocolo existente, o novo protocolo pode ter no máximo o mesmo nível de acesso que o protocolo o qual ele herda. Por exemplo, você não pode escrever um protocolo _public_ que herda de um protocolo _internal_.
 
 ### Conformidade de Protocol
 
 Um tipo pode estar conforme a um protocolo com nível de acesso mais baixo que o tipo em si. Por exemplo, você pode definir um tipo _public_ que pode ser usado em outros modulos, mas que a conformidade a um protocolo _internal_ só possa ser usada dentro da definição do módulo em que ele foi implementado.

 Quando você escreve ou extende um tipo que tem conformidade com um protocolo, você deve se asegurar que a implementação de cada protocolo que o tipo assina tem ao menos o mesmo nível de acesso que a conformidade do tipo para aquele protocolo. Por exemplo, se um tipo _public_ está conforme um protocolo _internal_, a implementação do requisito de cada protocolo nesse tipo tem que ser pelo menos _internal_.
 
 Em Swift, como em Objective-C, conformidade de protocolo é global - Não é possível que um tipo assine um protocolo de duas maneiras diferentes dentro de um mesmo programa.
 
 ### Extensões (Extensions)
 
 Você pode extender uma classe, estrutura, ou enum em qualquer contexto de acesso no qual a classe, estrutura, ou enum esteja disponível. Qualquer membro de um tipo adicionado dentro de uma extensão irá ter o mesmo nível de acesso padrão que os outros membros declarados no escopo original do tipo. Se você extender um tipo _public_ ou _internal_, qualquer novo membro que você adicionar terá nível de acesso _internal_.
 
 Alternativamente, você pode marcar uma extensão com modificador de nível de acesso explícito (por exemplo, _private_) para definir um novo nível de acesso padrão para todos os membros definidos na extensão. Esse novo valor padrão pode ser sobreescrito dentro da extensão para aqueles membros específicos.
 
 Você não pode prover um modificador de nível de acesso explícito para uma extensão se você estiver usando essa extensão para adicionar conformidade a um protocolo. Em vez disso, o nível de acesso do protocolo é usado para provê o nível de acesso padrão para cada implementação de requisito de cada protocolo dentro da extensão.
 
 ### Membros Privados em Extensões
 
 Extensões que estão no mesmo aquivo que a classe, struct, ou enum extendida se comportam como se o código da extensão tivesse sido escrito como parte da declaração origin de um tipo. Como resultado, você pode:
 
 Declarar um membro _private_ na declaração original, e acessar esse membro de uma extensão que está no mesmo arquivo.
 Declarar um membro _private_ em uma extensão, e acessar esse membro em outra extensão no mesmo arquivo.
 Declarar um membro _private_ em uma extensão, e acessar esse membro dentro da declaração original que está mesmo arquivo.
 
 Esse comportamento significa que você pode usar extensões da mesma maneira para organizar seu código, tendo ou não tipos com entidades privadas. Por exemplo, dado o simples protocolo a seguir:
 */

protocol SomeProtocol {
    func doSomething()
}

//: Você pode usar uma extensão para adicionar conformidade a  um protocolo, assim:

struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}

/*:
 ### Tipos Genéricos (Generics)
 
 O nível de acesso de um tipo genérico ou função genérica é o menor nível de acesso dentre os níveis de acesso do tipo genérico ou função em si e o nível de acesso do tipo de todos os parâmetros da função.
 
 ### Type Aliases
 
 Qualquer typealias que você definir será tratado como tipo distinto parar o propósito de controle de acesso. Um typealias pode ter um nível de acesso menor ou igual ao nível de acesso do tipo que ele _alias_. Por exemplo, um typealias _private_ pode _alias_ um tipo _private_, _fileprivate_, _internal_, _public_, ou _open_. Mas um typealias _public_ não pode _alias_ um tipo _internal_, _fileprivate_, ou _private_.
 
 Essa regra também se aplica a typealiases de associated types usados para satisfazer algum protocol.
 */
