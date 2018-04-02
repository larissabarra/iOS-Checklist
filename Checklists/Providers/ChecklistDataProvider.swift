
//
//  ChecklistDataProvider.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation

class ChecklistDataProvider {
    
    let persistence = ChecklistDataPersistence()
    
    var data: [Checklist] = []
    
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
            UserDefaults.standard.synchronize()
        }
    }
    
    init() {
        registerDefaults()
    }
    
    func getLists() -> [Checklist] {
        data = persistence.loadChecklists()
        return data
    }
    
    func addList(list: Checklist) {
        data.append(list)
        persist()
    }
    
    func editList(list: Checklist) {
        if let index = data.index(of: list) {
            data[index] = list
            persist()
        }
    }
    
    func removeList(index: Int) {
        data.remove(at: index)
        persist()
    }
    
    func persist() {
        persistence.saveChecklists(lists: data)
    }
    
    func registerDefaults() {
        let dictionary = [ "ChecklistIndex": -1 ]
        UserDefaults.standard.register(defaults: dictionary)
    }
}

