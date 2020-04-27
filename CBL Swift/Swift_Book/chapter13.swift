//Optionals são variaveis que podem conter valores ou nil
//Quando uma variavel é nil ela é uma optional

//Ambos são optionals
var numberOne: Int? = nil
var numberTwo: Int! = nil

//Um exemplo comun de optiona é quando convertemos tipos de valores
let str1 = "43"
let num1: Int? = Int(str1)
//Porem ela ainda gera uma optional do tipo Int
//Temos que desempacotar ela
//Usamos ! quando temos certeza que existe um valor valido na variavel
print(num1!)
let str2 = "Hello World"
let num2: Int? = Int(str2)
// print(num2!) Isso da um erro pois é nil

//Usar o ! não é uma forma segura de unwrapped a variavel
//Existe formas safes de fazer unwrapped
//Usando o if let
//Não gera um erro
var number: Int? 
if let unwrappedNumber = number {
    print("Number = \(unwrappedNumber)")
    //Caso tenha um valor valido, ele entre no if
}else{
    print("Number não tem valor valido")
    //Caso não tenha um valor valido
}

//Usando o guard let
number = 23
//Precisa ser gerado um erro pois é necessario no else do guard
enum erroVariavel: Error{
    case variavelNil
}
//Para então ser lançado no throw
guard let unwrappedNumber = number else {
    throw erroVariavel.variavelNil
}
//A vantagem do guard é que a variavel pode ser usada depois
print(unwrappedNumber)

//Nil Coalescing Operator
//Outra forma de unwrapped um valor nao nil
var str: String?
var str3 = str ?? "ERRO" //Assume o segundo valor caso seja nil
print(str3)

//Optionals ajudam no trabalho com variaveis nil
