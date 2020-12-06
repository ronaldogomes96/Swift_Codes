//
//  Report.swift
//  LetrandoPersistenceTests
//
//  Created by Ronaldo Gomes on 04/12/20.
//

import Foundation
import CoreData

class Report: NSManagedObject {
    
    @discardableResult
    static func createReport(word: String) -> Bool {
        let report = Report(context: AppDelegate.viewContext)
        report.word = word
        report.data = NSDate.now
        do {
            try AppDelegate.viewContext.save()
            return true
        } catch {
            return false
        }
    }
    
    static func readReports() -> [Report]? {
        let request: NSFetchRequest<Report> = fetchRequest()
        guard let report = try? AppDelegate.viewContext.fetch(request) else {
            return nil
        }
        return report
    }
    
    static func numberOfLearnedWords() -> Int {
        let words = readReports()?.map({ $0.word })
        return Array(Set(words!)).count
        
    }
    
    static func mediaOfWordsInWeek() -> Int {
        return numberOfLearnedWords() / 7
    }
    
    static func getMostSearchWords() -> [String]? {
        guard let words = readReports() else {
            return nil
        }
        let listOfWords = words.map({ $0.word })
        
        let mappedWords = listOfWords.map { ($0, 1) }
        
        var wordsDictionary = Dictionary(mappedWords, uniquingKeysWith: +)
        
        var listOfMostWords = [String]()
        
        for _ in 0..<3 {
            let word =  wordsDictionary.max{ a, b in a.value < b.value}
            listOfMostWords.append((word?.key)!)
            wordsDictionary.removeValue(forKey: (word?.key)!)
        }
        
        return listOfMostWords
    }
    
    static func getWordsADay() -> [Int: Int]? {
        var wordsADay = [1: 0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0]
        let allReports = readReports()
        guard let reports = allReports else {
            return nil
        }
        reports.forEach { (report) in
//            switch getDayWeek(date: report.data!){
//            case 1:
//                wordsADay[1]! += 1
//            case 2:
//                wordsADay[2]! += 1
//            case 3:
//                wordsADay[3]! += 1
//            case 4:
//                wordsADay[4]! += 1
//            case 5:
//                wordsADay[5]! += 1
//            case 6:
//                wordsADay[6]! += 1
//            case 7:
//                wordsADay[7]! += 1
//            default:
//                return
//            }
            wordsADay[getDayWeek(date: report.data!)]! += 1
        }
        return wordsADay
    }
    
    static func getDayWeek(date: Date) -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        return weekDay
    }
}
