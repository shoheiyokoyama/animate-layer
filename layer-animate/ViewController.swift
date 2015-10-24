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
    let label = UILabel(frame: CGRectMake(100, 200, 100, 120))
    let shapeLayer = CAShapeLayer()
    let backgroundView = UIView()
    var textColorAnimation = CABasicAnimation()
    var isAnimateTextColor = true
    var originX: CGFloat = 100
    var originY: CGFloat = 500
    var anmFlg = false
    
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
//        self.view.backgroundColor = UIColor.lightGrayColor()
        
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
        
        toggleButton.setTitle("TEXT", forState: .Normal)
        toggleButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        toggleButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
//        toggleButton.sizeToFit()
//        toggleButton.backgroundColor = UIColor.whiteColor()
        toggleButton.wbLayer.borderWidth = 2
        toggleButton.backgroundColor = UIColor.redColor()
        toggleButton.wbLayer.borderColor = UIColor.WBColor.Cyan
        toggleButton.animationDuration = 1.4
        self.view.addSubview(toggleButton)
//        self.view.addSubview(toggleButton.wbView)
        
        label.text = "Taaaasssssss"
        label.textColor = UIColor.yellowColor()
//        label.backgroundColor = UIColor.redColor()
        label.font = UIFont.systemFontOfSize(20.0)
        
        label.textAlignment = NSTextAlignment.Center
        label.sizeToFit()
        self.view.addSubview(label)
        label.layer.borderColor = UIColor.redColor().CGColor
        label.layer.borderWidth = 1.0
        print(label.font)
        
//        self.textAnimate(label)
        
        self.animateCircle()
        self.textLayerTest(label.text!)
        
    }
    
    private func textLayerTest(text: NSString) {
        
        let font = UIFont.systemFontOfSize(20.0)
        let text = text
        
        
        var attributes = [String: AnyObject]()
        attributes[NSFontAttributeName] = font
        let size = text.sizeWithAttributes(attributes)
        
        
        let x = (CGRectGetWidth(label.frame) - size.width) / 2
        let y = (CGRectGetHeight(label.frame) - size.height) / 2
        let height = size.height + label.layer.borderWidth
        let width = size.width
        let frame = CGRectMake(x, y, width, height)
        print(frame)
        
        let textLayer = CATextLayer()
        textLayer.font = label.font
        textLayer.string = text
        textLayer.fontSize = font.pointSize
        

        textLayer.foregroundColor = UIColor.blackColor().CGColor
//        textLayer.backgroundColor = UIColor.blueColor().CGColor
        textLayer.contentsScale = UIScreen.mainScreen().scale
        
        textLayer.frame = frame
        textLayer.alignmentMode = kCAAlignmentCenter
        
        textLayer.cornerRadius = 5.0
        self.label.layer.addSublayer(textLayer)
//        self.animationTest(textLayer)
    }
    
    private func animationTest(layer: CATextLayer) {
//        let anm = CABasicAnimation(keyPath: "borderColor")
//        let anm = CABasicAnimation(keyPath: "backgroundColor")
        let anm = CABasicAnimation(keyPath: "borderWidth")
        anm.duration = 2.0
        anm.autoreverses = true
        anm.repeatCount = 100
//        anm.toValue = UIColor.redColor().CGColor
//        anm.fromValue = UIColor.clearColor().CGColor
        anm.toValue = 1
        anm.fromValue = 0
        layer.addAnimation(anm, forKey: nil)
    }
    
    func textAnimate(label: UILabel) {
        backgroundView.frame = label.frame
        backgroundView.userInteractionEnabled = false
        backgroundView.backgroundColor = UIColor.blackColor()
        
        self.viewAnimate()
        
        backgroundView.layer.mask = label.layer
        backgroundView.layer.mask!.position = CGPointMake(label.frame.width / 2, label.frame.height / 2)
        
        self.view.addSubview(backgroundView)
    }
    
    func textAnimateWithUIView() {
        UIView.animateKeyframesWithDuration(2.0,
            delay: 0.0,
            options: .Repeat,
            animations: { () -> Void in
                
//                 2.0 * 0.4秒かけて
                UIView.addKeyframeWithRelativeStartTime(0.0
                    , relativeDuration: 0.4, animations: { () -> Void in
                        self.view.backgroundColor = UIColor.redColor()
                })
                
                //0.4秒後に2.0*0.6かけて
                UIView.addKeyframeWithRelativeStartTime(0.4
                    , relativeDuration: 0.6, animations: { () -> Void in
                        self.view.backgroundColor = UIColor.blueColor()
                })
            }, completion: nil)
    }
    
    private func viewAnimate() {
        let beginColor = UIColor.clearColor()
        let endColor =  UIColor.blackColor()//textcolor
        
        textColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        textColorAnimation.duration = 2.0
//        textColorAnimation.removedOnCompletion = false
        textColorAnimation.autoreverses = true
        textColorAnimation.repeatCount = 100
        textColorAnimation.toValue = endColor.CGColor
        textColorAnimation.fromValue = beginColor.CGColor
        backgroundView.layer.addAnimation(textColorAnimation, forKey: "mask")
    }
    
    private func imageFromView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextTranslateCTM(context, -view.frame.origin.x, -view.frame.origin.y)
        view.layer.renderInContext(context)
        
        let renderedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return renderedImage
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
        
        if !anmFlg {
            anmFlg = true
            toggleButton.startAnimation()
        } else {
            anmFlg = false
            toggleButton.stopAnimation()
        }
        
        if isAnimateTextColor {
            self.pauseAction()
            isAnimateTextColor = false
        } else {
            isAnimateTextColor = true
            self.restartAction()
        }
    }
    
    private func pauseAction() {
//        let pausedTime = backgroundView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
//        backgroundView.layer.speed = 0.0
//        backgroundView.layer.timeOffset = pausedTime
        backgroundView.layer.removeAnimationForKey("mask")
    }
    
    private func restartAction() {
//        let pausedTime: CFTimeInterval = backgroundView.layer.timeOffset
//        backgroundView.layer.speed = 1.0
//        backgroundView.layer.timeOffset = 0.0
//        let timeSincePause: CFTimeInterval = label.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
//        backgroundView.layer.beginTime = timeSincePause
        self.viewAnimate()
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        //
    }

}

