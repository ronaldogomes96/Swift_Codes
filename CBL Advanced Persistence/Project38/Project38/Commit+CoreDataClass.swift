//
//  Commit+CoreDataClass.swift
//  Project38
//
//  Created by Ronaldo Gomes on 19/10/20.
//
//

import Foundation
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        print("Init called!")
    }
}
