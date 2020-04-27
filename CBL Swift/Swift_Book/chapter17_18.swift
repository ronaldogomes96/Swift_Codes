import Foundation

//Protocolos são contratos que classes, structs e enums podem assinar
//Quando aceitam esse protocolo,tem que realizar os metodos que foram propostos
//Protocolos podem ser herdados de outros protocolos

protocol meuProtocolo {
    init(valor: Int) //Instancia um inicializador para quem assinar o protocolo
    func doSometing() -> Bool //Instancia um metodo
    var mensagem: String {get} //Instancia uma propiedade somente de leitura
    var value: Int {get set} //Instancia uma propiedade de leitura e escrita
    static func instrucoes() -> String //Instancia um metodo estatico
}
//Quem assina esse protocolo é obrigado a instanciar tudo dele
//get: Somente le e faz algum calculo com a variavel, nao podendo mudar a mesma
//Set: Pode mudar o valor da variavel

//Podemos instanciar esse protocolo em uma class
class exemplo : meuProtocolo{
    //Logo apos é necessario instanciar todos os metodos e propiedades
    required init(valor: Int) {
        self.mensagem = "Faça seu trabalho"
        self.value = valor
    }
    
    func doSometing() -> Bool {
        print("\(mensagem) funcionario de numero \(value)")
        return true
    }
    
    var mensagem: String
    
    var value: Int
    
    //Podemso criar outros metodos e propiedades que nao sejam do protocolo
    static var x: Int = 0
    
    //static pode ser interpretado como de classes e nao de instancias
    static func instrucoes() -> String {
        x+=1
        return "Funcionario \(x)"
    }
    
}

var ex1 = exemplo(valor: 10)
print(exemplo.instrucoes())
ex1.doSometing()
var ex2 = exemplo(valor: 20)
print(exemplo.instrucoes())
ex2.doSometing()

//Funções podem ter nos parametros dois nomes, o primeiro para ser usado fora da funções e outro para ser usados dentro dela
func magicNumber(one number1: Int, two number2: Int){
    print("\(number1) e \(number2) são os numeros magicos!!!")
}
//Dessa forma usamos os primeiros nomes para a referencia
magicNumber(one: 10, two: 20)

//Uma função pode ser passada em outra
func jediTrainer () -> ((String, Int) -> String) {
    func train(name: String, times: Int) -> (String) {
        return "\(name) has been trained in the Force \(times) times"
    }
    
    return train
}
//Ele instancia a função e entao chama a que esta dentro dela
let treino = jediTrainer()
treino("Obi Wan", 3)

//Inouts parametros são formas de mudancas dentro da funcao fazerem efeito fora dela
func updateNumero( numero: inout Int) {
    numero += 1
}
var num1 = 1
print(num1) //1
//A cada vez que a funcao é chamada ela altera o valor da variavel global
updateNumero(numero: &num1)
print(num1) //2

