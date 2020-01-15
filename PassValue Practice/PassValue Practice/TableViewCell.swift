//
//  TableViewCell.swift
//  PassValue Practice
//
//  Created by Savannah Su on 2020/1/15.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //**********Closure**********//
    //Closure(step1)
    var closure: ((UITableViewCell) -> Void)?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBAction func deleteBtn(_ sender: Any) {
        
        closure?(self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
