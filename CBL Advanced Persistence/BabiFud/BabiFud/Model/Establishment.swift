
import UIKit
import MapKit
import CloudKit
import CoreLocation

class Establishment {
  enum ChangingTable: Int {
    case none
    case womens
    case mens
    case both
  }
  
  static let recordType = "Establishment"
  private let id: CKRecord.ID
  let name: String
  let location: CLLocation
  let coverPhoto: CKAsset?
  let database: CKDatabase
  let changingTable: ChangingTable
  let kidsMenu: Bool
  let healthyOption: Bool
  private(set) var notes: [Note]? = nil
  
  init?(record: CKRecord, database: CKDatabase) {
    guard
      let name = record["name"] as? String,
      let location = record["location"] as? CLLocation
      else { return nil }
    id = record.recordID
    self.name = name
    self.location = location
    coverPhoto = record["coverPhoto"] as? CKAsset
    self.database = database
    healthyOption = record["healthyOption"] as? Bool ?? false
    kidsMenu = record["kidsMenu"] as? Bool ?? false
    if let changingTableValue = record["changingTable"] as? Int,
      let changingTable = ChangingTable(rawValue: changingTableValue) {
      self.changingTable = changingTable
    } else {
      self.changingTable = .none
    }
  }
  
  func loadCoverPhoto(completion: @escaping (_ photo: UIImage?) -> ()) {
    /*
     Embora você baixe o ativo ao mesmo tempo em que recupera o restante do registro, deseja carregar a imagem de forma assíncrona. Portanto, envolva tudo em um bloco DispatchQueue.async.
     */
    DispatchQueue.global(qos: .utility).async {
      var image: UIImage?
      
      /*
       Execute o retorno de chamada de conclusão com a imagem recuperada. Observe que o bloco defer é executado independentemente de qual retorno é executado. Por exemplo, se não houver nenhum ativo de imagem, a imagem nunca será definida na devolução e nenhuma imagem aparecerá para o restaurante.
       */
      defer {
        DispatchQueue.main.async {
          completion(image)
        }
      }
      
      /*
       Verifique se a foto da capa do ativo existe e tem um URL de arquivo.
       */
      guard let coverPhoto = self.coverPhoto, let fileURL = coverPhoto.fileURL else {
        return
      }
      let imageData: Data
      
      do {
        
        /*
         Baixe os dados binários da imagem.
         */
        imageData = try Data(contentsOf: fileURL)
      } catch {
        return
      }
      /*
        Transforma em UIImage
       */
      image = UIImage(data: imageData)
    }
  }
}

extension Establishment: Hashable {
  static func == (lhs: Establishment, rhs: Establishment) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
