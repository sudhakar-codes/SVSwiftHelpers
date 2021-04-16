//
//  ColourExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 08/04/21.
//

import Foundation

public extension UIColor {
    
    /// Returns random color
    class var randomColour:UIColor {
        return UIColor(r: (CGFloat)(arc4random_uniform(255)),
                       g: (CGFloat)(arc4random_uniform(255)),
                       b: (CGFloat)(arc4random_uniform(255)), a: CGFloat(0.7))
    }

    /// Sets color with RGB value. default alpha value is '1', but this can be overridden.
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a:CGFloat = 1) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha:a)
    }
    
    /// Sets Colour with HEX color code. default alpha value is '1', but this can be overridden.
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return nil
        }
    }
    
}
