//
//  ViewController.swift
//  layer-animate
//
//  Created by Shohei Yokoyama on 2015/10/08.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit
import QuartzCore

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
        wbTextField.borderColor = UIColor.WBColor.Cyan
        self.view.addSubview(wbTextField)
//        self.drawShadow()
        
        let diameter = 100
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        shapeLayer.fillColor = UIColor.whiteColor().CGColor
        shapeLayer.lineWidth = 1
        shapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: 100, y: 100, width: diameter, height: diameter)).CGPath
        self.view.layer.addSublayer(shapeLayer)
        
        toggleButton.setTitle("Check TEXT", forState: .Normal)
        toggleButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        toggleButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        toggleButton.sizeToFit()
//        toggleButton.borderColor = UIColor.WBColor.Cyan
        toggleButton.animateLayer = false
        toggleButton.animationDuration = 1.4
        self.view.addSubview(toggleButton)
        
        self.animateCircle()
    }
    
    func drawLayerShadow() {
        let subLayer = CALayer()
        subLayer.frame = wbTextField.bounds
        wbTextField.layer.addSublayer(subLayer)
        subLayer.masksToBounds = false
        
        let size = subLayer.bounds.size
        var x: CGFloat = -10.0
        var y:CGFloat = -10.0
        
        let pathRef: CGMutablePathRef = CGPathCreateMutable()
        //move initial point
        CGPathMoveToPoint(pathRef, nil, x, y)
        
        // top line
        x += size.width + 10
        CGPathAddLineToPoint(pathRef, nil, x, y)
        y += 10
        CGPathAddLineToPoint(pathRef, nil, x, y)
        x -= size.width
        CGPathAddLineToPoint(pathRef, nil, x, y)
        
        //left line
        y += size.height
        CGPathAddLineToPoint(pathRef, nil, x, y)
        x -= 10
        CGPathAddLineToPoint(pathRef, nil, x, y)
        y -= size.height
        CGPathAddLineToPoint(pathRef, nil, x, y)

        CGPathCloseSubpath(pathRef)
        
        subLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        subLayer.shadowColor = UIColor.blackColor().CGColor
        subLayer.shadowOpacity = 1
        subLayer.shadowPath = pathRef
    }
    
    func drawShadow() {
        let subLayer = CALayer()
        subLayer.frame = wbTextField.bounds
        wbTextField.layer.addSublayer(subLayer)
        subLayer.masksToBounds = false
        
        let size = subLayer.bounds.size
        var x: CGFloat = -10.0
        var y:CGFloat = -10.0
        
        let pathRef: CGMutablePathRef = CGPathCreateMutable()
        //move initial point
        CGPathMoveToPoint(pathRef, nil, x, y)
        
        // top line
        x += size.width + 10
        CGPathAddLineToPoint(pathRef, nil, x, y)
        y += 10
        CGPathAddLineToPoint(pathRef, nil, x, y)
        x -= size.width
        CGPathAddLineToPoint(pathRef, nil, x, y)
        
        //left line
        y += size.height
        CGPathAddLineToPoint(pathRef, nil, x, y)
        x -= 10
        CGPathAddLineToPoint(pathRef, nil, x, y)
        y -= size.height
        CGPathAddLineToPoint(pathRef, nil, x, y)

//        // move left bottom
//        y += size.height
//        x -= 10.0
//        CGPathMoveToPoint(pathRef, nil, x, y)
//        
//        // bottom line
//        x += size.width + 20.0
//        CGPathAddLineToPoint(pathRef, nil, x, y)
//        y -= 10.0
//        CGPathAddLineToPoint(pathRef, nil, x, y)
//        x -= size.width - 5
//        CGPathAddLineToPoint(pathRef, nil, x, y)
//        
        CGPathCloseSubpath(pathRef)
        
        subLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        subLayer.shadowColor = UIColor.blackColor().CGColor
        subLayer.shadowOpacity = 1
        subLayer.shadowPath = pathRef
        
//        let rightButtomLayer = CALayer()
//        rightButtomLayer.frame = wbTextField.bounds
//        wbTextField.layer.addSublayer(rightButtomLayer)
//        rightButtomLayer.masksToBounds = false
//        
//        let rightButtomSize = rightButtomLayer.bounds.size
//        let rightButtomX: CGFloat = rightButtomSize.width + 10.0
//        let rightButtomY:CGFloat = rightButtomSize.height + 10.0
//        
//        let rightButtomPathRef: CGMutablePathRef = CGPathCreateMutable()
//        //move initial point
//        CGPathMoveToPoint(rightButtomPathRef, nil, rightButtomX, rightButtomY)
//        
//        // Right line
//        x -= rightButtomSize.width - 10.0
//        CGPathAddLineToPoint(rightButtomPathRef, nil, rightButtomX, rightButtomY)
//        y -= 10
//        CGPathAddLineToPoint(rightButtomPathRef, nil, rightButtomX, rightButtomY)
//        x += rightButtomSize.width
//        CGPathAddLineToPoint(rightButtomPathRef, nil, rightButtomX, rightButtomY)
//        
//        CGPathCloseSubpath(rightButtomPathRef)
//        
//        rightButtomLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
//        rightButtomLayer.shadowColor = UIColor.yellowColor().CGColor
//        rightButtomLayer.shadowOpacity = 1
//        rightButtomLayer.shadowPath = rightButtomPathRef
        
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
//        if wbTextField.checkEmptyText() {
//            toggleButton.animateLayer = false
//            toggleButton.setTitle("NOT EMPTY", forState: .Normal)
//        } else {
//            toggleButton.animateLayer = true
//            toggleButton.setTitle("EMPTY", forState: .Normal)
//        }
        if wbTextField.animateLayer {
           wbTextField.animateLayer = false
        } else {
            wbTextField.animateLayer = true
        }
        
        if toggleButton.animateLayer {
            toggleButton.animateLayer = false
        } else {
            toggleButton.animateLayer = true
        }
    }

}

