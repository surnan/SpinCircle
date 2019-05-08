//
//  CategoryCircle.swift
//  SpinCircle
//
//  Created by admin on 5/7/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

@IBDesignable class CategoryCircle: UIView {
 
    let arcWidth: CGFloat = 75
    var fillColor: UIColor = UIColor.green
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill() //Otherwise, Fill = Black
        path.fill()
        path.stroke()
    }
}
