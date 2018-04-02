//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 31/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

protocol ListDetailViewControllerDelegate: class {
    func newListAdded()
    func actionCancelled()
    func listEdited()
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ListDetailViewControllerDelegate?
    var dataProvider: ChecklistDataProvider?
    var checklistToEdit: Checklist?
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.actionCancelled()
    }
    
    @IBAction func done(_ sender: Any) {
        if let listName = textField.text {
            if let checklist = checklistToEdit {
                checklist.name = listName
                dataProvider?.editList(list: checklist)
                
                delegate?.listEdited()
            } else {
                dataProvider?.addList(list: Checklist(name: listName))
                
                delegate?.newListAdded()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let checklist = checklistToEdit {
            title = "Edit checklist"
            textField.text = checklist.name
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    /* MARK: - text field delegate */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
}
