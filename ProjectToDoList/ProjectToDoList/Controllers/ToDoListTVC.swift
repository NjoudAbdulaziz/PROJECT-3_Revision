//
//  ToDoListTVC.swift
//  ProjectToDoList
//
//  Created by Njoud Alrshidi on 23/04/1443 AH.
//

import UIKit

class ToDoListTVC: ViewController {

    var listArr : [Task] = []
    var selectedIndex = 0
    
    @IBOutlet weak var ToDoTableView: UITableView!
    let userDefaluts = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoTableView.delegate = self
        ToDoTableView.dataSource = self
        listArr = createArray()
        if let setItems = userDefaluts.object(forKey: "listArr") as? [Task] {
            self.listArr = setItems
        }
    }
    
    
    func createArray() -> [Task]{
        var typeOFTheTask :[Task] = []
        
        let task1 = Task(taskName: "To Do", taskPhoto: UIImage(resource: .Image1)!)
        let task2 = Task(taskName: "Shopping List", taskPhoto: UIImage(resource: .Image2)!)
        let task3 = Task(taskName: "Work List", taskPhoto: UIImage(resource: .Image3)!)
        
        typeOFTheTask.append(task1)
        typeOFTheTask.append(task2)
        typeOFTheTask.append(task3)
        
        return typeOFTheTask
    }
    
    @IBAction func editng(_ sender: UIBarButtonItem) {
        if ToDoTableView.isEditing {
            ToDoTableView.isEditing = false
        }
        else {
            ToDoTableView.isEditing = true
        }
    }
    

    
}

extension ToDoListTVC : UITableViewDelegate , UITableViewDataSource {
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArr.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as! ToDoCell
         let data = listArr[indexPath.row]
         cell.setUpCell(taskName: data.taskName, taskPhoto: data.taskPhoto)
        
        return cell
    }
     func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            listArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
        }
        
        
    }
     func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
        if sourceIndexPath == destinationIndexPath {
            return
        } else {
            let movedItem = listArr[sourceIndexPath.row]
            listArr.remove(at: sourceIndexPath.row)
            listArr.insert(movedItem, at: destinationIndexPath.row)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "identifierToDo", sender: nil)
       }
  

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "identifierToDo"{
            guard let vc = segue.destination as? NewTaskVC else {return}
            vc.typeOfTask = listArr[selectedIndex]
        }
    
    }
    
}

    


