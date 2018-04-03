
//
//  ChecklistItemDataProvider.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation

class ChecklistItemDataProvider {
    
    var listProvider: ChecklistDataProvider
    
    var checklist: Checklist
    
    init(provider: ChecklistDataProvider, list: Checklist) {
        self.checklist = list
        self.listProvider = provider
    }
    
    func refreshList() -> Checklist {
        return checklist
    }
    
    func addItem(item: ChecklistItem) {
        checklist.items.append(item)
        persist()
    }
    
    func editItem(item: ChecklistItem) {
        if let index = checklist.items.index(of: item) {
            checklist.items[index] = item
            persist()
        }
    }
    
    func removeItem(index: Int) {
        checklist.items.remove(at: index)
        persist()
    }
    
    func persist() {
        listProvider.editList(list: checklist)
    }
}
