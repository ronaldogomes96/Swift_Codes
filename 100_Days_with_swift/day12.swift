//Optionals
//Funciona quando queremos armazenar ou inicializar um valor
var age: Int? = nil
//depois podemos mudar o valor
age = 38

//Unwrapping optionals
//Caso queremos usar uma string e usar o .count
//temos que desvendar o optionals 
//usando if let
var name: String? = nil
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name.")
}

//Outra forma é usando o guard let
//Tem como grade diferença que apos ele, a variavel ainda esta disponivel
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    print("Hello, \(unwrapped)!")
}

//Podemos forçar o Unwrapping
//Como quando mudamos o tipo da variavel
let str = "5"
let num = Int(str)!

//Nil coalescing
//Ocorre quando damos um valor default para caso ocorra um nill
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}
let user = username(for: 15) ?? "Anonymous"
//Caso seja nil, a variavel assume anonymous
//Optional chaining
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased()
//caso o array fosse vazio, beatle seria nil