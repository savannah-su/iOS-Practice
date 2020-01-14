//
//  ViewController.swift
//  DelegatePractice
//
//  Created by Savannah Su on 2020/1/13.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

let topButton: [String] = ["Red", "Yellow"]
let topColor: [UIColor] = [UIColor.red, UIColor.yellow]
let downButton: [String] = ["Red", "Yellow", "Blue"]
let downColor: [UIColor] = [UIColor.red, UIColor.yellow, UIColor.blue]

class ViewController: UIViewController {
    
    @IBOutlet weak var topButtonView: SelectionView! {
        
        didSet {
            topButtonView.dataSource = self
            topButtonView.delegate = self
        }
        
    }
    @IBOutlet weak var topColorView: UIView!
    @IBOutlet weak var downButtonView: SelectionView! {
        
        didSet{
            downButtonView.dataSource = self
            downButtonView.delegate = self
        }
    }
    
    @IBOutlet weak var downColorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topColorView.backgroundColor = topColor.first
        downColorView.backgroundColor = downColor.first
        // Do any additional setup after loading the view.
    }
}


extension ViewController: SelectionViewDataSource {
    
    func numberOfButton(_ selectionView: SelectionView) -> Int {
        
        if selectionView == topButtonView {
            return topButton.count
        } else {
            return downButton.count
        }
        
    }

    func titleOfButton(_ selectionView: SelectionView, selectedIndex: Int) -> String {
        
        if selectionView == topButtonView {
            return topButton[selectedIndex]
        } else {
            return downButton[selectedIndex]
        }
        
    }

    func colorOfTitle(_ selectionView: SelectionView) -> UIColor {
        return .white
    }

    func colorOfIndicator(_ selectionView: SelectionView) -> UIColor {
        return .white
    }

    func fontOfIndicator(_ selectionView: SelectionView) -> UIFont {
        return UIFont.systemFont(ofSize: 18)
    }
    
}

extension ViewController: SelectionViewDelegate {
    
    func selectedButton(_ selectionView: SelectionView, selectedIndex: Int) {
        
        if selectionView == topButtonView {
            topColorView.backgroundColor = topColor[selectedIndex]
        } else {
            downColorView.backgroundColor = downColor[selectedIndex]
        }
        
    }
    
    func couldSelectedButton(_ selectionView: SelectionView, selectedIndex: Int) -> Bool {
        
        if selectionView == downButtonView {
            if topButtonView.selectedBtnIndex == topButton.count - 1 {
                return false
            } else {
                return true
            }
        } else {
            return true
        }
        
//        if selectionView == topButtonView {
//            return true
//        } else {
//            if topButtonView.selectedBtnIndex == topButton.count - 1 {
//                return false
//            } else {
//                return true
//            }
//        }
 
    }
}
