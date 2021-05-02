//
//  UIFontExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 02/05/21.
//

import Foundation

public enum CustomFontType :String {
    
    case Light      = "Light"
    case Regular    = "Regular"
    case SemiBold   = "SemiBold"
    case Bold       = "Bold"
}

public enum FontType :String {
    
    case Light      = "Light"
    case Regular    = "Regular"
    case SemiBold   = "SemiBold"
    case Bold       = "Bold"
    
    case UltraLight = "UltraLight"
    case Thin       = "Thin"
    case Medium     = "Medium"
    case DemiBold   = "DemiBold"
    case Heavy      = "Heavy"
    case Italic     = "Italic"
    case MediumItalic = "MediumItalic"
    case BoldItalic   = "BoldItalic"
    case CondensedMedium = "CondensedMedium"
    case CondensedExtraBold = "CondensedExtraBold"
    case Book       = "Book"
    case Roman      = "Roman"
    
}
public enum FontName : String {
    
    case HelveticaNeue
    case Helvetica
    case Futura
    case Menlo
    case Avenir
    case AvenirNext
    case Didot
    case AmericanTypewriter
    case Baskerville
    case Geneva
    case GillSans
    case SanFranciscoDisplay
    case Seravek
}

public extension UIFont {
    
    
    /// Returns `UIFont`
    /// - Parameters:
    ///   - name: name of font can select from enum
    ///   - type: type of font
    ///   - size: size of font
    /// - Returns:
    static func Font(name: FontName, type: FontType,  size: CGFloat) -> UIFont {
        
        let fontName = name.rawValue + "-" + type.rawValue
        
        guard let font = UIFont(name: fontName, size: size) else {
            return self.systemFont(ofSize: size)
        }
        return font
    }
    
    /// Returns `UIFont`
    /// - Warning : Add Custom font to project.
    /// - Parameters:
    ///   - name: name of font can select from enum
    ///   - type: type of font
    ///   - size: size of font
    /// - Returns:
    static func customFont(name: String, type: CustomFontType,  size: CGFloat) -> UIFont {
        
        let fontName = name + "-" + type.rawValue
        
        guard let font = UIFont(name: fontName, size: size) else {
            return self.systemFont(ofSize: size)
        }
        return font
    }
    
    /// Custom font in Library is `OpenSans`
    /// - Warning:Add `OpenSans` Font to your project
    /// - Parameter size: size of font
    /// - Returns: openSans `Light` font size
    static func openSansFontLight(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "OpenSans", type: .Light, size: size)
    }
    
    /// Custom font in Library is `OpenSans`
    /// - Warning:Add `OpenSans` Font to your project
    /// - Parameter size: size of font
    /// - Returns: openSans `Regular` font size
    static func openSansFontRegular(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "OpenSans", type: .Regular, size: size)
    }
    
    /// Custom font in Library is `OpenSans`
    /// - Warning:Add `OpenSans` Font to your project
    /// - Parameter size: size of font
    /// - Returns: openSans `SemiBold` font size
    static func openSansFontSemiBold(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "OpenSans", type: .SemiBold, size: size)
    }
    
    /// Custom font in Library is `OpenSans`
    /// - Warning:Add `OpenSans` Font to your project
    /// - Parameter size: size of font
    /// - Returns: openSans `Bold` font size
    static func openSansFontBold(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "OpenSans", type: .Bold, size: size)
    }
}
