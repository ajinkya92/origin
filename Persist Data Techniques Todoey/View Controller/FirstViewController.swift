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
    
    let defaults = UserDefaults.standard
    
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Getting item from User Defaults
        
                if let item = defaults.array(forKey: "TodoListArray") as? [Item] {
        
                    items = item
                }
        
        
        let newItem1 = Item()
        newItem1.title = "Hello Kitty"
        newItem1.isChecked = false
        items.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Hello Kitty1"
        newItem2.isChecked = true
        items.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Hello Kitty2"
        newItem3.isChecked = false
        items.append(newItem3)
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var itemText = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item()
            
            newItem.title = itemText.text!
            
            self.items.append(newItem)
            self.defaults.set(self.items, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
            
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
        
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.title
        
//        if items[indexPath.row].isChecked == true {
//            cell.accessoryType = .checkmark
//        }
//        else {
//
//            cell.accessoryType = .none
//        }
        
        cell.accessoryType = item.isChecked ? .checkmark : .none  // One line Syntax for above lines
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        //
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //
        //        }
        //        else {
        //
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //        }

        
        items[indexPath.row].isChecked = !items[indexPath.row].isChecked // Single Line Replacement
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    
}

