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

public enum WBBorderStyle {
    case RoundedRect
    case None
}

public class WBTextField: UITextField {
    
    private var showBorder = Bool()
    
    private var fadeInShadow = CABasicAnimation()
    private var fadeInColor = CABasicAnimation()
    private var fadeInWidth = CABasicAnimation()
    
    public var borderColor: UIColor = UIColor.WBColor.DeepOrange {
        didSet {
            self.layer.shadowColor = borderColor.CGColor
            self.resetColorAnimation()
        }
    }
    
    public var animationDuration: CFTimeInterval = 3.0 {
        didSet {
            
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
                self.clearShadow()
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
            }
            
        }
    }
    
    public var wbBorderStyle: WBBorderStyle = .RoundedRect {
        didSet {
            switch wbBorderStyle {
            case .RoundedRect:
                self.borderStyle = .RoundedRect
            case .None:
                self.layer.backgroundColor = UIColor.whiteColor().CGColor
                self.borderStyle = .None
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
    
    private func clearShadow() {
        self.layer.shadowRadius = 0.0
    }
    
    private func setupLayer() {
        cornerRadius = 5.0
        
        self.wbBorderStyle = .None
        
        self.layer.borderWidth = 0
        
        self.wbBlinkingAnimation = .Light
        self.borderColor = UIColor.WBColor.DeepOrange
        self.animationDuration = 3.0
        
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        
        self.clearShadow()
        self.clearBorder()
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
        self.setFadeInWidthAnimation(0.0, toValue: 1.0)
        self.setFadeInColorAnimation()
    }
    
    private func setLightAnimation() {
        self.setFadeInShadowAnimation(0.0, toValue: 0.5)
        self.setFadeInColorAnimation()
        self.setFadeInWidthAnimation(0.0, toValue: 0.6)
    }
    
    private func resetColorAnimation() {
        self.fadeInColor.fromValue = UIColor.clearColor().CGColor
        self.fadeInColor.toValue = self.borderColor.CGColor
    }
    
    private func setFadeInShadowAnimation(fromValue: Float, toValue: Float) {
        fadeInShadow = CABasicAnimation(keyPath: "shadowOpacity")
        fadeInShadow.fromValue = fromValue
        fadeInShadow.toValue = toValue
        fadeInShadow.autoreverses = true
        self.layer.shadowOpacity = toValue
    }
    
    private func setFadeInColorAnimation() {
        fadeInColor = CABasicAnimation(keyPath: "borderColor")
        fadeInColor.fromValue = UIColor.clearColor().CGColor
        fadeInColor.toValue = self.borderColor.CGColor
        fadeInColor.autoreverses = true
        self.layer.borderColor = self.borderColor.CGColor
    }
    
    private func setFadeInWidthAnimation(fromValue: CGFloat, toValue: CGFloat) {
        fadeInWidth = CABasicAnimation(keyPath: "borderWidth")
        fadeInWidth.fromValue = fromValue
        fadeInWidth.toValue = toValue
        fadeInWidth.autoreverses = true
        self.layer.borderWidth = toValue
    }
    
    private func appear() {
        if !animateLayer {
            return
        }
        
        self.layer.shadowRadius = 3.0
        
        let groupAnimation: CAAnimationGroup = CAAnimationGroup()
        groupAnimation.duration = self.animationDuration / 2
        groupAnimation.animations = [fadeInShadow, fadeInColor, fadeInWidth]
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        groupAnimation.delegate = self
        groupAnimation.autoreverses = true
        groupAnimation.repeatCount = 5
        self.layer.addAnimation(groupAnimation, forKey: "shadow and color and width")
        showBorder = true
    }
    
    override public func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        if stopAnimationByTextEditing && animateLayer {
            self.animateLayer = false
        }
        
        return super.beginTrackingWithTouch(touch, withEvent: event)
    }
}
