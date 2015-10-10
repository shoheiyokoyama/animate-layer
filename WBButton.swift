//
//  WBButton.swift
//  layer-animate
//
//  Created by Shohei Yokoyama on 2015/10/10.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

public class WBButton: UIButton {
    
    private var showBorder = Bool()
    private var stopAnimation = true
    
    public var borderColor: UIColor = UIColor()
    
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
    
    public var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayer() {
        cornerRadius = 5.0
        self.layer.borderWidth = 0
        self.borderColor = UIColor.WBColor.LightGreen
        self.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
    
    private func appearBorder() {
        if stopAnimation {
            return
        }
        
        let animateColor: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animateColor.fromValue = UIColor.clearColor().CGColor
        animateColor.toValue = self.borderColor.CGColor
        self.layer.borderColor = self.borderColor.CGColor
        
        let animateWidth: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        animateWidth.fromValue = 0
        animateWidth.toValue = 1
        self.layer.borderWidth = 1
        
        let bothAnimation: CAAnimationGroup = CAAnimationGroup()
        bothAnimation.duration = 1.5
        bothAnimation.animations = [animateColor, animateWidth]
        bothAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bothAnimation.delegate = self
        self.layer.addAnimation(bothAnimation, forKey: "color and Width")
        showBorder = true
    }
    
    private func disappearBorder() {
        if stopAnimation {
            return
        }
        
        let fadeAnimateColor: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        fadeAnimateColor.fromValue = self.borderColor.CGColor
        fadeAnimateColor.toValue = UIColor.clearColor().CGColor
        self.layer.borderColor = UIColor.clearColor().CGColor
        
        let fadeAnimateWidth: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        fadeAnimateWidth.fromValue = 1
        fadeAnimateWidth.toValue = 0
        self.layer.borderWidth = 0
        
        let bothFadeAnimation: CAAnimationGroup = CAAnimationGroup()
        bothFadeAnimation.duration = 1.5
        bothFadeAnimation.animations = [fadeAnimateColor, fadeAnimateWidth]
        bothFadeAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bothFadeAnimation.delegate = self
        self.layer.addAnimation(bothFadeAnimation, forKey: "color and Width")
        showBorder = false
    }
    
    override public func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if !flag {
            return
        }
        
        if showBorder {
            self.disappearBorder()
        } else {
            self.appearBorder()
        }
    }

}
