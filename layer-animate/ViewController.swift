//
//  ViewController.swift
//  layer-animate
//
//  Created by Shohei Yokoyama on 2015/10/08.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var textField = UITextField(frame: CGRectMake(0, 0, 300, 50))
    let shapeLayer = CAShapeLayer()
    var completion: Bool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.setItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func setItems() {
        textField.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        textField.borderStyle = .RoundedRect
        textField.layer.cornerRadius = 5
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = UIColor.blueColor().CGColor
        textField.delegate = self
        self.view.addSubview(textField)
        
        let diameter = 100
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        shapeLayer.fillColor = UIColor.whiteColor().CGColor
        shapeLayer.lineWidth = 1
        shapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: 100, y: 100, width: diameter, height: diameter)).CGPath

        self.view.layer.addSublayer(shapeLayer)
        
        self.animateBorder()
        self.animateCircle()
    }
    
    func animateBorder() {
        completion = false
        let animateColor: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animateColor.fromValue = UIColor.clearColor().CGColor
        animateColor.toValue = UIColor.redColor().CGColor
        self.textField.layer.borderColor = UIColor.redColor().CGColor
        
        let animateWidth: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        animateWidth.fromValue = 0
        animateWidth.toValue = 1
        self.textField.layer.borderWidth = 1
        
        let bothAnimation: CAAnimationGroup = CAAnimationGroup()
        bothAnimation.duration = 2.5
        bothAnimation.animations = [animateColor, animateWidth]
        bothAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bothAnimation.delegate = self
        self.textField.layer.addAnimation(bothAnimation, forKey: "color and Width")
    }
    
    func fadeAnimateBorder() {
        let fadeAnimateColor: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        fadeAnimateColor.fromValue = UIColor.redColor().CGColor
        fadeAnimateColor.toValue = UIColor.clearColor().CGColor
        self.textField.layer.borderColor = UIColor.clearColor().CGColor
        
        let fadeAnimateWidth: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        fadeAnimateWidth.fromValue = 1
        fadeAnimateWidth.toValue = 0
        self.textField.layer.borderWidth = 0
        
        let bothFadeAnimation: CAAnimationGroup = CAAnimationGroup()
        bothFadeAnimation.duration = 1.0
        bothFadeAnimation.animations = [fadeAnimateColor, fadeAnimateWidth]
        bothFadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bothFadeAnimation.delegate = self
        self.textField.layer.addAnimation(bothFadeAnimation, forKey: "color and Width")
        completion = true
    }
    
    func animateCircle() {
        let animationStart = CABasicAnimation(keyPath: "strokeStart")
        animationStart.fromValue = -0.5
        animationStart.toValue = 1.0
        
        let animationEnd = CABasicAnimation(keyPath: "strokeEnd")
        animationEnd.fromValue = 0.0
        animationEnd.toValue = 1.0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 3.5
        animationGroup.repeatDuration = CFTimeInterval.infinity
        animationGroup.animations = [animationStart, animationEnd]
        shapeLayer.addAnimation(animationGroup, forKey: nil)
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if completion == false {
            self.fadeAnimateBorder()
        } else {
            self.animateBorder()
        }
    }

}

