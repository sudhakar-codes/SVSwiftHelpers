//
//  UIViewControllerExtensions.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 08/04/21.
//

import Foundation
import SafariServices

public extension UIViewController {
    
    //MARK: - Alert

    /// Show alert
    func showAlert(_ title: String?, _ message:String?,_ buttonTitle:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { (action: UIAlertAction) in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    /// Shows Alert/Action sheet with multiple buttons
    /// - Warning: If App deployment target is universal, send value in `sender` parameter else action sheet will show in center of screen
    func showAlertMoreThanOneButton(_ title: String?, _ message: String?, style:UIAlertController.Style, sender:UIView? = nil, actions:UIAlertAction...){
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions{
            alert.addAction(action)
        }
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = sender == nil ? CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) : sender!.frame
        }
        present(alert, animated: true, completion: nil)
    }
    /// Adds actions to alert/action sheet
    func action(_ title: String, preferredStyle:UIAlertAction.Style, action:@escaping (_ alertAction: UIAlertAction) -> Void) -> UIAlertAction{
        let btnAction = UIAlertAction(title: title, style:preferredStyle, handler:action)
        return btnAction
    }
    
    //MARK:- BarButtonItem
    
    /// Adds left bar button
    var leftBarButton:UIBarButtonItem {
        let barButton = UIBarButtonItem(image: UIImage(named: "round_arrow_back_ios_white_24pt", in: Bundle(identifier: "org.cocoapods.SVSwiftHelpers"), compatibleWith: nil)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonAction))
        return barButton
    }
    
    // MARK: - VC Container
    
    /// Returns Tab Bar's height
    var tabBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.tabBarHeight
        }
        if let tab = self.tabBarController {
            return tab.tabBar.frame.size.height
        }
        return 0
    }
    
    /// Returns Navigation Bar's height
    var navigationBarHeight: CGFloat {
        if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
            return visibleViewController.navigationBarHeight
        }
        if let nav = self.navigationController {
            return nav.navigationBar.frame.size.height
        }
        return 0
    }
    
    /// Returns Navigation Bar's color
    var navigationBarColor: UIColor? {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.navigationBarColor
            }
            return navigationController?.navigationBar.tintColor
        } set(value) {
            navigationController?.navigationBar.barTintColor = value
        }
    }
    
    /// Shows Title and sub title on navigation bar with single line. Title shows bigger than subtile
    /// - Parameters:
    ///   - title: Dynamic title
    ///   - subTitle: Dynamic sub title
    ///   - textColor: default text color is white, but this can be overridden.
    ///   - titleFont: default font system bold 16, but this can be overridden.
    func navigationTitleView(withTitle title: String?, subTitle: String?, textColor:UIColor = .white, titleFont:UIFont = UIFont.boldSystemFont(ofSize: 16)){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -5, width: 250, height: 20))
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor       = textColor
        titleLabel.textAlignment   = .left
        titleLabel.font            = titleFont
        titleLabel.text            = title
        titleLabel.numberOfLines   = 1
        
        let subTitleLabel = UILabel(frame: CGRect(x: 0, y: 15, width: 240, height: 20))
        subTitleLabel.backgroundColor = UIColor.clear
        subTitleLabel.textColor       = textColor
        subTitleLabel.font            = UIFont.systemFont(ofSize: 10)
        subTitleLabel.textAlignment   = .left
        subTitleLabel.text            = subTitle
        subTitleLabel.numberOfLines   = 1
        
        let twoLineTitleView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 30))
        twoLineTitleView.addSubview(titleLabel)
        twoLineTitleView.addSubview(subTitleLabel)
        
        self.navigationItem.titleView = twoLineTitleView
    }
    /// Shows 2 lines of text on navigation bar
    /// - Parameters:
    ///   - title: Dynamic text
    ///   - textColor: default text color is white, but this can be overridden.
    ///   - titleFont: default font system bold 16, but this can be overridden.
    func navigationTitleView(withTitle title: String?, textColor:UIColor = .white, titleFont:UIFont = UIFont.boldSystemFont(ofSize: 16)) {
        
        let navTitleLabel = UILabel(frame: CGRect(x: 0, y: 40, width: 320, height: 60))
        navTitleLabel.textAlignment = .left
        navTitleLabel.lineBreakMode = .byWordWrapping
        navTitleLabel.numberOfLines = 2
        navTitleLabel.font          = titleFont
        navTitleLabel.textColor     = textColor
        navTitleLabel.text          = title
        self.navigationItem.titleView = navTitleLabel
    }
    
    // MARK: - VC Flow
    
    /// Pushes a view controller onto the receiver’s stack and updates the display.
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// Pops the top view controller from the navigation stack and updates the display.
    func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }

    /// Hide or show navigation bar
    var isNavBarHidden: Bool {
        get {
            return (navigationController?.isNavigationBarHidden)!
        }
        set {
            navigationController?.isNavigationBarHidden = newValue
        }
    }
    
    /// Added extension for popToRootViewController
    func popToRootVC() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    /// Presents a view controller modally.
    func presentVC(_ vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    /// Dismisses the view controller that was presented modally by the view controller.
    func dismissVC(completion: (() -> Void)? ) {
        dismiss(animated: true, completion: completion)
    }

    //MARK: -  UIActivityIndicatorView
    
     ///Property used to identify the activity indicator. Default value is `999999` but this can be overridden.
    var activityIndicatorTag: Int { return 999999 }
    
    /// Returns UIActivityIndicatorView
    var activityIndicator:UIActivityIndicatorView {
        
        let activityIndicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .medium
        } else {
            activityIndicator.style = .gray
        }
        return activityIndicator
    }
    
    /// Creates and starts an `UIActivityIndicator` in any UIViewController
    /// - Parameter location: `CGPoint` if not specified the `view.center` is applied
    func startActivityIndicator(_ location: CGPoint? = nil) {
        
        let loc = location ?? self.view.center
        
        DispatchQueue.main.async(execute: {
            let activityIndicator = self.activityIndicator
            activityIndicator.tag = self.activityIndicatorTag
            activityIndicator.center = loc
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        })
    }
    
    /// Stops and removes an UIActivityIndicator in any UIViewController
    func stopActivityIndicator() {
        
        DispatchQueue.main.async(execute: {
            if let activityIndicator = self.view.subviews.filter({ $0.tag == self.activityIndicatorTag}).first as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        })
    }
    
    //MARK: - Safari
    
    /// Opens Internal safari browser
    func openSFSafariVC(WithURL url:String?, barTint colour:UIColor = .black) {
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: URL(string: url ?? "") ?? URL(string: "https://www.google.co.in/")!, configuration: config)
        vc.preferredBarTintColor = colour
        vc.preferredControlTintColor = UIColor.white
        self.present(vc, animated: true)
    }
    
}

extension UIViewController {
    
    /// Pop backs view controller. Can be override.
    @objc open func leftBarButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
