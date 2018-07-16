//
//  AddVC.swift
//  bucketList4
//
//  Created by Christopher Chung on 7/15/18.
//  Copyright © 2018 Christopher Chung. All rights reserved.
//

import UIKit

class AddVC: UIViewController {
    @IBOutlet weak var addTitleTextField: UITextField!
    @IBOutlet weak var addDescTextField: UITextField!
    @IBOutlet weak var addDatePicker: UIDatePicker!
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        print("saveButtonPressed Function")
            if addTitleTextField.text == "" || addDescTextField.text == "" {
                print("fill in fields")
                let alert = UIAlertController(title: "Sucks to Suck", message: "Fields must be filled in 🖕🏾", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"👍🏽", style: .default, handler: nil))
                self.present(alert, animated: true)
            } else {
                performSegue(withIdentifier: "unwindFromAddVC", sender: self)
            }
        }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
