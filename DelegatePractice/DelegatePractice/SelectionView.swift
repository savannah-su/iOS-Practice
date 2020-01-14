//
//  SelectionView.swift
//  DelegatePractice
//
//  Created by Savannah Su on 2020/1/13.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

protocol SelectionViewDataSource: AnyObject {
    
    func numberOfButton(_ selectionView: SelectionView) -> Int
    func titleOfButton(_ selectionView: SelectionView, selectedIndex: Int) -> String
    func colorOfTitle(_ selectionView: SelectionView) -> UIColor
    func colorOfIndicator(_ selectionView: SelectionView) -> UIColor
    func fontOfIndicator(_ selectionView: SelectionView) -> UIFont
    
}

extension SelectionViewDataSource {
    
    func numberOfButton(_ selectionView: SelectionView) -> Int { return 2 }
    func titleOfButton(_ selectionView: SelectionView, selectedIndex: Int) -> String { return "Hello" }
    func colorOfTitle(_ selectionView: SelectionView) -> UIColor { return .white }
    func colorOfIndicator(_ selectionView: SelectionView) -> UIColor { return .blue }
    func fontOfIndicator(_ selectionView: SelectionView) -> UIFont { return UIFont.systemFont(ofSize: 18) }
    
}

@objc protocol SelectionViewDelegate: AnyObject {
    
    @objc optional func selectedButton(_ selectionView: SelectionView, selectedIndex: Int)
    @objc optional func couldSelectedButton(_ selectionView: SelectionView, selectedIndex: Int) -> Bool
}

class SelectionView: UIView {
    //ARC Retain Cycle
    weak var dataSource: SelectionViewDataSource? {
        
        didSet {
            setupSelectionView()
            setupIndicatorView()
        }
        
    }
    
    weak var delegate: SelectionViewDelegate?
    
    var selectedBtnIndex = 0
    
    let indicatorView = UIView()
    var indicatorCenterXConstraint: NSLayoutConstraint?
    
    var buttons: [UIButton] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupSelectionView() {
        
        let stackView: UIStackView = {
            
            let buttonView = UIStackView()
            /* A stack with a horizontal axis is a row of arrangedSubviews,
             and a stack with a vertical axis is a column of arrangedSubviews.
             */
            buttonView.axis = NSLayoutConstraint.Axis.horizontal
            /* The layout of the arrangedSubviews along the axis
             */
            buttonView.distribution = UIStackView.Distribution.fillEqually
            
            return buttonView
        }()
        //每次生成前，先清空
        buttons.removeAll()
        
        //用guard let檢查dataSource
        guard let dataSource = dataSource else { return }
        for buttonIndex in 0 ... (dataSource.numberOfButton(self) - 1) {
            
            let button = UIButton()
            
            stackView.addArrangedSubview(button)
            //先把buttonArray加上去
            self.buttons.append(button)
            
            button.tag = buttonIndex
            button.setTitle(dataSource.titleOfButton(self, selectedIndex: buttonIndex), for: .normal)
            button.setTitleColor(dataSource.colorOfTitle(self), for: .normal)
            button.addTarget(self, action: #selector(selectedItem), for: .touchUpInside)
            
        }
        
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func moveIndicatorView(sender: UIButton) {
        
        let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            
            self.indicatorCenterXConstraint?.isActive = false
            self.indicatorCenterXConstraint = self.indicatorView.centerXAnchor.constraint(equalTo: sender.centerXAnchor)
            self.indicatorCenterXConstraint?.isActive = true
            //讓畫面的constraint重新呈現
            self.layoutIfNeeded()
        }
        
        animator.startAnimation()
    }
    
    //點擊到Button後發生的事件(addTarget須加@objc)
    @objc func selectedItem(sender: UIButton) {
        
        //先檢查可不可以點選，再顯示顏色跟View滑動
        guard delegate?.couldSelectedButton?(self, selectedIndex: sender.tag) == true else { return }
        delegate?.selectedButton?(self, selectedIndex: sender.tag)
        selectedBtnIndex = sender.tag
        
        moveIndicatorView(sender: sender)
    }
    
    func setupIndicatorView() {
        
        guard let dataSource = dataSource else { return }
        
        self.addSubview(indicatorView)
        
        let color = dataSource.colorOfIndicator(self)
        indicatorView.backgroundColor = color
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        //讓下方移動view最一開始對準在中間
        
        indicatorCenterXConstraint = indicatorView.centerXAnchor.constraint(equalTo: buttons.first!.centerXAnchor)
        
        NSLayoutConstraint.activate([
            //IndicatorView會被ColorView蓋住
            //indicatorView.topAnchor.constraint(equalTo: self.bottomAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            //indicatorView.leadingAnchor.constraint(equalTo: SelectionView.leadingAnchor),
            //indicatorView.trailingAnchor.constraint(equalTo: SelectionView.trailingAnchor),
            indicatorView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / CGFloat(dataSource.numberOfButton(self)) / 2),
            indicatorView.heightAnchor.constraint(equalToConstant: 1),
            
            indicatorCenterXConstraint!
        ])
        
    }
    
}
