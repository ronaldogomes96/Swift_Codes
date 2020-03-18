//CLOSURES
//Sao formas de usar uma funcao como um tipo qualquer
//Podendo usar como variavel e passar a mesma como parametro
let dirigir = {
    print("Eu estou dirigindo meu carro")
}
dirigir()

//Podemos passar parametros para as closures
let driving = { (place: String) in
    print("I'm going to \(place) in my car")
    //Precisamos colocar o in apos os parametros
}
driving("London") // Nesse caso tambem nao é necessario o nome da variavel
//Alem disso, podemos retornar valores
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
    //Precisamos especificar o tipo do retorno
}
let message = drivingWithReturn("London")
print(message)

//Podemos passar closures como parametros para funçõoes
//Precisamos especificar que é uma funcao e que é void como retorno
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}
travel(action: dirigir)

//Trailling closure sintax
//Funciona quando o ultimo parametro de uma funcao é uma closure
//Passa a closure diretamente na chamada da funcao
travel{
    print("I'm driving in my car")
}