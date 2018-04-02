//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 02/04/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation
import UIKit

protocol IconPickerViewControllerDelegate: class {
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String)
}

class IconPickerViewController: UITableViewController {
    
    let icons = [ "No Icon",
                  "Appointments",
                  "Birthdays",
                  "Chores",
                  "Drinks",
                  "Folder",
                  "Groceries",
                  "Inbox",
                  "Photos",
                  "Trips" ]
    
    weak var delegate: IconPickerViewControllerDelegate?
    
    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell", for: indexPath)
        let iconName = icons[indexPath.row]
    
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            let iconName = icons[indexPath.row]
            delegate.iconPicker(self, didPick: iconName)
        }
    }
}
