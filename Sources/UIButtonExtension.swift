//
//  UIButtonExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 02/05/21.
//

import Foundation

public extension UIButton {
    
    /// Add `UIButton` with frame and action
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, target: AnyObject, action: Selector) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
    override var isEnabled: Bool{
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
    
    var title: String? {
        get { return self.title(for: .normal) }
        set { setTitle(newValue, for: .normal) }
    }
    
    var titleFont: UIFont? {
        get { return titleLabel?.font }
        set { titleLabel?.font = newValue }
    }
    
    var attributedTitle: NSAttributedString? {
        get { return self.attributedTitle(for: .normal) }
        set { setAttributedTitle(newValue, for: .normal) }
    }
    
    var titleColor: UIColor? {
        get { return self.titleColor(for: .normal) }
        set {
            setTitleColor(newValue, for: .normal)
            setTitleColor(newValue?.withAlphaComponent(0.5), for: .disabled)
            setTitleColor(newValue, for: .selected)
            if buttonType == .custom {
                setTitleColor(newValue?.withAlphaComponent(0.5), for: .highlighted)
            }
        }
    }
    
    var titleShadowColor: UIColor? {
        get { return self.titleShadowColor(for: .normal) }
        set {
            setTitleShadowColor(newValue, for: .normal)
            setTitleShadowColor(newValue?.withAlphaComponent(0.5), for: .disabled)
            setTitleShadowColor(newValue, for: .selected)
        }
    }
    
    var image: UIImage? {
        get { return self.image(for: .normal) }
        set {
            setImage(newValue, for: .normal)
        }
    }
    
    var selectedImage: UIImage? {
        get { return self.image(for: .selected) }
        set { setImage(newValue?.withRenderingMode(.alwaysOriginal), for: .selected) }
    }
    
    var selectedBackgroundImage: UIImage? {
        get { return self.backgroundImage(for: .selected) }
        set { setBackgroundImage(newValue?.withRenderingMode(.alwaysOriginal), for: .selected) }
    }
    
    var disabledBackgroundImage: UIImage? {
        get { return self.backgroundImage(for: .disabled) }
        set { setBackgroundImage(newValue?.withRenderingMode(.alwaysOriginal), for: .disabled) }
    }
    
}
