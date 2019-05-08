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
    let mySemiCircle = MySemiCircle()
    let myLabel = MyLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        myLabel.text = "Pizza"
        myLabel.textColor = .white
        
        [myCircle, mySemiCircle, myLabel].forEach{view.addSubview($0)}
        mySemiCircle.anchor(size: CGSize(width: 300, height: 300))
        mySemiCircle.backgroundColor = .clear   //Otherwise Rectangle area not filled by Bezier is .Black
        myCircle.backgroundColor = .clear
        myLabel.backgroundColor = .clear
        
        myLabel.anchor(size: CGSize(width: 300, height: 300))
//        myLabel.backgroundColor = .white   //Otherwise Rectangle area not filled by Bezier is .Black
        
        
        
        
        
        NSLayoutConstraint.activate([
            mySemiCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mySemiCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            myLabel.topAnchor.constraint(equalTo: mySemiCircle.bottomAnchor, constant: 10),
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
}



class MySemiCircle: UIView {
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = bounds.width / 2  //Assuming 'rect' is a Square
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: .pi, endAngle: 3 * .pi / 2, clockwise: true)
        path.lineWidth = 5
        path.addLine(to: center)
        UIColor.blue.setFill()
        path.fill()
    }
}


class MyLabel: UILabel {
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = bounds.width / 2  //Assuming 'rect' is a Square
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 3 * .pi / 2, endAngle: 2 * .pi , clockwise: true)
        path.lineWidth = 5
        path.addLine(to: center)
        UIColor.red.setFill()
        path.fill()
    }
}

