
//Função que retorna algo, nesse caso string
func greet (name: String, surname: String) -> String{
    return "Seja bem vindo \(name) \(surname)"
}
let name = "Ronaldo"
let sobrenome = "Gomes"
var greetings = greet(name: name, surname: sobrenome)
print(greetings)

var pi = 3.14
class circulo {
    var raio = 0.0
    var circunferencia: Double{
        get {
            //Get é executado quando a variavel é chamada
            return raio * pi * 2
        }
        set {
            //Set é executada quando a variavel é mudada
            //newValue é o valor da variavel que foi mudada
            raio = newValue / pi
        }
    }
}

let circle = circulo()
print(circle.raio)
circle.raio = 3
print(circle.raio) 
print(circle.circunferencia) //Get
print(circle.raio) //Nao muda
circle.circunferencia = 20 //Set
print(circle.raio) //Muda