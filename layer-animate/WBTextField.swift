//
//  WBTextField.swift
//  layer-animate
//
//  Created by Shohei Yokoyama on 2015/10/09.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

public class WBTextField: UITextField {
    
    private var showBorder = Bool()
    private var stopAnimation = Bool()
    
    public var animateLayer = false {
        didSet {
            if animateLayer {
                self.stopAnimation = false
                self.appearBorder()
            } else {
                self.stopAnimation = true
                self.showBorder = false
                
                self.layer.borderColor = UIColor.clearColor().CGColor
                self.layer.borderWidth = 0
            }
        }
    }
    
    private func appearBorder() {
        let animateColor: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animateColor.fromValue = UIColor.clearColor().CGColor
        animateColor.toValue = UIColor.redColor().CGColor
        self.layer.borderColor = UIColor.redColor().CGColor
        
        let animateWidth: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        animateWidth.fromValue = 0
        animateWidth.toValue = 1
        self.layer.borderWidth = 1
        
        let bothAnimation: CAAnimationGroup = CAAnimationGroup()
        bothAnimation.duration = 2.5
        bothAnimation.animations = [animateColor, animateWidth]
        bothAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bothAnimation.delegate = self
        self.layer.addAnimation(bothAnimation, forKey: "color and Width")
        showBorder = true
    }
    
    private func disappearBorder() {
        let fadeAnimateColor: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        fadeAnimateColor.fromValue = UIColor.redColor().CGColor
        fadeAnimateColor.toValue = UIColor.clearColor().CGColor
        self.layer.borderColor = UIColor.clearColor().CGColor
        
        let fadeAnimateWidth: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        fadeAnimateWidth.fromValue = 1
        fadeAnimateWidth.toValue = 0
        self.layer.borderWidth = 0
        
        let bothFadeAnimation: CAAnimationGroup = CAAnimationGroup()
        bothFadeAnimation.duration = 1.0
        bothFadeAnimation.animations = [fadeAnimateColor, fadeAnimateWidth]
        bothFadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bothFadeAnimation.delegate = self
        self.layer.addAnimation(bothFadeAnimation, forKey: "color and Width")
        showBorder = false
    }
    
    override public func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if stopAnimation {
            return
        }
        
        if showBorder == true {
            self.disappearBorder()
        } else {
            self.appearBorder()
        }
    }
}
