//
//  OpeningController.swift
//  SpinCircle
//
//  Created by admin on 5/7/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class OpeningController: UIViewController {
    
    let myCircle = CategoryCircle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [myCircle].forEach{view.addSubview($0)}
        
        myCircle.anchor(size: CGSize(width: 300, height: 300))
        myCircle.backgroundColor = .white   //Otherwise Rectangle area not filled by Bezier is .Black
        
        
        NSLayoutConstraint.activate([
            myCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        
        
    }
}
