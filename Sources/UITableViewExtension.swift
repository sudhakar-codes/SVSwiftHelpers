//
//  UITableViewExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 06/05/21.
//

import Foundation

public extension UITableView {
    
    func registerTableViewCells(_ classNames: [AnyClass?]) {
        for className in classNames {
            register(UINib(nibName: "\(className!)", bundle: nil), forCellReuseIdentifier: "\(className!)")
        }
    }
    func dequeueTableViewCell<T: UITableViewCell>(indexPath: IndexPath, osVersion: String? = nil) -> T {
        let className = String(describing: T.self) + "\(osVersion ?? "")"
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    /// Adds Label with text in centre of table view
    /// - Parameters:
    ///   - message: shows in empty tableview
    ///   - textColour: default color `lightGray`, can be overridden.
    func setEmptyMessage(_ message: String?, textColour:UIColor = .lightGray) {
    
        let messageLabel    = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text   = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textColor     = textColour
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
}

public extension UITableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self.self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
}
