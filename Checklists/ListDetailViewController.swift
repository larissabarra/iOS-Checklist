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
    
    weak var delegate: ListDetailViewControllerDelegate?
    var checklistToEdit: Checklist?
}
