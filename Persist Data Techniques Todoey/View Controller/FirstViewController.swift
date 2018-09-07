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
    
    
    // let defaults = UserDefaults.standard
    
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")  // Save P-List to this path. -> Make the Model Class Encodable
    
    var items = [Item]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Getting item from User Defaults
        
        //                if let item = defaults.array(forKey: "TodoListArray") as? [Item] {
        //
        //                    items = item
        //                }
        
        
        
        print(filePath!)
        
        loadItems()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var itemText = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item()
            
            newItem.title = itemText.text!
            
            self.items.append(newItem)
            
            // To encode items in the P-list
            
            self.saveData()
            
            //   self.defaults.set(self.items, forKey: "TodoListArray")
            
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Item"
            
            itemText = alertTextField
            
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    // This is where the plist functions are carried on
    
    func saveData() {
        
        let encoder = PropertyListEncoder()
        
        do{
            
            let data = try encoder.encode(items)
            
            if let givenPath = filePath {
                
                try data.write(to: givenPath)
            }
            self.tableView.reloadData()
            
        }catch{
            
            print(error.localizedDescription)
        }
        
        
    }
    
    // To load items from Plist - Item Class must confirm to Decodable Protocol
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: filePath!) {
            
            let decoder = PropertyListDecoder()
            
            do{
                
                items = try decoder.decode([Item].self, from: data)
            }
            catch{
                
                print(error.localizedDescription)
            }
        }
        
        
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
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    
}

