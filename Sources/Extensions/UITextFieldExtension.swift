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
    func addLeftIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize, imageTintColour:UIColor? = nil) {
        
        let leftView    = UIView()
        leftView.frame  = frame
        let imageView     = UIImageView()
        imageView.frame   = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        imageView.image   = image
        if let colour = imageTintColour {
            imageView.image = imageView.changeImageColor(color: colour)
        }
        leftView.addSubview(imageView)
        
        self.leftView   = leftView
        self.leftViewMode = UITextField.ViewMode.always
    }
    
    /**
     Adds an icon to the right side of the UITextField with customizable properties.
     
     - Parameters:
     - image: The UIImage to be used as the icon on the right side of the text field. Pass `nil` if no image is required.
     - frame: The CGRect defining the size and position of the right view container. This determines the overall space occupied by the right icon and its padding within the text field.
     - imageSize: The CGSize specifying the width and height of the icon image within the right view.
     - imageTintColour: An optional UIColor to tint the icon image. If `nil`, the image's original colors are used.
     - showKeyboardOnTap: A Boolean value indicating whether the keyboard should appear when the right icon is tapped. If `true`, the keyboard will show; if `false`, no keyboard will appear, and custom actions can be triggered instead. The default value is `true`.
     
     - Discussion:
     This method adds a UIButton to the right side of the text field, which can display an icon image. The button can either trigger the keyboard or perform a custom action when tapped, depending on the `showKeyboardOnTap` parameter. This is useful in scenarios where some text fields require immediate keyboard input while others do not.
     
     - Example:
     ```
     // Add an icon to a text field and show the keyboard when tapped
     textField.addRightIcon(dropDownArrow, frame: CGRect(x: 0, y: 0, width: 40, height: 40), imageSize: CGSize(width: 24, height: 24), imageTintColour: UIColor.blue, showKeyboardOnTap: true)
     
     // Add an icon to a text field without showing the keyboard when tapped
     otherTextField.addRightIcon(dropDownArrow, frame: CGRect(x: 0, y: 0, width: 40, height: 40), imageSize: CGSize(width: 24, height: 24), imageTintColour: UIColor.blue, showKeyboardOnTap: false)
     ```
     */
    func addRightIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize, imageTintColour: UIColor? = nil, showKeyboardOnTap: Bool = true) {
        let rightView = UIView(frame: frame)
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        
        if let image = image {
            if let colour = imageTintColour {
                let tintedImage = image.withRenderingMode(.alwaysTemplate)
                button.setImage(tintedImage, for: .normal)
                button.tintColor = colour
            } else {
                button.setImage(image, for: .normal)
            }
        }
        
        rightView.addSubview(button)
        self.rightView = rightView
        self.rightViewMode = .always
        
        if showKeyboardOnTap {
            button.addTarget(self, action: #selector(showKeyboard), for: .touchUpInside)
        }
    }
    
    @objc private func showKeyboard() {
        self.becomeFirstResponder()
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
