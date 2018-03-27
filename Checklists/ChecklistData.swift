
//
//  ChecklistData.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation

class ChecklistDataProvider {
    
    func getItems() -> [ChecklistItem] {
        return [ChecklistItem(text: "Walk the dog", checked: false),
                ChecklistItem(text: "Brush my teeth", checked: true),
                ChecklistItem(text: "Learn iOS development", checked: true),
                ChecklistItem(text: "Soccer practice", checked: false),
                ChecklistItem(text: "Eat ice cream", checked: false)]
    }
}
