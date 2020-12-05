//
//  ViewController.swift
//  LetrandoPersistenceTests
//
//  Created by Ronaldo Gomes on 04/12/20.
//

import UIKit

class WordsController: UITableViewController {
    
    var reports = [Report]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        loadReports()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReports()
        tableView.reloadData()
    }
    
    func loadReports() {
        reports = Report.readReports() ?? []
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "\(reports[indexPath.row].word!) - Data: \((reports[indexPath.row].data?.description(with: .current))!)"
        //cell.detailTextLabel?.text = DateFormatter().string(for: reports[indexPath.row].data)
        return cell
    }

}

