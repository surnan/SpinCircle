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
    let viewForPan = UIView()
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationMenu()
        
        view.backgroundColor = .white
        [mySemiCircle, viewForPan].forEach{view.addSubview($0)}
        mySemiCircle.anchor(size: CGSize(width: 350, height: 350))
        mySemiCircle.backgroundColor = .clear   //Otherwise Rectangle area not filled by Bezier is .Black


        mySemiCircle.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
    
        view.addGestureRecognizer(panGesture)
        view.addGestureRecognizer(tapGesture)
        
        mySemiCircle.addGestureRecognizer(panGesture)
        mySemiCircle.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            mySemiCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mySemiCircle.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        
        
        
        
        
    }
    
    
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer){
        print("")
    }
    
    
    
    @objc func handleTapGesture(_ sender: UITapGestureRecognizer){
        print("TAPPED")
    }
    
    
    func setupNavigationMenu(){
        navigationItem.title = "Spin Wheel"
        navigationController?.navigationBar.barTintColor = .skyBlue4
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SPIN", style: .done, target: self, action: #selector(handleSpin))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "STOP", style: .done, target: self, action: #selector(stopRotating))
    }
    
    func randomNumber()->Float {
        let random = Float.random(in: 2 ..< 10)
        return random
    }
    
    @objc func handleSpin(){
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float(Float.pi * 2.0 * randomNumber())
//        rotationAnimation.duration = 10.0  //How long to reach 'rotation.toValue'
        rotationAnimation.speed = 0.05
        self.mySemiCircle.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
        
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
//            rotationAnimation.fromValue = 0.0
//            rotationAnimation.toValue = Float(Float.pi * 2.0 * 10)
//            rotationAnimation.duration = 10.0
//            self.mySemiCircle.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
//        }, completion: nil)
        
        
        
    }
    
    @objc func stopRotating(view: UIView) {

        
//        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
//            self.mySemiCircle.layer.timeOffset = self.mySemiCircle.layer.convertTime(CACurrentMediaTime(), from: nil)
//            if self.mySemiCircle.layer.speed == 0 { timer.invalidate() }
//            self.mySemiCircle.layer.beginTime = CACurrentMediaTime()
//            self.mySemiCircle.layer.speed -= 0.5
//
//        }
//        timer.fire()
        
        
        
        
//        if mySemiCircle.layer.animation(forKey: kRotationAnimationKey) != nil {
//              mySemiCircle.layer.removeAnimation(forKey: kRotationAnimationKey)
//        }
    }
}


let kRotationAnimationKey = "com.myapplication.rotationanimationkey" // Any key

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
