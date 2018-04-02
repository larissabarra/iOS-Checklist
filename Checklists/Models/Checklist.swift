//
//  Checklist.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 31/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation

class Checklist: NSObject, Codable {
    var name: String
    var items: [ChecklistItem]
    var iconName: String
    
    init(name: String) {
        self.name = name
        self.items = []
        self.iconName = "No Icon"
        super.init()
    }
    
    func countUncheckedItems() -> Int {
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
}
