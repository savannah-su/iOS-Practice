//
//  ViewController.swift
//  Retain Cycle
//
//  Created by Savannah Su on 2020/1/15.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

class YellowViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("Yellow View Controller Deinit")
    }
}
