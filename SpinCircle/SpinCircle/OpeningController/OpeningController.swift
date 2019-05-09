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
    
    
    var finalVelocity = 0
    var currentlyPan = false
    var clockwise: Float = 1.0
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer){
        let velocity = sender.velocity(in: view)
        let x = velocity.x
        let y = velocity.y
        let speed = x * x * y * y
        let root = speed.squareRoot()
        let rootInt = Int(root)
        currentlyPan = true

        
        if abs(x) > abs(y) {
            clockwise = x > 0 ? -1 : 1
        } else {
            clockwise = y < 0 ? 1 : -1
        }
        
        
        
        
        if sender.state == UIGestureRecognizer.State.ended {
            print("-- FIRE AWAY --")
            finalVelocity = rootInt
            spin()
        }
    }
    
    
    func setupNavigationMenu(){
        navigationItem.title = "Spin Wheel"
        navigationController?.navigationBar.barTintColor = .skyBlue4
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SPIN", style: .done, target: self, action: #selector(handleSpin))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "STOP", style: .done, target: self, action: #selector(stopRotating))
    }
    
    
    
    func spin(){

        CATransaction.begin()

        
        CATransaction.setCompletionBlock({
            print("Transaction completed")
        })
        let divisionConst = 250000
        let newLimit: Float = Float(finalVelocity) / Float(divisionConst)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float(Float.pi * newLimit * clockwise)
        rotationAnimation.duration = 1
        
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        mySemiCircle.layer.add(rotationAnimation, forKey: self.kRotationAnimationKey)
        CATransaction.commit()
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


/*
 
 
 /*
 UIView.animate(withDuration: 10,
 delay: 0,
 usingSpringWithDamping: 1.0,
 initialSpringVelocity: 0,
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
 */
 
 
 
 //        if mySemiCircle.layer.animation(forKey: kRotationAnimationKey) == nil {
 //            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
 //            rotationAnimation.fromValue = 0.0
 //            rotationAnimation.toValue = Float(Float.pi * 2.0)
 //            rotationAnimation.duration = 3.0
 //            rotationAnimation.repeatCount = Float.infinity
 //            mySemiCircle.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
 //        }
 */
