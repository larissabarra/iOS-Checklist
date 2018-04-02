
//
//  ChecklistDataProvider.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation

class ChecklistItemDataProvider {
    
    let persistence = ChecklistDataPersistence()
    
    var data: [ChecklistItem] = [ChecklistItem(text: "Walk the dog", checked: false),
                                 ChecklistItem(text: "Brush my teeth", checked: true),
                                 ChecklistItem(text: "Learn iOS development", checked: true),
                                 ChecklistItem(text: "Soccer practice", checked: false),
                                 ChecklistItem(text: "Eat ice cream", checked: false)]
    
    func getItems() -> [ChecklistItem] {
        let loadedItems = persistence.loadChecklistItems()
        if !loadedItems.isEmpty {
            data = loadedItems
        }
        return data
    }
    
    func addItem(text: String, checked: Bool = false) {
        let newItem = ChecklistItem(text: text, checked: checked)
        data.append(newItem)
        persist()
    }
    
    func editItem(item: ChecklistItem) {
        if let index = data.index(of: item) {
            data[index] = item
            persist()
        }
    }
    
    func removeItem(index: Int) {
        data.remove(at: index)
        persist()
    }
    
    func persist() {
        persistence.saveChecklistItems(items: data)
    }
}
