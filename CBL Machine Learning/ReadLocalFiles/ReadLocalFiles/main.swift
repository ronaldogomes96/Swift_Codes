//
//  main.swift
//  ReadLocalFiles
//
//  Created by Ronaldo Gomes on 19/06/21.
//

import Foundation

let file = File()
let csv = file.readCSV(fileName: "Iris")

print(csv[1][0..<csv[0].count - 1])
