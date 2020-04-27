import Foundation

//Formas de colocar numero com expoentes
//Todas as formas multiplicam a 10 elevados a potencia indicada
print(223e5)
print(223E5)
print(223e+5)

print(String(9090)) //Converte o int em string

let converteu = String(9)
print(converteu)

//Round
//Arrendoda a pra cima partir do .5
var num1 = 3.01
print(num1.round()) //Dessa forma nao aparece nada
num1 = 3.49
num1.round() //Modifica a variavel originial
print(num1)
num1 = 3.5
num1.round()
print(num1)

print(Int(7.55)) //Forma de converter um numero double para string
//Arredonda para baixo

//Numeros aleatorios
let aleatorio = Int.random(in: 1...3) //gerra um aleatorio do tipo int
print(aleatorio)


//Exponenciação
let potencia = pow(7.0, 2.0) //7^2
print(potencia)