//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 28/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
