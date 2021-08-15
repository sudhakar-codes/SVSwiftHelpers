//
//  UITextFieldExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 02/05/21.
//

import Foundation

public extension UITextField {
    
    ///  Automatically sets these values: backgroundColor = clearColor, textColor = ThemeNicknameColor, clipsToBounds = true,
    /// textAlignment = Left, userInteractionEnabled = true, editable = false, scrollEnabled = false, font = ThemeFontName
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, fontSize: CGFloat = 17) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        font = UIFont.Font(name: .HelveticaNeue, type: .Regular, size: fontSize)
        backgroundColor = UIColor.clear
        clipsToBounds = true
        textAlignment = NSTextAlignment.left
        isUserInteractionEnabled = true
    }
    
    /// Add left padding to the text in textfield
    func addLeftTextPadding(_ blankSize: CGFloat) {
        
        let leftView    = UIView()
        leftView.frame  = CGRect(x: 0, y: 0, width: blankSize, height: frame.height)
        self.leftView   = leftView
        self.leftViewMode = .always
    }
    
    /// Add a image icon on the left side of the textfield
    func addLeftIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize) {
        
        let leftView    = UIView()
        leftView.frame  = frame
        let imgView     = UIImageView()
        imgView.frame   = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        imgView.image   = image
        leftView.addSubview(imgView)
        
        self.leftView   = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    /// Add a image icon on the right side of the textfield
    func addRightIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize) {
        
        let rightView    = UIView()
        rightView.frame  = frame
        let imgView     = UIImageView()
        imgView.frame   = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        imgView.image   = image
        rightView.addSubview(imgView)
        
        self.rightView  = rightView
        self.rightViewMode = UITextField.ViewMode.always
    }
    
    /// Password toggle
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(named: "ic_visibility", in: Bundle(identifier: "org.cocoapods.SVSwiftHelpers"), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
        }else{
            button.setImage(UIImage(named: "ic_visibility_off", in: Bundle(identifier: "org.cocoapods.SVSwiftHelpers"), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    /// Adds button to textfield on right side which can toggle textfield text to secure text
    func enablePasswordToggle(){
        
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
