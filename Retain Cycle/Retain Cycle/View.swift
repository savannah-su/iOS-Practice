//
//  View.swift
//  Retain Cycle
//
//  Created by Savannah Su on 2020/1/16.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

protocol ViewDataSource: AnyObject {
    
    func whatever()
}

class View: UIView {

    weak var dataSource: ViewDataSource?
    
    deinit {
        print("View Deinit")
    }
}
