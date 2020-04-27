
struct Delivery {
    var range: Double
    var Location: Double
}
//Forma de iniciar uma struct
var pizza = Delivery(range: 23.3232, Location: 232.32323)
print(pizza.range) //Forma de visualizar uma variavel

//Quando uma struct tem um metodo mutante, ela
//não pode ser instanciada numa var

//Sets são collections sem ordem de valores unicos
var Cores : Set = ["roxo", "marron", "Azul"]
print(Cores) //Printam de forma aleatoria
Cores.insert("Rosa") //Insere no set
print(Cores)
Cores.remove("marron") //Remove do set  
print(Cores)
print(Cores.contains("roxo")) //Retorna true pois contem

//Dicionarios são formas de agrupamento por keys
var livros = [1: "Livro 1", 2: "Livro 2", 3: "Livro 3"]
print(livros[1]!)

//Dicionarios não são ordenados
for book in livros.values{
    print("Esse é o livro \(book)")
}

//Podemos mudar os elementos de um dicionario
livros[1] = "Livro 4"
print(livros)

//Switch é uma estrutura de condição
//Pode ser usado com where
var temperatura = 30
switch(temperatura) {
    case 0...49 where temperatura %  2 == 0:
        print("Cold and even")
    case 50...99 where temperatura % 2 == 0:
        print("Warm and even")
    case 100...149 where temperatura % 2 == 0:
        print("Hot and even")
    default:
        print("Temperatura fora do range")
}
