//
//  ViewController.swift
//  Auto Layout Event Cycle
//
//  Created by Savannah Su on 2020/1/16.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let yellowCircle = CircleView()
//    let purpleCircle = UIView()
//    let redCircle = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupYellowCircle()
        
//        setupPurpleCircle()
//
//        setupRedCircle()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        yellowCircle.clipsToBounds = true
        yellowCircle.layer.cornerRadius = yellowCircle.frame.width / 2
        
//        yellowCircle.layoutIfNeeded()
        
//        purpleCircle.clipsToBounds = true
//        purpleCircle.layer.cornerRadius = purpleCircle.frame.width / 2
//
//        redCircle.clipsToBounds = true
//        redCircle.layer.cornerRadius = redCircle.frame.width / 2
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//
//        purpleCircle.clipsToBounds = true
//        purpleCircle.layer.cornerRadius = purpleCircle.frame.width / 2
//
//        redCircle.clipsToBounds = true
//        redCircle.layer.cornerRadius = redCircle.frame.width / 2
    }
    
    
    func setupYellowCircle() {
        
        view.addSubview(yellowCircle)
        
        yellowCircle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yellowCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            yellowCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            yellowCircle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            yellowCircle.heightAnchor.constraint(equalTo: yellowCircle.widthAnchor)
        ])
        
        yellowCircle.backgroundColor = .yellow
    }
    
//    func setupPurpleCircle() {
//
//        yellowCircle.addSubview(purpleCircle)
//
//        purpleCircle.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            purpleCircle.leadingAnchor.constraint(equalTo: yellowCircle.leadingAnchor),
//            purpleCircle.centerYAnchor.constraint(equalTo: yellowCircle.centerYAnchor),
//            purpleCircle.widthAnchor.constraint(equalTo: yellowCircle.widthAnchor, multiplier: 1/2),
//            purpleCircle.heightAnchor.constraint(equalTo: yellowCircle.heightAnchor, multiplier: 1/2)
//        ])
//
//        purpleCircle.backgroundColor = .purple
//    }
//
//    func setupRedCircle() {
//
//        yellowCircle.addSubview(redCircle)
//
//        redCircle.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            redCircle.trailingAnchor.constraint(equalTo: yellowCircle.trailingAnchor),
//            redCircle.centerYAnchor.constraint(equalTo: yellowCircle.centerYAnchor),
//            redCircle.widthAnchor.constraint(equalTo: yellowCircle.widthAnchor, multiplier: 1/2),
//            redCircle.heightAnchor.constraint(equalTo: yellowCircle.heightAnchor, multiplier: 1/2)
//        ])
//
//        redCircle.backgroundColor = .red
//    }
    
    
}

