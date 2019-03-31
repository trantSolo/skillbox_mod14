//
//  TODOCoreDataVC.swift
//  mod14
//
//  Created by Solo Trant on 19/03/2019.
//  Copyright © 2019 Solo Trant. All rights reserved.
//

import UIKit

class TODOCoreDataVC: UIViewController {
    
    var dataSource: [Task] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = CoreDataService.getTasks()
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add", message: "", preferredStyle: .alert)
        
        var textField: UITextField!
        alert.addTextField { tf in
            textField = tf
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            guard let text = textField.text, !text.isEmpty else { return }
            
            let task = Task(context: CoreDataService.context)
            task.task = text
            CoreDataService.saveContext()
            
            self.dataSource.append(task)
            self.tableView.insertRows(at: [IndexPath.init(row: self.dataSource.count - 1, section: 0)], with: .automatic)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension TODOCoreDataVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row].task
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            
            CoreDataService.remove(task: self.dataSource[indexPath.row])
            self.dataSource.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}