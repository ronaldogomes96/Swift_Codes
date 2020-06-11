import Foundation

var url = URL(string: "https://myapi.com")

//Adicionando um caminho a url
url = url?.appendingPathComponent("users")

//Criando a instancia de URLComponents
var components = URLComponents()

//Adicionando o parametro scheme e host
components.scheme = "https"
components.host = "myapi.com"

//Mostra "https://myapi.com"
components.url

//Podemos adicionar outros elementos a instancia
let queryItemTokien = URLQueryItem(name: "token", value: "12345")
let queryItemQuery = URLQueryItem(name: "query", value: "swift ios")

components.queryItems = [queryItemQuery, queryItemTokien]

//Com isso foram adicionados novos parametros a url
//A nova url ficou https://myapi.com?query=swift%20ios&token=12345
components.url

//A URLComponentes tambem suporta outros tipos de acoes
components.fragment = "five"
components.user = "bartjacobs"
components.password = "mypassword"

//Agora a url ficara https://bartjacobs:mypassword@myapi.com?query=swift%20ios&token=12345#five
components.url

//Voce tambem pode criar uma url componentes diretamente de uma string
let component = URLComponents(string: "https://cocoacasts.com")
