//Forma de declarar array vazio com um tipo especifico
var declarandoArray = [String]()

//Array com valores
var arrayPreenchido = [1,2,4,5,7]

//Array com valores repetidos
var arrayRepetido = Array(repeating: "Ronaldo", count: 4)
print(arrayRepetido)

//Array multidimensional
var matriz = [
    [1,2],
    [3,4]
]
print(matriz)

//Forma de selecionar com o tipo especifico
//Funciona com o compactMap
var arrayVariado : [Any] = [1, "x", "+", true, 2.3435, 4, false]
var arrayInt = arrayVariado.compactMap { $0 as? Int }
print(arrayInt)
var arrayStr = arrayVariado.compactMap { $0 as? String }
print(arrayStr)


//Reduce
var numbers = [1,2,3,4,5,6]
var somaNumbers = numbers.reduce(0, +)
print(somaNumbers) //21

var range = 2...4
var newNumbers = numbers[range]
print(newNumbers)

//Filter
var pares = numbers.filter { $0 % 2 == 0 }
print(pares)

//Map
var numbersString = numbers.map { String($0) }
print(numbersString)

//Max e Min
//É necesario utilizar o ! pois como não foi especificado
//o tipo do array, por padrão um optional
//logo é usado o ! para desembrulhar
print(numbers.min()!)
print(numbers.max()!)
