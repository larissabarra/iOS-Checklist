//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    
    init(text: String, checked: Bool, dueDate: Date, shouldRemind: Bool) {
        self.text = text
        self.checked = checked
        self.itemID = ChecklistDataPersistence.nextChecklistItemID()
        
        super.init()
    }
    
    func toggleChecked() {
        self.checked = !self.checked
    }
}
