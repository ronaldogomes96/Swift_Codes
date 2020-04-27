//CLOSURES
//Closures dentro da funcao tambem pode receber parametros
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London") //London é passado como parametro da closure
    print("I arrived!")
}
//Usando a trailing closure sintax
travel { (place: String) in
    print("I'm going to \(place) in my car")
}

//A closure tambem pode retornar outros tipos alem de void
func viajar(action: (String) -> String) {
    print("I'm getting ready to go.")
    print( action("London") )
    print("I arrived!")
}
viajar { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

//Existe formas de diminuir esse codigo
//Pois o swift sabe que a variavel e o retorno sao strings
//Alem disso, os nomes da variaveis das closures podem ser ocultada
viajar {
    "I'm going to \($0) in my car"
    // Usando $0
}

//Exemplo com 2 parametros na closure
func viajarVelocidade(action: (String, Int) -> String) {
    print("I'm getting ready to go.")    
    print( action("London", 60) )
    print("I arrived!")
}
viajarVelocidade {
    "I'm going to \($0) at \($1) miles per hour."
}

//No caminho inverso, podemos retornar uma closure de uma função
func travel() -> (String) -> Void {
    //Primeiro indica o tipo de retorno da funcao
    //Depois indica o tipo de retorno da closure
    return {
        print("I'm going to \($0)")
    }
}
let result = travel()
result("London")

//Valores que sao usados dentro da closure sao mantidos