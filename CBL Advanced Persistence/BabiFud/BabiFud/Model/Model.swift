
import Foundation
import CloudKit

class Model {
  // MARK: - iCloud Info
  let container: CKContainer
  let publicDB: CKDatabase
  let privateDB: CKDatabase
  
  // MARK: - Properties
  private(set) var establishments: [Establishment] = []
  static var currentModel = Model()
  
  init() {
    container = CKContainer.default()
    publicDB = container.publicCloudDatabase
    privateDB = container.privateCloudDatabase
  }
  
  @objc func refresh(_ completion: @escaping (Error?) -> Void) {
    
    /*
     Você cria um predicado com o valor true. O NSPredicate determina como você busca ou filtra os dados; neste caso, você está especificando que apenas um valor deve existir.
     */
    let predicate = NSPredicate(value: true)
    
    /*
     Você adiciona uma query para especificar o tipo de registro que deseja e um predicado
     */
    let query = CKQuery(recordType: "Establishment", predicate: predicate)
    establishments(forQuery: query, completion)
  }
  
  private func establishments(forQuery query: CKQuery, _ completion: @escaping (Error?) -> Void) {
    publicDB.perform(query,
          inZoneWith: CKRecordZone.default().zoneID) { [weak self] results, error in
        guard let self = self else { return }
        if let error = error {
          DispatchQueue.main.async {
            completion(error)
          }
          return
        }
        guard let results = results else { return }
        self.establishments = results.compactMap {
          Establishment(record: $0, database: self.publicDB)
        }
        DispatchQueue.main.async {
          completion(nil)
        }
      }
  }
}
