//
//  UIImageViewExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 02/05/21.
//

import Foundation

public extension UIImageView {
    
    /// Convenience init that takes coordinates of bottom left corner, height width and image name.
    convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, imageName: String? = nil) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
        if let name = imageName {
            self.image = UIImage(named: name)
        }
    }

    /// Convenience init that takes coordinates of bottom left corner, image name and scales image frame to width.
    convenience init(x: CGFloat, y: CGFloat, imageName: String, scaleToWidth: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: 0, height: 0))
        image = UIImage(named: imageName)
        if image != nil {
            scaleImageFrameToWidth(width: scaleToWidth)
        } else {
            assertionFailure("The imageName: '\(imageName)' is invalid!!!")
        }
    }
    /// Scales this ImageView size to fit the given width
    func scaleImageFrameToWidth(width: CGFloat) {
        guard let image = image else {
            print("The image is not set yet!")
            return
        }
        let widthRatio = image.size.width / width
        let newWidth = image.size.width / widthRatio
        let newHeight = image.size.height / widthRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeight)
    }
    /// Scales this ImageView size to fit the given height
    func scaleImageFrameToHeight(height: CGFloat) {
        guard let image = image else {
            print("The image is not set yet!")
            return
        }
        let heightRatio = image.size.height / height
        let newHeight = image.size.height / heightRatio
        let newWidth = image.size.width / heightRatio
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newWidth, height: newHeight)
    }
    
    /// Change image tint colour
    func changeImageColor( color:UIColor) -> UIImage {
        
        image = image!.withRenderingMode(.alwaysTemplate)
        tintColor = color
        return image!
    }
}
