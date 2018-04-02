//
//  AllListsTableViewController.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 30/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import UIKit

class AllListsTableViewController: UITableViewController, ListDetailViewControllerDelegate {
    
    var lists: [Checklist] = []
    var dataProvider = ChecklistDataProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        refreshData()
    }

    // MARK: - data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView)
        cell.textLabel!.text = lists[indexPath.row].name
        cell.accessoryType = .detailDisclosureButton
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
        
        let indexPath = IndexPath(row: lists.count-1, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
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
    
    //MARK: - class methods
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "listCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
    }
    
    func dismissListDetailScreen() -> UIViewController? {
        return navigationController?.popViewController(animated: true)
    }
    
    func refreshData() {
        lists = dataProvider.getLists()
    }
}
