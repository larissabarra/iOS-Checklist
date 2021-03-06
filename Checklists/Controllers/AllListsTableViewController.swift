//
//  AllListsTableViewController.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 30/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import UIKit

class AllListsTableViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    
    var lists: [Checklist] = []
    var dataProvider: ChecklistDataProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.delegate = self
        
        let index = dataProvider!.indexOfSelectedChecklist
        if index >= 0 && index < lists.count {
            let checklist = lists[index]
            performSegue(withIdentifier: "showChecklist", sender: checklist)
        }
    }

    // MARK: - data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView)
        let checklist = lists[indexPath.row]
        
        cell.textLabel!.text = checklist.name
        cell.detailTextLabel!.text = getSubtitle(checklist)
        cell.accessoryType = .detailDisclosureButton
        cell.imageView!.image = UIImage(named: checklist.iconName)
        
        return cell
    }
    
    // MARK: - delegate methods
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    // MARK: - segue methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataProvider!.indexOfSelectedChecklist = indexPath.row
        
        let checklist = lists[indexPath.row]
        performSegue(withIdentifier: "showChecklist", sender: checklist)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChecklist" {
            let checklistView = segue.destination as! ChecklistViewController
            checklistView.checklist = sender as! Checklist
            checklistView.listDataProvider = dataProvider
        } else if segue.identifier == "goToAddList" {
            let listDetailView = segue.destination as! ListDetailViewController
            listDetailView.delegate = self
            listDetailView.dataProvider = dataProvider
        } else if segue.identifier == "goToEditList" {
            let listDetailView = segue.destination as! ListDetailViewController
            listDetailView.delegate = self
            listDetailView.dataProvider = dataProvider
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                listDetailView.checklistToEdit = lists[indexPath.row]
            }
        }
    }
    
    //MARK: - list detail delegate methods
    func newListAdded() {
        refreshData()
        tableView.reloadData()
        
        dismissListDetailScreen()
    }
    
    func actionCancelled() {
        dismissListDetailScreen()
    }
    
    func listEdited() {
        refreshData()
        tableView.reloadData()
        
        dismissListDetailScreen()
    }
    
    //MARK: - navigation controller delegate
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController === self {
            dataProvider!.indexOfSelectedChecklist = -1
        }
    }
    
    //MARK: - class methods
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "listCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
    }
    
    func getSubtitle(_ checklist: Checklist) -> String {
        let count = checklist.countUncheckedItems()
        if checklist.items.count == 0 {
            return "(No items)"
        } else if count == 0 {
            return  "All done!"
        } else {
            return "\(count) Remaining"
        }
    }
    
    func dismissListDetailScreen() -> UIViewController? {
        return navigationController?.popViewController(animated: true)
    }
    
    func refreshData() {
        lists = dataProvider!.getLists()
    }
}
