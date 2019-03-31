//
//  CoreDataService.swift
//  mod14
//
//  Created by Solo Trant on 19/03/2019.
//  Copyright © 2019 Solo Trant. All rights reserved.
//

import Foundation
import CoreData


class CoreDataService {
    
    private init() {}
    
    static let context = persistentContainer.viewContext

    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "mod14")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func save(strTask: String) {
        let task = Task(context: CoreDataService.context)
        task.task = strTask
        
        saveContext()
    }
    
    static func getTasks() -> [Task] {
        var tasks: [Task] = []
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            tasks = result
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return tasks
    }
    
    static func remove(task: Task) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            for item in result {
                if item.task == task.task {
                    context.delete(item)
                }
            }
            saveContext()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
