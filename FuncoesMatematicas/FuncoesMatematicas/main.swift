
import Foundation

//Esse codigo é para testes de funcoes matematicas importantes

//Variaveis que serao usadas
let x: Double = 2
let euler: Double = 2.718281828459045
let pi: Double = 3.1415

//calcula a constante de euler elevado ao numero
print(" Exponencial de euler")
print( exp(1.0) ) //2.71
print( exp(x) ) // eˆ2

//calcula a constante de euler menos 1 elevado ao numero
print( expm1(1.0) ) //1.71

print(" Logaritmo")
//Calcula o logaritmo na base natural(de euler) do numero
print( log(1.0) ) // 0
print( log(euler) ) //1.0, pois é a mesmo numero

//Calcula na base 10 e 2
print( log10(x) ) //0.30
print( log2(x) )  //1

/*
    Sao mostradas uma serie de funcoes trigonometricas, inversas e hiperbolicas
    Os valores dentro dos parenteses sao em RADIANOS
 */

//Seno, Arcoseno e senoHiperbolico
print(" Seno")
print(sin(pi)) //0
print(sin(pi/2)) //1
print(asin(1.0)) //pi / 2
print(sinh(euler)) //7.54

print(" Cosseno")
print(cos(pi)) //-1
print(cos(0.0)) //1
print(acos(1.0)) //0
print(cosh(euler)) //7.61

print(" Tangente")
print(tan(pi/4)) //1
print(tan(pi/2)) //Infinito
print(atan(1.0)) //pi / 4
print(tanh(euler)) //1

//Potencia
print(" Potencia")
print(pow(x, 2.0)) //2ˆ2 = 4
print(pow(7.0, 3.0)) //343

//Raiz quadrada
print(sqrt(10)) //3.16
print(hypot(9.0, 3))
