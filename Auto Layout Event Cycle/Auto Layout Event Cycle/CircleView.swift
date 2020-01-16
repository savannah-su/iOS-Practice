//
//  Small Circles.swift
//  Auto Layout Event Cycle
//
//  Created by Savannah Su on 2020/1/16.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    let purpleCircle: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        view.clipsToBounds = true
        return view
    }()
    
    let redCircle: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupSmallCircles()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        purpleCircle.layer.cornerRadius = purpleCircle.frame.width / 2
        redCircle.layer.cornerRadius = redCircle.frame.width / 2
    }
    
    func setupSmallCircles() {
        
        addSubview(purpleCircle)
        addSubview(redCircle)
        
        NSLayoutConstraint.activate([
            purpleCircle.leadingAnchor.constraint(equalTo: leadingAnchor),
            purpleCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            purpleCircle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
            purpleCircle.heightAnchor.constraint(equalTo: purpleCircle.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
        redCircle.trailingAnchor.constraint(equalTo: trailingAnchor),
        redCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
        redCircle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
        redCircle.heightAnchor.constraint(equalTo: redCircle.widthAnchor)
        ])
    }
    
}
