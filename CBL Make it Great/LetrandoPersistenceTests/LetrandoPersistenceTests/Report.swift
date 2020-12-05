//
//  Report.swift
//  LetrandoPersistenceTests
//
//  Created by Ronaldo Gomes on 04/12/20.
//

import Foundation
import CoreData

class Report: NSManagedObject {
    
    static func createReport(word: String) {
        let report = Report(context: AppDelegate.viewContext)
        report.word = word
        report.data = NSDate.now
        do {
            try AppDelegate.viewContext.save()
        } catch {
            fatalError()
        }
    }
    
    static func readReports() -> [Report]? {
        let request: NSFetchRequest<Report> = Report.fetchRequest()
        guard let report = try? AppDelegate.viewContext.fetch(request) else {
            return nil
        }
        return report
    }
}
