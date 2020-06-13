import UIKit
import Foundation

// Camada de Router
    
enum Router {
    
    //Representem o terminal de solicitações que você deseja enviar para a API
    case getSources
    case getProductIds
    case getProductsInfo
    
    //Cria uma variavel scheme que é o mesmo para qualquer variavel
    var scheme: String {
        switch self {
        case .getSources, .getProductIds, .getProductsInfo:
            return "https"
        }
    }
    
    //Cria a variavel host que é a mesma para todos
    var host: String {
        switch self {
        case .getSources, .getProductsInfo, .getProductIds:
            return "shopicruit.myshopify.com"
        }
    }
    
    //Cria uma variavel path que retorna path diferentes dependendo do caso
    var path: String {
        switch self {
        case .getSources:
            return "/admin/custom_collections.json"
        case .getProductsInfo:
            return "/admin/products.json"
        case .getProductIds:
            return "/admin/collects.json"
        }
    }
    
    //Crie uma matriz de URLQueryItem para criar os parâmetros, pois todas as rotas têm mais de um parâmetro.
    var parameters: [URLQueryItem] {
        let accessToken = "c32313df0d0ef512ca64d5b336a0d7c6"
        switch self {
        /*
             De volta à imagem dos componentes da URL, existem exatamente 2 parâmetros e cada um é separado
             pelo e comercial "&". Um URLQueryItem representa um parâmetro. Cada instanciação que requer um nome
             , representando o nome do parâmetro à esquerda do sinal de igual e o valor, representando a
             sequência à direita do sinal de igual. Portanto, criamos uma matriz de URLQueryItems para os
             parâmetros em cada rota. E como passamos o token de acesso sempre para o valor, podemos apenas
             criar uma variável que armazena esse valor na linha 34.
        */
        case .getSources:
            return [URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "access_token", value: accessToken)]
        case .getProductIds:
            return [URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "collection_id", value: "68424466488"),
                    URLQueryItem(name: "access_token", value: accessToken)]
        case .getProductsInfo:
            return [URLQueryItem(name: "ids", value: "2759162243,2759143811"),
                    URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "access_token", value: accessToken)]
        }
    }
    
    // Crie uma variável de método que indique qual método estamos usando para solicitar ao servidor
    var method: String {
        switch self {
        case .getSources, .getProductIds, .getProductsInfo:
            return "GET"
        }
    }
    
}


//Camada de serviço

class ServiceLayer {
    /*
        Usamos 'class func' para que possamos chamar a função diretamente na classe sem precisar instancia-la. E
        vamos em frente e adicionamos o genérico.
        • Passamos um parâmetro que será do tipo Roteador.
        • Criamos um manipulador de conclusão de escape para passar os dados decodificados ou um objeto de erro
          para usar em outro lugar, mesmo após o retorno da função.
        • Tipo de resultado para o resgate! (disponível no Swift 5) Declaramos que o primeiro parâmetro é o tipo
          de objeto e o segundo o tipo de erro.
     */
    
    class func request<T : Codable>(router: Router, completion: @escaping (Result<[String: [T]], Error>) -> ()) {
        
        //Configure os componentes do URL da nossa classe Router
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        //Verifique se o URL é válido e crie a solicitação de URL com o método correto
        guard let url = components.url else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        //Inicie a solicitação para o servidor com o urlRequest que criamos acima. Não esqueça o .resume () após a função para iniciar a tarefa, pois as tarefas recém-inicializadas começam em um estado suspenso
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest){ data, response, error in
            
            //Use uma declaração de guard let para garantir que não haja erros ou, então, passe o erro para a conclusão e retorne à função.
            
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription as Any)
                return
            }
            
            guard response != nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            //Nesta etapa, temos a garantia de que há dados, resposta e nenhum erro. Comece decodificando o objeto json do nosso modelo, que será definido posteriormente quando chamarmos a função
            
            let responseObject = try! JSONDecoder().decode([String: [T]].self, from: data)
            
            //Despache de volta para o encadeamento principal antes de chamar o manipulador de conclusão, pois a rede ocorre no encadeamento em segundo plano. Ou, você pode optar por enviar de volta para o encadeamento principal ao usar o objeto de resposta ao chamar a função.
            DispatchQueue.main.async {
                //Passe o objeto decodificado no manipulador de conclusão para usá-lo em outro lugar, mesmo quando a função retornar. Os manipuladores de conclusão são usados ​​principalmente para acionar uma ação do objeto dentro da função.
                completion(.success(responseObject))
            }
            
        }
        dataTask.resume()
    }
    
}

//Camada de modelo

struct CollectionItem: Codable {
    let title: String
    let id: Int
}
struct CollectionItemId: Codable {
    let productId: Int
  
    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
    }
}
struct CollectionInfo: Codable {
    let title: String
    let productType: String
    let variants: [VariantsInfo]
    let image: ImageInfo
    
    enum CodingKeys: String, CodingKey {
        case title
        case productType = "product_type"
        case variants
        case image
    }
}

struct VariantsInfo: Codable {
    let title: String
    let inventoryQuantity: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case inventoryQuantity = "inventory_quantity"
    }
}

struct ImageInfo: Codable {
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case path = "src"
    }
}

/*
    Agora podemos chamar nossa solicitação de rede, pois temos modelos para decodificar. Você deve ter
    adivinhado, esses modelos serão o 'T' quando declararmos nossos genéricos. Então, vamos dar uma olhada em como
    realmente dizemos à camada de serviço o que é o 'T'
 */

ServiceLayer.request(router: Router.getProductsInfo) { (result: Result<[String : [CollectionItem]], Error>) in
    switch result {
    case .success:
        print(result)
    case .failure:
        print(result)
    }
}

/*
    Passamos no caso do roteador, que manipulará a construção da rota e especificaremos o tipo de resultado no
    manipulador de conclusão. Depois que essa função é acionada, a função de solicitação sabe qual rota construir
    e qual modelo decodificar. E depois que recebermos o objeto Result, ele será um caso de sucesso ou falha, que
    você manipulará o que fazer nos dois casos.
 */
