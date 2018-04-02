//
//  ViewController.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {

    let dataProvider = ChecklistItemDataProvider()
    var items: [ChecklistItem] = []
    var checklist: Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = checklist?.name
        navigationItem.largeTitleDisplayMode = .never

        loadItems()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemDetailScreen = segue.destination as! ItemDetailViewController
        itemDetailScreen.delegate = self
        itemDetailScreen.dataProvider = dataProvider
        
        if segue.identifier == "goToEditItem" {
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                itemDetailScreen.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    // MARK: - ItemDetail delegate
    func newItemAdded() {
        loadItems()
        
        let indexPath = IndexPath(row: items.count-1, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismissItemDetailScreen()
    }
    
    func itemEdited() {
        loadItems()
        tableView.reloadData()
        
        dismissItemDetailScreen()
    }
    
    func actionCancelled() {
        dismissItemDetailScreen()
    }

    // MARK: - Data Source section
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
    
    // MARK: - Delegate section
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            item.toggleChecked()
            dataProvider.editItem(item: item)
            
            configureCheckmark(for: cell, with: item)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataProvider.removeItem(index: indexPath.row)
        loadItems()

        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    // MARK: - class methods
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
}

