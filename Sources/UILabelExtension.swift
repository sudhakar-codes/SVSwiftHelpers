//
//  UILabelExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 02/05/21.
//

import Foundation

public extension UILabel {
    
    /// Initialize Label with a font, color and alignment.
    convenience init(font: UIFont, color: UIColor, alignment: NSTextAlignment) {
        self.init()
        self.font = font
        self.textColor = color
        self.textAlignment = alignment
    }

    ///
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, fontSize: CGFloat = 17) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        font = UIFont.Font(name: .Helvetica, type: .Regular, size: fontSize)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        textAlignment = NSTextAlignment.left
        isUserInteractionEnabled = true
        numberOfLines = 1
    }
    
    /// Add image to label at end of string
    func set(image: UIImage, with text: String) {
        
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: -2.5, width: 15, height: 15)
        let attachmentStr = NSAttributedString(attachment: attachment)
        
        let mutableAttributedString = NSMutableAttributedString()
        
        mutableAttributedString.append(NSAttributedString(string: text))
        mutableAttributedString.append(attachmentStr)
        
        self.attributedText = mutableAttributedString
    }
    
    /// Add space between each line of label
    /// - Parameter spacingValue: default is 2, Can override
    func addInterlineSpacing(spacingValue: CGFloat = 2) {

        guard let textString = text else { return }
        
        let attributedString = NSMutableAttributedString(string: textString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacingValue
        attributedString.addAttribute(.paragraphStyle,value: paragraphStyle,range: NSRange(location: 0, length: attributedString.length ))
        attributedText = attributedString
    }
}
