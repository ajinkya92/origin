//
//  ViewController.swift
//  Persist Data Techniques Todoey
//
//  Created by Ajinkya Sonar on 06/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var items = ["Go to Udemy", "Add Course to Cart", "Buy The Course"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }
        else {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    
}

