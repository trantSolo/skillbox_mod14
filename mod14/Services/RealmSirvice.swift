//
//  RealmSirvice.swift
//  mod14
//
//  Created by Solo Trant on 19/03/2019.
//  Copyright © 2019 Solo Trant. All rights reserved.
//

import Foundation
import RealmSwift


class RealmService {
    
    static let shared = RealmService()
    
    private let realm = try! Realm()
    
    func getTasks() -> Results<Todo> {
        return realm.objects(Todo.self)
    }
    
    func save(task: String) {
        let todo = Todo()
        todo.task = task
        
        try! realm.write {
            realm.add(todo)
        }
    }
    
    func remove(todo: Todo) {
        try! realm.write {
            realm.delete(todo)
        }
    }
    
    func getWeather() -> Weather? {
        return realm.objects(Weather.self).first ?? nil
    }
    
    func saveWeather(weather: Weather) {
        try! realm.write {
            realm.add(weather, update: true)
        }
    }
}
