import UIKit

//Struct que recebera os valores do json
struct User: Codable{
       var userId: Int
       var id: Int
       var title: String
       var completed: Bool
}


//Primeiro fazemos uma requisicao WEB via API
let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    guard let dataResponse = data , error ==  nil else {
        print(error?.localizedDescription ?? "Response Error")
        return
    }
    
    do{
        let decoder = JSONDecoder()
        let model = try decoder.decode([User].self, from: dataResponse) //Decode JSON Response Data
        print(model)
    } catch let parsingError {
        print("Error", parsingError)
    }
}
task.resume()


