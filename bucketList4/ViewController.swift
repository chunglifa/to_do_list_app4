//
//  ViewController.swift
//  bucketList4
//
//  Created by Christopher Chung on 7/15/18.
//  Copyright © 2018 Christopher Chung. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tableData: [Note] = []
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        print("checkButtonPressed")
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to: self.tableView)
        let selectedIndex = self.tableView.indexPathForRow(at: buttonPosition)
        print("INDEX PATH", selectedIndex?.row)
        let urgent_task = tableData[(selectedIndex?.row)!]
        if urgent_task.urgent == true {
            urgent_task.urgent = false
            appDelegate.saveContext()
            tableView.reloadData()
        } else {
            urgent_task.urgent = true
            appDelegate.saveContext()
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        fetchAllNotes()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // LANDING STRIP ✈️🛩🛬*****************************
    // LANDING FIELD FOR AddVC
    @IBAction func unwindFromAddVC (segue: UIStoryboardSegue){
        print("unwindFromAddVC Function")
        let src = segue.source as! AddVC
        let title = src.addTitleTextField.text
        let desc = src.addDescTextField.text
        let date = src.addDatePicker.date
        print("data from AddVC", title!, desc!, date)
        //SAVE TO DB & UPDATE tableView
        let addNew = Note(context: context)
        addNew.title = title
        addNew.desc = desc
        addNew.date = date
        appDelegate.saveContext()
        tableData.append(addNew)
        tableView.reloadData()
    }
    @IBAction func unwindFromEditVC (segue: UIStoryboardSegue){
        print("uwindFromEditVC Function @ ViewController")
        let src = segue.source as! EditVC
        if let indexPath = src.indexPath{
            let note = tableData[indexPath.row]
            note.title = src.editTitleTextField.text
            note.desc = src.editDescTextField.text
            note.date = src.editDatePicker.date
            print("data from EditVC", note.title!, note.desc!, note.date!)
            appDelegate.saveContext()
            tableView.reloadData()
        }
    }
    @IBAction func unwindFromShowVC (segue: UIStoryboardSegue){
        print("unwindFromShowVC function @ ViewController")
        let src = segue.source as! ShowVC
        if let indexPath = src.indexPath{
            let note = tableData[indexPath.row]
            if src.deleteMark == true {
                self.context.delete(note)
                self.tableData.remove(at: indexPath.row)
                self.appDelegate.saveContext()
                tableView.reloadData()
            }
            if src.checkmarkStatus {
                changeStatus(indexPath)
            }
        }
        
    }
    func fetchAllNotes(){
        let request:NSFetchRequest<Note> = Note.fetchRequest()
        do{
            tableData = try context.fetch(request)
        } catch {
            print("No Data in DB", error)
        }
    }
    func changeStatus(_ indexPath: IndexPath){
        let note = tableData[indexPath.row]
        if note.completed == true {
            note.completed = false
            appDelegate.saveContext()
            tableView.reloadData()
        } else {
            note.completed = true
            appDelegate.saveContext()
            tableView.reloadData()
        }
        
    }
    
    //MAKING PREPARE SEGUE
    //STEP 1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditSegue" {
            // STEP 2: Declare Destination
            let dest = segue.destination as! EditVC
            print("going to EditVC through EditSegue from prepare segue")
            // STEP 3: Package up Data
            if let indexPath = sender as? IndexPath {
                let note = tableData[indexPath.row]
                // STEP 4: Go to EditVC and add Step 5
                dest.note = note
                dest.indexPath = indexPath
            }
            
        }
        if segue.identifier == "ShowSegue" {
            let dest = segue.destination as! ShowVC
            print("going to ShowVC through ShowSegue from prepare segue func in ViewController")
                if let indexPath = sender as? IndexPath {
                    let note = tableData[indexPath.row]
                    dest.note = note
                    dest.indexPath = indexPath
                }
        }
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aCell", for: indexPath) as! ACellVC
        let note = tableData[indexPath.row]
        cell.titleCellLabel.text = note.title
        cell.descCellLabel.text = note.desc
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        cell.dateCellLabel.text = formatter.string(from: note.date!)
        if note.completed == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        if note.urgent == true {
            cell.urgenCellLabel.setImage(#imageLiteral(resourceName: "high_p"), for: .normal)
        } else {
            cell.urgenCellLabel.setImage(#imageLiteral(resourceName: "low_p"), for: .normal)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (action, view, done) in
            self.context.delete(self.tableData[indexPath.row])
            self.tableData.remove(at: indexPath.row)
            self.appDelegate.saveContext()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            done(true)
//            tableView.reloadData()
        }
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfig
    }
    //EDIT & COMPLETED?
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let updateAction = UIContextualAction(style: .normal, title: "Edit"){
            (ac: UIContextualAction, view: UIView, success:(Bool) -> Void) in
            success (true)
            self.performSegue(withIdentifier: "EditSegue", sender: indexPath)
        }
        let checkmarkAction = UIContextualAction(style: .normal, title:"Completed"){
            (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in success(true)
            self.changeStatus(indexPath)
            
        }
        updateAction.backgroundColor = .blue
        checkmarkAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [updateAction, checkmarkAction])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowSegue", sender: indexPath)
    }
}

