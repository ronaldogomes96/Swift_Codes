import UIKit
import Foundation

//Obtemos a referencia do arquivo json
let url = Bundle.main.url(forResource: "data", withExtension: "json")
//Obtendo o conteudo de dados brutos
let data = NSData(contentsOf: url!)

func readJSONObject(object: [String: AnyObject]) {
    guard let title = object["dataTitle"] as? String,
        let version = object["swiftVersion"] as? Float,
        let users = object["users"] as? [[String: AnyObject]]re else { return }
    _ = "Swift \(version) " + title
     
    for user in users {
        guard let name = user["name"] as? String,
            let age = user["age"] as? Int else { break }
        switch age {
        case 22:
            _ = name + " is \(age) years old."
        case 25:
            _ = name + " is \(age) years old."
        case 29:
            _ = name + " is \(age) years old."
        default:
            break
        }
    }
}

do {
    let object = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments)
    if let dictionary = object as? [String: AnyObject] {
        readJSONObject(object: dictionary)
    }
} catch{
    fatalError()
}

