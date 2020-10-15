

import Foundation
import CloudKit

class Note {
  private let id: CKRecord.ID
  private(set) var noteLabel: String?
  let establishmentReference: CKRecord.Reference?

  init(record: CKRecord) {
    id = record.recordID
    noteLabel = record["text"] as? String
    establishmentReference = record["establishment"] as? CKRecord.Reference
  }
  
  static func fetchNotes(_ completion: @escaping (Result<[Note], Error>) -> Void) {
    completion(.success([]))
  }
}

extension Note: Hashable {
  static func == (lhs: Note, rhs: Note) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
