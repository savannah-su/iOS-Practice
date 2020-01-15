//
//  TableViewCell.swift
//  PassValue Practice
//
//  Created by Savannah Su on 2020/1/15.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //**********Remove-Delegate**********//
    //Delegate(step2)
    var removeDelegate: removeContentDelegate?
    
    //**********Remove-Closure**********//
    //Closure(step1)
    //var closure: ((UITableViewCell) -> Void)?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBAction func deleteBtn(_ sender: Any) {
        
        //**********Remove-Delegate**********//
        //Delegate(step3)
        removeDelegate?.removeContent(from: self)
        //**********Remove-Closure**********//
        //Closure(step3)
        //closure?(self)
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


//**********Remove-Delegate**********//
//Delegate(step1)

protocol removeContentDelegate {
    
    func removeContent(from tableViewCell: TableViewCell)
    
}
