//
//  LocationTableTableViewController.swift
//  OnTheMap
//
//  Created by Austin Tooley on 6/24/17.
//  Copyright © 2017 Austin Tooley. All rights reserved.
//

import UIKit
import SafariServices

class LocationTableTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup tableview
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // Number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentDataSource.sharedInstance.studentData.count
    }
    
    // Create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // Set cell content
        if let firstName = StudentDataSource.sharedInstance.studentData[indexPath.row].firstName, let lastName = StudentDataSource.sharedInstance.studentData[indexPath.row].lastName {
            cell.textLabel?.text = "\(firstName) \(lastName)"
        }
        
        return cell
    }
    
    // Cell was tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlString = StudentDataSource.sharedInstance.studentData[indexPath.row].mediaURL {
            // Handel missing http
            var formattedURL = urlString
            if (!(urlString.contains("http"))) {
                formattedURL = "http://\(urlString)"
            }
            
            if let url = URL(string: (formattedURL)) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }

}
