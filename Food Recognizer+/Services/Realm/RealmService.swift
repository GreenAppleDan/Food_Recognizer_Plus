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
    
    static func deleteAllRecordsFromDBWithPredicate<T:Object>(of type: T.Type, _ predicate: NSPredicate){
        do {
            let realm = try Realm()
            try realm.write {
                let objects = realm.objects(type).filter(predicate)
                realm.delete(objects)
            }
        } catch {
            NSLog("Error in deleting objects from Realm")
        }
    }
    
    static func getAllRecordsFromDB<T:Object>(of type: T.Type) -> [T]? {
        do{
            let realm = try Realm()
            let objects = realm.objects(T.self)
            return objects.map { $0 }
        } catch {
            return nil
        }
    }
    
    
}


extension RealmService: RealmRecipesRecordsCleaner {
    static func cleanOldRecipesRecords() {
        DispatchQueue(label: "background").async {
            autoreleasepool{
                do {
                    let realm = try Realm()
                    let recipes = realm.objects(RecipeRealm.self).sorted(byKeyPath: "dateOfAdding", ascending: false)
                    guard recipes.count > 20 else { return }
                    
                    try realm.write {
                        for i in (20..<recipes.count).reversed() {
                        realm.delete(recipes[i])
                        }
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
