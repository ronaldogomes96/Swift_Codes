//
//  Whistle.swift
//  Project33
//
//  Created by Ronaldo Gomes on 16/10/20.
//

import Foundation
import CloudKit

//Classe modelo do Whistle
class Whistle: NSObject {
    var recordID: CKRecord.ID!
    var genre: String!
    var comments: String!
    var audio: URL!
}
