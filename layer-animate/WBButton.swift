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
        }
    }
    
    public var blingBackgroundColor = UIColor.WBColor.DeepOrange {
        didSet {
//            self.layer.shadowColor = blingBackgroundColor.CGColor
//            self.resetBlingBackgroundColor()
        }
    }
    
    public var blingShadowColor = UIColor.WBColor.DeepOrange {
        didSet {
            self.layer.shadowColor = blingShadowColor.CGColor
        }
    }
    
//    public var backgroundColor = UIColor.clearColor() {
//        didSet {
//            
//        }
//    }
    
    public var blingTextColor = UIColor.WBColor.Brown
    
    public var animationDuration: CFTimeInterval = 3.0
    
    public var wbView: UIView = UIView()
    
    public var textAnimtion = false
    private var isCallTextAnimation = false
    
    public var animateLayer = false {
        didSet {
            if animateLayer {
                if textAnimtion {
                    isCallTextAnimation ? self.setTextColor() : self.setTextAnimation()

                } else {
                    self.startAnimation()
                }
                
            } else {
                if textAnimtion {
                    isCallTextAnimation ? self.stopTextAnimation() : print("hi")
                } else {
//                    self.layer.removeAllAnimations()
//                    self.clearLayer()
                    self.wbLayer.stopAnimation()
                }
                
            }
        }
    }
    
    public var wbButtonBlinkingAnimation: WBButtonBlinkingAnimation = .Line {
        didSet {
            switch wbButtonBlinkingAnimation {
            case .Line:
//                self.setLineAnimation()
                return
            case .Light:
                self.layer.backgroundColor = UIColor.whiteColor().CGColor
//                self.setLightAnimation()
            case .Background:
                return
//                self.setBackgroundAnimation()
            case .LightBackground:
                return
//                self.setLightBackgroundAnimation()
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
    
    public lazy var wbLayer: WBLayer = WBLayer(superLayer: self.layer)
    
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
        
//        self.backgroundColor = UIColor.clearColor()
//        self.layer.masksTosBounds = false
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        self.layer.shadowColor = self.blingShadowColor.CGColor
        
        
        self.wbView.userInteractionEnabled = false
//        self.wbView.backgroundColor = UIColor.blackColor()
        
        self.wbLayer.wbLayerAnimation = .Background
        self.backgroundColor = UIColor.whiteColor() // for LineLight
        
//        self.blingBackgroundColor = UIColor.yellowColor()
        
//        self.clearLayer()
        
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
    
    private func stopTextAnimation() {
//        self.wbView.layer.removeAnimationForKey("mask")
    }
    
    private func setTextAnimation() {
//        isCallTextAnimation = true
//        self.wbView.frame = self.frame
//        self.wbView.backgroundColor = UIColor.blackColor()
//        self.setTextColor()
//        self.wbView.layer.mask = self.layer
//        
//        print(self.frame)
//        self.wbView.layer.mask!.position = CGPointMake(self.frame.width / 2, self.frame.height / 2)
//        print(self.frame)
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
    
    private func resetBlingColor() {
        blingColor.fromValue = UIColor.clearColor().CGColor
        blingColor.toValue = self.borderColor.CGColor
    }
    
    private func resetBlingBackgroundColor() {
        blingBackgroundColorAnimation.fromValue = UIColor.clearColor().CGColor
        blingBackgroundColorAnimation.toValue = self.blingBackgroundColor.CGColor
    }

    
    public func startAnimation() {
        self.clearButton() // for LightBorder
        self.wbLayer.startAnimation()
    }
    
    public func stopAnimation() {
        self.wbLayer.stopAnimation()
    }
    
    private func clearButton() {
        switch wbLayer.wbLayerAnimation {
        case .Border :
            self.backgroundColor = UIColor.clearColor()
        case .LightBorder:
            self.backgroundColor = UIColor.whiteColor()
        default :
            return
        }
    }
    
    
}
