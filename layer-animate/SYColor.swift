//
//  SYColor.swift
//  layer-animate
//
//  Created by Shohei Yokoyama on 2015/10/29.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

public class SYColor: UIColor {
    convenience public init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    public static let Red = UIColor(hex: 0xF44336)
    public static let Pink = UIColor(hex: 0xE91E63)
    public static let Purple = UIColor(hex: 0x9C27B0)
    public static let DeepPurple = UIColor(hex: 0x67AB7)
    public static let Indigo = UIColor(hex: 0x3F51B5)
    public static let Blue = UIColor(hex: 0x2196F3)
    static let LightBlue = UIColor(hex: 0x03A9F4)
    static let Cyan = UIColor(hex: 0x00BCD4)
    static let Teal = UIColor(hex: 0x009688)
    static let Green = UIColor(hex: 0x4CAF50)
    static let LightGreen = UIColor(hex: 0x8BC34A)
    static let Lime = UIColor(hex: 0xCDDC39)
    static let Yellow = UIColor(hex: 0xFFEB3B)
    static let Amber = UIColor(hex: 0xFFC107)
    static let Orange = UIColor(hex: 0xFF9800)
    static let DeepOrange = UIColor(hex: 0xFF5722)
    static let Brown = UIColor(hex: 0x795548)
    static let Grey = UIColor(hex: 0x9E9E9E)
    static let BlueGrey = UIColor(hex: 0x607D8B)
    
    // http://www.flatuicolorpicker.com/new
    public static let ChestnutRose = UIColor(hex: 0xD24D57)
    
    
}
