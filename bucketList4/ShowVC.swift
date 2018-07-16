//
//  ShowVC.swift
//  bucketList4
//
//  Created by Christopher Chung on 7/15/18.
//  Copyright © 2018 Christopher Chung. All rights reserved.
//

import UIKit

class ShowVC: UIViewController {
    var note: Note?
    var indexPath: IndexPath?
    var deleteMark: Bool = false
    var checkmarkStatus: Bool = false

    @IBOutlet var showView: UIView!
    @IBOutlet weak var showTitleCellLabel: UILabel!
    @IBOutlet weak var showDescCellLabel: UILabel!
    @IBOutlet weak var showDateCellLabel: UILabel!
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        self.checkmarkStatus = true
        performSegue(withIdentifier: "unwindFromShowVC", sender: sender)
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.deleteMark = true
        print(sender)
        sender.tag = 1
        performSegue(withIdentifier: "unwindFromShowVC", sender: sender)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        unpack()

        // Do any additional setup after loading the view.
    }
    func unpack() {
        print("unpack function @ ShowVC")
        showTitleCellLabel.text = note?.title
        showDescCellLabel.text = note?.desc
        self.checkmarkStatus = (note?.completed)!
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        showDateCellLabel.text = formatter.string(from: (note?.date)!)
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
