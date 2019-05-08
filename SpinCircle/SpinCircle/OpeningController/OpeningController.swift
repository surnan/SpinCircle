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
        setupNavigationMenu()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        mySemiCircle.addGestureRecognizer(panGesture)
        
        [mySemiCircle].forEach{view.addSubview($0)}
        mySemiCircle.anchor(size: CGSize(width: 350, height: 350))
        mySemiCircle.backgroundColor = .clear   //Otherwise Rectangle area not filled by Bezier is .Black
        
        NSLayoutConstraint.activate([
            mySemiCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mySemiCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
    
    
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer){
        let velocity = sender.velocity(in: view)
        let x = velocity.x
        let y = velocity.y
        let speed = x * x * y * y
        let root = speed.squareRoot()
        let rootInt = Int(root)
        let up = y > 0 ? false : true
        print("velocity ==> \(rootInt) .... up = \(up)")
        finalVelocity = rootInt
        spin()
    }


    func setupNavigationMenu(){
        navigationItem.title = "Spin Wheel"
        navigationController?.navigationBar.barTintColor = .skyBlue4
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SPIN", style: .done, target: self, action: #selector(handleSpin))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "STOP", style: .done, target: self, action: #selector(stopRotating))
    }
    
    var finalVelocity = 0
    
    func spin(){
        UIView.animate(withDuration: 5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: .curveEaseOut,
                       animations: {
                        if self.mySemiCircle.layer.animation(forKey: self.kRotationAnimationKey) == nil {
                            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
                            rotationAnimation.fromValue = 0.0
                            rotationAnimation.toValue = Float(Float.pi * 2.0)
                            self.mySemiCircle.layer.add(rotationAnimation, forKey: self.kRotationAnimationKey)
                        }
        },
                       completion: { (_) in
                        print("Animation Ended")
        })
//        if mySemiCircle.layer.animation(forKey: kRotationAnimationKey) == nil {
//            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
//            rotationAnimation.fromValue = 0.0
//            rotationAnimation.toValue = Float(Float.pi * 2.0)
//            rotationAnimation.duration = 3.0
//            rotationAnimation.repeatCount = Float.infinity
//            mySemiCircle.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
//        }
    }
    
    @objc func handleSpin(){
        spin()
    }
    
    @objc func stopRotating(view: UIView) {
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
