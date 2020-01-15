//
//  TextViewController.swift
//  PassValue Practice
//
//  Created by Savannah Su on 2020/1/15.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    weak var delegate: ContentDelegate?
    
    let textField = UITextField()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
        setupButton()
        
        // Do any additional setup after loading the view.
    }
    
    func setupTextView() {
        
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        textField.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 2/3).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //內建型態
        textField.borderStyle = .roundedRect
        //textField.layer.borderWidth = 2
        //textField.layer.borderColor = UIColor.gray.cgColor
        
    }
    
    func setupButton() {
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 20)
        ])
        
        button.backgroundColor = .black
        button.tintColor = .white
        button.setTitle("Button", for: .normal)
        
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
    }
    
    @objc func touchButton() {
        
        //guard textField.text != nil else { return }後，下面可以直接加!且不會閃退
        guard let text = textField.text else { return }
        self.delegate?.getContent(text: text)
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

protocol ContentDelegate: AnyObject {
    
    func getContent(text: String)
}
