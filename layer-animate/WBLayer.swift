//
//  WBLayer.swift
//  layer-animate
//
//  Created by Shohei Yokoyama on 2015/10/22.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

public enum WBLayerAnimation {
    case Border
    case LightBorder
    case Background
    case Text
}

public class WBLayer {
    private var superLayer: CALayer!
    
    private var borderColorAnimtion = CABasicAnimation()
    private var borderWidthAnimation = CABasicAnimation()
    private var backgroundColorAnimation = CABasicAnimation()
    private var shadowAnimation = CABasicAnimation()
    
    public var animationBorderColor = UIColor.WBColor.Cyan
    public var animationBackgroundColor = UIColor.WBColor.Cyan
    public var animationShadowColor = UIColor.WBColor.Cyan
    public var animationDuration = 1.4
    
    public var borderWidth: CGFloat = 0.0 {
        didSet {
            self.superLayer.borderWidth = borderWidth
        }
    }
    
    public var borderColor = UIColor.clearColor() {
        didSet {
            self.superLayer.borderColor = borderColor.CGColor
        }
    }
    
    public var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.superLayer.shadowRadius = self.shadowRadius
        }
    }
    
    public var shadowOpacity: Float = 0.0 {
        didSet {
            self.superLayer.shadowOpacity = self.shadowOpacity
        }
    }
    
    public var shadowOffset: CGSize = CGSize(width: 0.0, height: 0.0) {
        didSet {
           self.superLayer.shadowOffset = self.shadowOffset
        }
    }
    
    public init(superLayer: CALayer) {
        self.superLayer = superLayer
        self.setLayer()
    }
    
    private func setLayer() {
        self.superLayer.shadowColor = self.animationShadowColor.CGColor
        
        self.superLayer.borderWidth = self.borderWidth
        self.superLayer.borderColor = self.borderColor.CGColor
        
        self.clearSupeLayerBorder()
        self.clearSuperLayerShadow()
    }
    
    private func resetSupeLayerBorder() {
        self.superLayer.borderColor = borderColor.CGColor
        self.superLayer.borderWidth = borderWidth
    }
    
    private func clearSupeLayerBorder() {
        self.superLayer.borderColor = UIColor.clearColor().CGColor
        self.superLayer.borderWidth = 0
    }
    
    private func resetSupeLayerShadow() {
        self.superLayer.shadowRadius = self.shadowRadius
        self.superLayer.shadowOpacity = self.shadowOpacity
        self.superLayer.shadowOffset = self.shadowOffset
    }
    
    private func clearSuperLayerShadow() {
        self.superLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.superLayer.shadowRadius = 0.0
        self.superLayer.shadowOpacity = 0.0
    }
    
    public var wbLayerAnimation: WBLayerAnimation = .Border {
        didSet {
            switch wbLayerAnimation {
            case .Border:
                self.setBorderAnimation()
            case .LightBorder:
                self.setLightBorderAnimation()
            case .Background:
                self.setBackgroundAnimation()
            case .Text:
               self.setTextAnimation()
            }
        }
    }
    
    private func setBorderAnimation() {
        self.setBorderColorAnimation()
        self.setborderWidthAnimation(0.0, toValue: 0.7)
    }
    
    private func setLightBorderAnimation() {
        self.setBorderColorAnimation()
        self.setShadowAnimation(0.0, toValue: 0.5)
        self.setborderWidthAnimation(0.0, toValue: 0.6)
    }
    
    private func setBackgroundAnimation() {
        self.setBackgroundColorAnimation()
    }
    
    private func setTextAnimation() {
        
    }
    
    private func setBorderColorAnimation() {
        borderColorAnimtion = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimtion.fromValue = self.superLayer.borderColor
        borderColorAnimtion.toValue = self.animationBorderColor.CGColor
        self.superLayer.borderColor = self.animationBorderColor.CGColor
    }
    
    private func setborderWidthAnimation(fromValue: CGFloat, toValue: CGFloat) {
        borderWidthAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = fromValue
        borderWidthAnimation.toValue = toValue
        self.superLayer.borderWidth = toValue
    }
    
    private func setBackgroundColorAnimation() {
        backgroundColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        backgroundColorAnimation.fromValue = UIColor.clearColor().CGColor
        backgroundColorAnimation.toValue = self.animationBackgroundColor.CGColor
        backgroundColorAnimation.duration = self.animationDuration
        backgroundColorAnimation.autoreverses = true
        backgroundColorAnimation.repeatCount = 1e100
        self.superLayer.backgroundColor = self.animationBackgroundColor.CGColor
    }
    
    private func setShadowAnimation(fromValue: Float, toValue: Float) {
        shadowAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnimation.fromValue = fromValue
        shadowAnimation.toValue = toValue
        self.superLayer.shadowOpacity = toValue
    }
    
    public func startAnimation() {
        switch wbLayerAnimation {
        case .Border:
            self.animateBorderOrLightBorder()
        case .LightBorder:
            self.animateBorderOrLightBorder()
        case .Background:
            self.animateBackground()
        case .Text:
            self.animateText()
        }
    }
    
    private func animateBorderOrLightBorder() {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = self.animationDuration
        groupAnimation.animations = [borderColorAnimtion, borderWidthAnimation]
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        groupAnimation.delegate = self
        groupAnimation.autoreverses = true
        groupAnimation.repeatCount = 1e100
        wbLayerAnimation == .LightBorder ? self.animateLightBorder(groupAnimation) : self.superLayer.addAnimation(groupAnimation, forKey: "Border")
    }
    
    private func animateLightBorder(groupAnimation: CAAnimationGroup) {
        self.superLayer.shadowRadius = 5.0
        groupAnimation.animations?.append(shadowAnimation)
        self.superLayer.addAnimation(groupAnimation, forKey: "LightBorder")
    }
    
    private func animateBackground() {
        self.clearSupeLayerBorder()
        self.clearSuperLayerShadow()
        self.superLayer.addAnimation(backgroundColorAnimation, forKey: "Background")
    }
    
    private func animateText() {
        
    }
    
    public func stopAnimation() {
        self.superLayer.removeAllAnimations()
        self.resetSupeLayerBorder()
        self.resetSupeLayerShadow()
    }

}
