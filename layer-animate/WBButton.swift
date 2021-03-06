//
//  WBButton.swift
//  layer-animate
//
//  Created by Shohei Yokoyama on 2015/10/10.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

public enum WBButtonBlinkingAnimation {
    case Line
    case Light
    case Background
    case LightBackground
    case Text
}

public class WBButton: UIButton {
    
    private var blingShadow = CABasicAnimation()
    private var blingColor = CABasicAnimation()
    private var blingBackgroundColorAnimation = CABasicAnimation()
    private var blingWidth = CABasicAnimation()
    private var blingTextColorAnimation = CABasicAnimation()
    
    public var borderColor: UIColor = UIColor.WBColor.DeepOrange {
        didSet {
            self.layer.shadowColor = borderColor.CGColor
            self.resetBlingColor()
            self.layer
        }
    }
    
    public var blingBackgroundColor = UIColor.WBColor.DeepOrange {
        didSet {
            self.layer.shadowColor = blingBackgroundColor.CGColor
            self.resetBlingBackgroundColor()
        }
    }
    
    public var blingShadowColor = UIColor.WBColor.DeepOrange {
        didSet {
            self.layer.shadowColor = blingShadowColor.CGColor
        }
    }
    
    public var blingTextColor = UIColor.WBColor.Brown
    
    public var animationDuration: CFTimeInterval = 3.0
    
    public var wbView: UIView = UIView()
    
    public var textAnimtion = false
    private var isCallTextAnimation = false
    
    public var animateLayer = false {
        didSet {
            if animateLayer {
//                self.startAnimation()
                if textAnimtion {
                    isCallTextAnimation ? self.setTextColor() : self.setTextAnimation()

                } else {
                    self.startAnimation()
                }
                
            } else {
                if textAnimtion {
                    isCallTextAnimation ? self.stopTextAnimation() : print("hi")
                } else {
                    self.layer.removeAllAnimations()
                    self.clearLayer()
                }
                
//                self.layer.removeAllAnimations()
//                self.clearLayer()
                
            }
        }
    }
    
    public var wbButtonBlinkingAnimation: WBButtonBlinkingAnimation = .Line {
        didSet {
            switch wbButtonBlinkingAnimation {
            case .Line:
                self.setLineAnimation()
            case .Light:
                self.layer.backgroundColor = UIColor.whiteColor().CGColor
                self.setLightAnimation()
            case .Background:
                self.setBackgroundAnimation()
            case .LightBackground:
                self.setLightBackgroundAnimation()
            case .Text:
                self.textAnimtion = true
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
        
        self.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        
        self.backgroundColor = UIColor.clearColor()
//        self.layer.masksTosBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowColor = self.blingShadowColor.CGColor
        
        
        print(self.frame)
        self.wbView.userInteractionEnabled = false
//        self.wbView.backgroundColor = UIColor.blackColor()
        
        self.wbButtonBlinkingAnimation = .Text
        
        self.blingBackgroundColor = UIColor.yellowColor()
        
        self.clearLayer()
        
    }
    
    private func setLightShadow() {
        self.layer.shadowRadius = 3.0
    }
    
    private func setLightBackgroundShadow() {
        self.layer.shadowRadius = 7.0
    }
    
    private func setShadow() {
        switch wbButtonBlinkingAnimation {
        case .Light:
            self.setLightShadow()
        case .LightBackground:
            self.setLightBackgroundShadow()
        default:
            return
        }
    }
    
    private func clearLayer() {
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 0
        self.layer.shadowRadius = 0.0
    }
    
    private func clearTextColor() {
//        self.wbView.layer.mask = nil
//        self.frame = CGRectMake(100, 450, self.frame.width, self.frame.height)
    }
    
    private func setLineAnimation() {
        self.setBlingColor()
        self.setBlingWidth(0.0, toValue: 1.0)
    }
    
    private func stopTextAnimation() {
        self.wbView.layer.removeAnimationForKey("mask")
    }
    
    private func setTextAnimation() {
        isCallTextAnimation = true
        self.wbView.frame = self.frame
        self.wbView.backgroundColor = UIColor.blackColor()
        self.setTextColor()
        self.wbView.layer.mask = self.layer
        
        print(self.frame)
        self.wbView.layer.mask!.position = CGPointMake(self.frame.width / 2, self.frame.height / 2)
        print(self.frame)
    }
    
    private func setLightAnimation() {
        self.setBlingColor()
        self.setBlingShadow(0.0, toValue: 0.5)
        self.setBlingWidth(0.0, toValue: 0.6)
    }
    
    private func setBackgroundAnimation() {
        self.setBackgroundColor()
    }
    
    private func setLightBackgroundAnimation() {
        self.setBlingShadow(0.0, toValue: 1.0)
        self.setBackgroundColor()
    }
    
    private func setBackgroundColor() {
        blingBackgroundColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        blingBackgroundColorAnimation.fromValue = UIColor.clearColor().CGColor
        blingBackgroundColorAnimation.toValue = self.blingBackgroundColor.CGColor
        blingBackgroundColorAnimation.autoreverses = true
        self.layer.borderColor = self.blingBackgroundColor.CGColor
    }
    
    private func setTextColor() {
        blingTextColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        blingTextColorAnimation.duration = animationDuration
        blingTextColorAnimation.toValue = UIColor.blackColor().CGColor
        blingTextColorAnimation.fromValue = UIColor.clearColor().CGColor
        blingTextColorAnimation.autoreverses = true
        blingTextColorAnimation.repeatCount = 1e100
        self.wbView.layer.addAnimation(blingTextColorAnimation, forKey: "mask")
    }
    
    private func setBlingColor() {
        blingColor = CABasicAnimation(keyPath: "borderColor")
        blingColor.fromValue = UIColor.clearColor().CGColor
        blingColor.toValue = self.borderColor.CGColor
        self.layer.borderColor = self.borderColor.CGColor
    }
    
    private func resetBlingColor() {
        blingColor.fromValue = UIColor.clearColor().CGColor
        blingColor.toValue = self.borderColor.CGColor
    }
    
    private func resetBlingBackgroundColor() {
        blingBackgroundColorAnimation.fromValue = UIColor.clearColor().CGColor
        blingBackgroundColorAnimation.toValue = self.blingBackgroundColor.CGColor
    }
    
    private func setBlingShadow(fromValue: Float, toValue: Float) {
        blingShadow = CABasicAnimation(keyPath: "shadowOpacity")
        blingShadow.fromValue = fromValue
        blingShadow.toValue = toValue
        self.layer.shadowOpacity = toValue
    }
    
    private func setBlingWidth(fromValue: CGFloat, toValue: CGFloat) {
        blingWidth = CABasicAnimation(keyPath: "borderWidth")
        blingWidth.fromValue = fromValue
        blingWidth.toValue = toValue
        self.layer.borderWidth = toValue
    }
    
    private func startAnimation() {
        if !animateLayer {
            return
        }
        
        self.setShadow()
        
        let bothAnimation: CAAnimationGroup = CAAnimationGroup()
        bothAnimation.duration = self.animationDuration
        bothAnimation.animations = [blingColor, blingShadow, blingWidth, blingBackgroundColorAnimation, blingTextColorAnimation]
        bothAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bothAnimation.delegate = self
        bothAnimation.autoreverses = true
        bothAnimation.repeatCount = 1e100
        self.layer.addAnimation(bothAnimation, forKey: "color and width and shadow")
    }
}
