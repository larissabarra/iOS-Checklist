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
    
    init(name: String) {
        self.name = name
        self.items = []
        super.init()
    }
    
    func countUncheckedItems() -> Int {
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
}
