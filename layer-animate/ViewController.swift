//
//  ViewController.swift
//  layer-animate
//
//  Created by Shohei Yokoyama on 2015/10/08.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var wbTextField = WBTextField(frame: CGRectMake(0, 0, 200, 30))
    let toggleButton = WBButton(frame: CGRectMake(100, 450, 100, 30))
    let shapeLayer = CAShapeLayer()
    
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
        wbTextField.layer.position = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2 + 60)
        wbTextField.delegate = self
        wbTextField.borderColor = UIColor.WBColor.Amber
        self.view.addSubview(wbTextField)
        
        let diameter = 100
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        shapeLayer.fillColor = UIColor.whiteColor().CGColor
        shapeLayer.lineWidth = 1
        shapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: 100, y: 100, width: diameter, height: diameter)).CGPath
        self.view.layer.addSublayer(shapeLayer)
        
        toggleButton.setTitle("Animation Start", forState: .Normal)
        toggleButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        toggleButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        toggleButton.sizeToFit()
        toggleButton.animateLayer = true
        self.view.addSubview(toggleButton)
        
        self.animateCircle()
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
    
    internal func onClickMyButton(sender: UIButton) {
        if wbTextField.animateLayer {
            wbTextField.animateLayer = false
            toggleButton.setTitle("Animation Start", forState: .Normal)
        } else {
            wbTextField.animateLayer = true
            toggleButton.setTitle("Animation Stop", forState: .Normal)
        }
        
        if toggleButton.animateLayer {
            toggleButton.animateLayer = false
        } else {
            toggleButton.animateLayer = true
        }
    }

}

