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
    
    public var borderColor: UIColor = UIColor.WBColor.DeepOrange {
        didSet {
            self.layer.shadowColor = borderColor.CGColor
        }
    }
    
    public var blingBackgroundColor = UIColor.WBColor.DeepOrange
    
    public var animationDuration: CFTimeInterval = 3.0
    
    public var animateLayer = false {
        didSet {
            if animateLayer {
                self.startAnimation()
            } else {
                self.layer.removeAllAnimations()
                self.clearLayer()
                
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
                self.setTextAnimation()
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
        self.wbButtonBlinkingAnimation = .Text
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        self.clearLayer()
        
        self.borderColor = UIColor.WBColor.DeepOrange
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
    
    private func setLineAnimation() {
        self.setBlingColor()
        self.setBlingWidth(0.0, toValue: 1.0)
    }
    
    private func setTextAnimation() {
        
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
        
    }
    
    private func setBlingColor() {
        blingColor = CABasicAnimation(keyPath: "borderColor")
        blingColor.fromValue = UIColor.clearColor().CGColor
        blingColor.toValue = self.borderColor.CGColor
        self.layer.borderColor = self.borderColor.CGColor
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
        bothAnimation.duration = self.animationDuration / 2
        bothAnimation.animations = [blingColor, blingShadow, blingWidth, blingBackgroundColorAnimation]
        bothAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bothAnimation.delegate = self
        bothAnimation.autoreverses = true
        bothAnimation.repeatCount = 1e100
        self.layer.addAnimation(bothAnimation, forKey: "color and width and shadow")
    }
}
