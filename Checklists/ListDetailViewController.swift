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

class ListDetailViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ListDetailViewControllerDelegate?
    var checklistToEdit: Checklist?
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.actionCancelled()
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
}
