var str = "Hello, playground"
//É necessario utilizar o var para a primeira declaracao da variavel
str = "Hello"
print(str)
str="Hy"

var numero = 12345
print(numero)

//Tres aspas deixa que seja uma frase longa
//pulando linhas
str = """
Essa
frase
esta
quebrada
"""
print(str)

//Numeros reais
var num = 3.1415

//Boelanos
var bol = true

print (num, bol)

var frase = "O valor do numero pi é \(num)"
print(frase)

//Com o let é posssivel criar constantes
let constante = "Nao pode ser mudada"
print(constante)

//Os tipos das variaveis podem ser especificados
let nome: String = "Ronaldo"
let idade: Int = 23
let altura: Double = 1.65
let matematica: Bool = true
