//FUNÇÕES
func printAjuda() {
    let message = """
Welcome to MyApp!
Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
    print(message)
}
//Entao podemos chamar a função
printAjuda()

//Podemos passar parametros para a função
func square(number: Int) {
    print(number * number)
}
square(number: 8) //Precisamos indicar o nome da variavel da função
//Para retornar valores, temos que indicar o tipo do valor retornado
func quadrado(number: Int) -> Int {
    return number * number
}
let result = quadrado(number: 8)
print(result)

//Podemos usar dois nomes de parametros
//O primeiro pra usar externamente e o outro para usar internamente na função
func sayHello( to name: String) {
    print("Hello, \(name)!") //name: Dentro da função
}
sayHello(to: "Ronaldo") //to: fora da função
//Porem podemos nao especificar o nome da variavel na chamada da função
//usando o _ no parametro da função
func saudacao(_ person: String) {
    print("Hello, \(person)!")
}
saudacao("Ronaldo") //Entao podemos passar so a variavel
//Pode-se adicionar valores default(padrao) aos parametros
func greet(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}
greet("Ronaldo") //Logo podemos mudar ou nao o valor padrão
greet("Ronaldo", nicely: false)

//As funções podem receber um numero desconhecido de valores
//Especificamos isso usando ... apos o tipo da variavel
//Swift converte automaticamente os valores em um array
func aoquadrado(numbers: Int...) {
    for number in numbers {
        print("\(number) ao quadrado é \(number * number)")
    }
}
aoquadrado(numbers: 1, 2, 3, 4, 5) //Podemos pssar inumeros parametros
//As vezes as funções tem algum erro inesperado, entao podem lançar erros
// Primeiramente precisamos enumerar os tipos de erros
enum PasswordError: Error {
    case obvious
}
//Precisamos usar a palavra-chave throws antes do retorno da função
//Entao indicar quando passar a instrução
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}
//Porem, ainda precisamos de alguma especificações para executar o erro
// Para isso usamos tres palavras chaves
//do: inicia a seção de codigo que pode haver algum erro
//try: usa quando a função pode gerar um erro
//catch: captura qualquer erro no bloco do
do {
    try print(checkPassword("password"))
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

//Os valores originais das variaveis poddem ser mudados apos uma função
func doubleInPlace(number: inout Int) {
    //inout indica que o valor sera mudado na variavel externa
    number *= 2
}
var myNum = 10 
doubleInPlace(number: &myNum) 
//precisamos usar & para indicar que essa variavel esta sendo mudada globalmente