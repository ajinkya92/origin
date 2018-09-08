//
//  FirstViewController.swift
//  Persist Data Techniques Todoey
//
//  Created by Ajinkya Sonar on 06/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var itemText = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            
            newItem.title = itemText.text
            newItem.isDone = false
            
            self.items.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create New Item"
            
            itemText = alertTextField
            
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
   
    
}

// MARK: Core Data Functionality

extension FirstViewController {
    
    func saveItems() {
        
        do{
            
            try context.save()
            
        }
        catch{
            
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems() {
        
        do{
            
            items = try context.fetch(Item.fetchRequest())
        }
        catch{
            
            print(error.localizedDescription)
        }
        
        tableView.reloadData()
        
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
        
        cell.accessoryType = item.isDone ? .checkmark : .none  // One line Syntax for above lines
        
        
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
        
       // items[indexPath.row].setValue("Completed", forKey: "title")
        
       // items[indexPath.row].isDone = !items[indexPath.row].isDone // Single Line Replacement
        
        context.delete(items[indexPath.row])
        items.remove(at: indexPath.row)
    
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    
    
}


