
import Foundation

/*
    Codable é na verdade um type alyas que combina dois protocolos - codificável e decodificável - em um. Ao estar em conformidade com um desses
    protocolos ao declarar um tipo, o compilador tentará sintetizar automaticamente o código necessário para codificar ou decodificar uma instância
    desse tipo, que funcionará desde que apenas as propriedades armazenadas sejam codificadas / decodificável
 */

struct User: Codable{
    var name: String
    var age: Int
}

//Ao adicionar apenas essa conformidade de protocolo,podemos codificar uma instância de usuário em JSON Data usando um JSONEncoder:

do{
    let user = User(name: "Ronaldo", age: 23)
    let encoder = JSONEncoder()
    let data = try encoder.encode(user)
} catch{
    
    //Temos que adicionar a clausula de erro pois ele pode ocorrer
    print("Um erro aconteceu em \(error)")
}

//Agora podemos decodar o objeto
let decoder = JSONDecoder()
let secondUser = try decoder.decode(User.self, from: data)

//Podemos tambem adequar a struct de acordo com o json para funcionar o protocolo codable, usando struct dentro de structss 
