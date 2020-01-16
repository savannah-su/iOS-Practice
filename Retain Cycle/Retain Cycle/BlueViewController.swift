//
//  BlueViewController.swift
//  Retain Cycle
//
//  Created by Savannah Su on 2020/1/15.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {
    
    var blueControllerView = View()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueControllerView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("BlueController's View Deinit")
    }
    
}

extension BlueViewController: ViewDataSource {
    
    func whatever() {
    }
}
