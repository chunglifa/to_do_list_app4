//
//  ACellVC.swift
//  bucketList4
//
//  Created by Christopher Chung on 7/15/18.
//  Copyright © 2018 Christopher Chung. All rights reserved.
//

import UIKit

class ACellVC: UITableViewCell {
    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var descCellLabel: UILabel!
    @IBOutlet weak var dateCellLabel: UILabel!
    @IBOutlet weak var urgenCellLabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
