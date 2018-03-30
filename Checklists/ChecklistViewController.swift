//
//  ViewController.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {

    let dataProvider = ChecklistDataProvider()
    var items: [ChecklistItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true

        loadItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemDetailScreen = segue.destination as! ItemDetailViewController
        itemDetailScreen.delegate = self
        
        if segue.identifier == "goToAddItem" {
            itemDetailScreen.dataProvider = dataProvider
        } else if segue.identifier == "goToEditItem" {
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                itemDetailScreen.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    /* ItemDetail delegate */
    func newItemAdded() {
        loadItems()
        
        let indexPath = IndexPath(row: items.count-1, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismissItemDetailScreen()
        saveChecklistItems()
    }
    
    func itemEdited() {
        loadItems()
        tableView.reloadData()
        
        dismissItemDetailScreen()
        saveChecklistItems()
    }
    
    func actionCancelled() {
        dismissItemDetailScreen()
    }

    /* Data Source section */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    /* Delegate section */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: item)
            saveChecklistItems()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataProvider.removeItem(index: indexPath.row)
        loadItems()

        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveChecklistItems()
    }

    /* class methods */
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        
        label.text = item.checked ? "√" : ""
    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func loadItems() {
        items = dataProvider.getItems()
    }
    
    func dismissItemDetailScreen() -> UIViewController? {
        return navigationController?.popViewController(animated: true)
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklistItems() {
        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array!")
        }
    }
}

