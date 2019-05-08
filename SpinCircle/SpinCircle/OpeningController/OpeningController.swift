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
        
        
        setupNavigationMenu()
        
        
    }
    
    
    func setupNavigationMenu(){
        navigationItem.title = "Spin Wheel"
        navigationController?.navigationBar.barTintColor = .skyBlue4
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SPIN", style: .done, target: self, action: #selector(handleSpin))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "STOP", style: .done, target: self, action: #selector(stopRotating))
    }
    
    
    @objc func handleSpin(){
        if mySemiCircle.layer.animation(forKey: kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(Float.pi * 2.0)
            rotationAnimation.duration = 3.0
            rotationAnimation.repeatCount = Float.infinity
            mySemiCircle.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        }
    }
    
    @objc func stopRotating(view: UIView) {
        //        UIViewPropertyAnimator(duration: 2, dampingRatio: 0.4) {
        //            print("Slowing down animation")
        //        }
        
        if mySemiCircle.layer.animation(forKey: kRotationAnimationKey) != nil {
              mySemiCircle.layer.removeAnimation(forKey: kRotationAnimationKey)
        }
    }
    
    let kRotationAnimationKey = "com.myapplication.rotationanimationkey" // Any key
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
