//
//  FileManager.swift
//  ReadLocalFiles
//
//  Created by Ronaldo Gomes on 19/06/21.
//

import Foundation

class File {
    
    func readCSV(fileName: String) -> [[Any]] {
        guard let file = Bundle.main.path(forResource: fileName, ofType: "csv") else {
          fatalError("Resource could not be found!")
        }
        
        guard let content = try? String(contentsOfFile: file) else {
            fatalError("File could not be read!")
        }
        
        let rows = content.split(separator: "\n").map { String($0) }
        
        let data = rows.map { row -> [Any] in
            let split = row.split(separator: ",")
            return split as [Any]
        }
        
        return data
    }
}
