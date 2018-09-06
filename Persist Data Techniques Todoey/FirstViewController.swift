//
//  FirstViewController.swift
//  Persist Data Techniques Todoey
//
//  Created by Ajinkya Sonar on 06/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = ["Go to Udemy", "Add Course to Cart", "Buy The Course"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var itemText = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let userEnteredText = itemText.text {
                
                self.items.append(userEnteredText)
                
                self.tableView.reloadData()
                
            }
            
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Item"
            
            itemText = alertTextField
            
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    

    
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
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

