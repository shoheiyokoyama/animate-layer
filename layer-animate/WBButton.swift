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
    case Text
}

public class WBButton: UIButton {

    private let textLayer = CATextLayer()
    
    public var buttonColor: UIColor = UIColor.clearColor() {
        didSet {
            self.backgroundColor = UIColor.clearColor()
            self.wbLayer.backgroundColor = buttonColor
        }
    }
    
    public var wbButtonBlinkingAnimation: WBButtonBlinkingAnimation = .Line {
        didSet {
            switch wbButtonBlinkingAnimation {
            case .Line:
                return
            case .Light:
                return
            case .Background:
                return
            case .Text:
                return
            }
        }
    }
    
    public var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    public lazy var wbLayer: WBLayer = WBLayer(superLayer: self.layer)
    
    override public func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle(title, forState: state)
        self.setTitleColor(UIColor.clearColor(), forState: state)
        self.setTextLayerToSelfLayer()
    }
    
    override public func setTitleColor(color: UIColor?, forState state: UIControlState) {
        super.setTitleColor(UIColor.clearColor(), forState: state)
        self.textLayer.foregroundColor = color?.CGColor
        self.wbLayer.textColor = color!
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
        self.wbLayer.textColor = UIColor.blackColor()
        
        self.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
        
        self.wbLayer.wbLayerAnimation = .Border
    }
    
    private func setTextLayerToSelfLayer() {
        let font = UIFont.systemFontOfSize(17.0) //default
        let text = self.currentTitle
        
        var attributes = [String: AnyObject]()
        attributes[NSFontAttributeName] = font
        let size = text!.sizeWithAttributes(attributes)
        
        let x = (CGRectGetWidth(self.frame) - size.width) / 2
        let y = (CGRectGetHeight(self.frame) - size.height) / 2
        let height = size.height + self.layer.borderWidth
        let width = size.width
        let frame = CGRectMake(x, y, width, height)
        
        textLayer.font = self.titleLabel?.font
        textLayer.string = text
        textLayer.fontSize = font.pointSize
        
        textLayer.foregroundColor = UIColor.blackColor().CGColor
        textLayer.contentsScale = UIScreen.mainScreen().scale
        
        textLayer.frame = frame
        textLayer.alignmentMode = kCAAlignmentCenter
        
        self.wbLayer.setTextLayer(textLayer)
    }
    
    public func startAnimation() {
        self.wbLayer.startAnimation()
    }
    
    public func stopAnimation() {
        self.wbLayer.stopAnimation()
    }
}
