//
//  WBTextField.swift
//  layer-animate
//
//  Created by Shohei Yokoyama on 2015/10/09.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

public enum WBBlinkingAnimation {
    case Line
    case Light
}

public class WBTextField: UITextField {
    
    private var showBorder = Bool()
    
    private var fadeInShadow = CABasicAnimation()
    private var fadeOutShadow = CABasicAnimation()
    private var fadeInColor = CABasicAnimation()
    private var fadeOutColor = CABasicAnimation()
    private var fadeInWidth = CABasicAnimation()
    private var fadeOutWidth = CABasicAnimation()
    
    public var borderColor: UIColor = UIColor.WBColor.DeepOrange {
        didSet {
            self.layer.shadowColor = borderColor.CGColor
            self.resetColorAnimation()
        }
    }
    
    public var stopAnimationByTextEditing = true
    
    public var animateLayer = false {
        didSet {
            if animateLayer {
                self.appear()
            } else {
                self.showBorder = false
                self.layer.removeAllAnimations()
                self.clearBorder()
            }
        }
    }
    
    public var wbBlinkingAnimation: WBBlinkingAnimation = .Line {
        didSet {
            switch wbBlinkingAnimation {
            case .Line:
                self.setLineAnimation()
            case .Light:
                self.setLightAnimation()
            default:
                break
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
    
    private func clearBorder() {
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 0
    }
    
    private func setupLayer() {
        cornerRadius = 5.0
        self.layer.borderWidth = 0
        self.borderStyle = .RoundedRect
        self.wbBlinkingAnimation = .Light
        self.borderColor = UIColor.WBColor.DeepOrange
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 3.0
    }
    
    public func checkEmptyText() -> Bool {
        if self.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).isEmpty == true {
            animateLayer = true
            return false
        }
        
        return true
    }
 
    private func setLineAnimation() {
        self.setFadeInShadowAnimation(0.0, toValue: 0.0)
        self.setFadeOutShadowAnimation(0.0, toValue: 0.0)
        self.setFadeInWidthAnimation(0.0, toValue: 1.0)
        self.setFadeOutWidthAnimation(1.0, toValue: 0.0)
        self.setFadeInColorAnimation()
        self.setFadeOutColorAnimation()
    }
    
    private func setLightAnimation() {
        self.setFadeInShadowAnimation(0.0, toValue: 0.5)
        self.setFadeOutShadowAnimation(0.5, toValue: 0.0)
        self.setFadeInColorAnimation()
        self.setFadeOutColorAnimation()
        self.setFadeInWidthAnimation(0.0, toValue: 0.6)
        self.setFadeOutWidthAnimation(0.6, toValue: 0.0)
    }
    
    private func resetColorAnimation() {
        self.fadeInColor.fromValue = UIColor.clearColor().CGColor
        self.fadeInColor.toValue = self.borderColor.CGColor
        self.fadeOutColor.fromValue = self.borderColor.CGColor
        self.fadeOutColor.toValue = UIColor.clearColor().CGColor
    }
    
    private func setFadeInShadowAnimation(fromValue: Float, toValue: Float) {
        fadeInShadow = CABasicAnimation(keyPath: "shadowOpacity")
        fadeInShadow.fromValue = fromValue
        fadeInShadow.toValue = toValue
        self.layer.shadowOpacity = toValue
    }
    
    private func setFadeOutShadowAnimation(fromValue: Float, toValue: Float) {
        fadeOutShadow = CABasicAnimation(keyPath: "shadowOpacity")
        fadeOutShadow.fromValue = fromValue
        fadeOutShadow.toValue = toValue
        self.layer.shadowOpacity = toValue
    }
    
    private func setFadeInColorAnimation() {
        fadeInColor = CABasicAnimation(keyPath: "borderColor")
        fadeInColor.fromValue = UIColor.clearColor().CGColor
        fadeInColor.toValue = self.borderColor.CGColor
        self.layer.borderColor = self.borderColor.CGColor
    }
    
    private func setFadeOutColorAnimation() {
        fadeOutColor = CABasicAnimation(keyPath: "borderColor")
        fadeOutColor.fromValue = self.borderColor.CGColor
        fadeOutColor.toValue = UIColor.clearColor().CGColor
        self.layer.borderColor = UIColor.clearColor().CGColor
    }
    
    private func setFadeInWidthAnimation(fromValue: CGFloat, toValue: CGFloat) {
        fadeInWidth = CABasicAnimation(keyPath: "borderWidth")
        fadeInWidth.fromValue = fromValue
        fadeInWidth.toValue = toValue
        self.layer.borderWidth = toValue
    }
    
    private func setFadeOutWidthAnimation(fromValue: CGFloat, toValue: CGFloat) {
        fadeOutWidth = CABasicAnimation(keyPath: "borderWidth")
        fadeOutWidth.fromValue = fromValue
        fadeOutWidth.toValue = toValue
        self.layer.borderWidth = toValue
    }
    
    private func appear() {
        if !animateLayer {
            return
        }
        
        let groupAnimation: CAAnimationGroup = CAAnimationGroup()
        groupAnimation.duration = 1.5
        groupAnimation.animations = [fadeInShadow, fadeInColor, fadeInWidth]
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.delegate = self
        self.layer.addAnimation(groupAnimation, forKey: "shadow and color and width")
        showBorder = true
    }
    
    private func disappear() {
        if !animateLayer {
            return
        }
        
        let groupAnimation: CAAnimationGroup = CAAnimationGroup()
        groupAnimation.duration = 1.5
        groupAnimation.animations = [fadeOutShadow, fadeOutColor, fadeOutWidth]
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.delegate = self
        self.layer.addAnimation(groupAnimation, forKey: "shadow and color and width")
        showBorder = false
    }
    
    override public func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if !flag {
            return
        }
        
        if showBorder {
            self.disappear()
        } else {
            self.appear()
        }
    }
    
    override public func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        if stopAnimationByTextEditing && animateLayer {
            self.animateLayer = false
        }
        
        return super.beginTrackingWithTouch(touch, withEvent: event)
    }
}
