//Podemos fazer um interpolação de strings
let number = 1
let vezesDois = "\(number*2)"

print(vezesDois)

let exemplo = "Esse post tem \(number) view\(number == 1 ? "" : "s")"
print(exemplo) //Podemos usar o ternario

//Podemos juntar um array de strings em uma string somente
let word = ["maça" , "laranja", "uva"]
let str = word.joined(separator: " & ")
print(str)
print(str.count) //Numero de caracteres na string
print(str.isEmpty)

//Verifica se a string e/ou termina com aquelas letras
print(str.hasPrefix("ma"))
print(str.hasSuffix("uva"))

//Podemos quebrar em um array
let dataNascimento = "28:09:1996"
let arr = dataNascimento.split(separator: ":")
print(arr)

//Boleanos geralmente sao usados em operadores ternarios