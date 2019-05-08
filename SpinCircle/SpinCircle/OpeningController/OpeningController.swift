//
//  OpeningController2.swift
//  SpinCircle
//
//  Created by admin on 5/7/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

let sectionCount = 9

class OpeningController: UIViewController {
    
    let mySemiCircle = MySemiCircle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [mySemiCircle].forEach{view.addSubview($0)}
        mySemiCircle.anchor(size: CGSize(width: 350, height: 350))
        mySemiCircle.backgroundColor = .clear   //Otherwise Rectangle area not filled by Bezier is .Black

        
        
        NSLayoutConstraint.activate([
            mySemiCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mySemiCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
}



var wordArray = ["apple", "banana", "cherry", "dog", "echo", "food", "girl", "hero", "ice"]



class MySemiCircle: UIView {
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = bounds.width / 2  //Assuming 'rect' is a Square
        let angle: CGFloat = 2.0 / CGFloat(sectionCount) * CGFloat.pi
        
        for i in 0..<sectionCount {
            let j = CGFloat(i)
            let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: j * angle, endAngle: angle * (1 + j), clockwise: true)
            path.lineWidth = 5
            path.addLine(to: center)
            colorArray[i % colorArray.count].setFill()
            path.addLine(to: center)
            path.fill()
        }
    }
}
