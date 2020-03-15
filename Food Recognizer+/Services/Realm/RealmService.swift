//
//  RealmService.swift
//  Food Recognizer+
//
//  Created by Денис Жукоборский on 15.03.2020.
//  Copyright © 2020 Денис Жукоборский. All rights reserved.
//

import UIKit
import RealmSwift

class RealmService {
    
    static func addToDB(objects: [Object]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            NSLog("Error in adding objects to Realm")
        }
    }
    
    
}


extension RealmService: RealmRecipesRecordsCleaner {
    static func cleanOldRecipesRecords() {
        DispatchQueue(label: "background").async {
            autoreleasepool{
                do {
                    let realm = try Realm()
                    let recipes = realm.objects(RecipeRealm.self).sorted(byKeyPath: "dateOfAdding")
                    guard recipes.count >= 10 else { return }
                    
                    try realm.write {
                        realm.delete(recipes[10...(recipes.count - 1)])
                    }
                } catch {
                    DispatchQueue.main.async {
                        NSLog("Error in cleaning old recipe records")
                    }
                }
            }
        }
    }
}
