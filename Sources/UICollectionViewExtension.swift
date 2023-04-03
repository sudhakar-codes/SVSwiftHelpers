//
//  UICollectionViewExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 06/05/21.
//

import Foundation

public extension UICollectionView {
    
    
    /// Adds Label with text in centre of table view
    /// - Parameters:
    ///   - message: shows in empty tableview
    ///   - textColour: default color `lightGray`, can be overridden.
    func setEmptyMessage(_ message: String?, textColour:UIColor = .gray) {
        
        let messageLabel    = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text   = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textColor     = textColour
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
    }
    
    /// Add empty collection view cell.
    /// - Parameters:
    ///   - collectionView:
    ///   - indexPath: at indexPath
    ///   - reuseIdentifier: default identifier is "default", Can override
    /// - Returns: UICollectionViewCell
    func emptyCollectionViewCell(at indexPath:IndexPath, reuseIdentifier:String = "default") -> UICollectionViewCell {
        return self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    }
    
    /// Register collection view cell to class
    /// - Parameter reuseIdentifier: default identifier is "default", Can override
    func registerEmptyCollectionViewCell(_ reuseIdentifier:String = "default") {
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

//MARK: - UICollectionViewCell

public extension UICollectionViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self.self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    
    func animateCVCell(completion : (() -> Void)?) {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            } completion: { _ in
                completion?()
            }
        })
    }
    
}
