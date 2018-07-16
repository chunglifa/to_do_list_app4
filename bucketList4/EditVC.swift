//
//  EditVC.swift
//  bucketList4
//
//  Created by Christopher Chung on 7/15/18.
//  Copyright © 2018 Christopher Chung. All rights reserved.
//

import UIKit

class EditVC: UIViewController {
    // STEP 5. Make Variables to receive data
    var note: Note?
    var indexPath: IndexPath?
    
    @IBOutlet weak var editTitleTextField: UITextField!
    @IBOutlet weak var editDescTextField: UITextField!
    @IBOutlet weak var editDatePicker: UIDatePicker!
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if editTitleTextField.text == "" || editDescTextField.text == "" {
            print("must fill in fields")
            let alert = UIAlertController(title: "Error", message: "Fields must be filled in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if editDatePicker.date < Date() {
            print("must select future date")
            let alert = UIAlertController(title: "⏰ Date Error", message: "Must select future time & date", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "unwindFromEditVC", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unpack()

        // Do any additional setup after loading the view.
    }
    //STEP 6: Now that you've received the data, set labels on tableView to data values sent from ViewController
    func unpack() {
            editTitleTextField.text = note?.title
            editDescTextField.text = note?.desc
            editDatePicker.date = (note?.date)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
