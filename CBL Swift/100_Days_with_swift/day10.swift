//CLASSES
//São como structs, porem com algumas diferenças basicas
//Sempre tem que ser inicializadas
class Dog {
    var name: String
    var breed: String
    //Sempre tem que ser iniciadas
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
    func makeNoise() {
        print("Woof!")
    }
}
let poppy = Dog(name: "Poppy", breed: "Poodle")
poppy.makeNoise()

//Podemos herdar da classe dog
//Podemos reescrever metodos das classes maes
class Poodle: Dog {
    init(name: String) {
        //chamando pelo construtor da classe mae
        super.init(name: name, breed: "Poodle")
    }
    //override informa que o metodo esta sendo reescrito
    override func makeNoise() {
        print("Yip!")
    }
}

class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
let bob = Poodle(name: "Bob")
bob.makeNoise()

//A keyword final antes da classe indica que a classe nao pode ser herdada

//Outra grande diferença é que as instancias mudam as variaveis das classes
var singer = Singer()
print(singer.name) //Taylor swift
var singerCopy = singer
singerCopy.name = "Justin Bieber"
print(singer.name) //Justin bieber
//Ou seja, a variavel da classe foi mudada
//Instancias constantes podem ter propiedades mudadas
//Chamado de mutacao
let swift = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name) //Ed Sheeran