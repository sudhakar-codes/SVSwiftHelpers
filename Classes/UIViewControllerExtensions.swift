//
//  UIViewControllerExtensions.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 08/04/21.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    
    //MARK:-  Alerts & Actionsheet

    public func showAlert(_ title: String?, _ message:String?,_ buttonTitle:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { (action: UIAlertAction) in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    public func showAlertMoreThanOneButton(_ title: String?, _ message: String?, style:UIAlertController.Style, actions:UIAlertAction...){
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions{
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }

    public func action(_ title: String, preferredStyle:UIAlertAction.Style, action:@escaping (_ alertAction: UIAlertAction) -> Void) -> UIAlertAction{
        let btnAction = UIAlertAction(title: title, style:preferredStyle, handler:action)
        return btnAction
    }
    
    public func openSFSafariVC(WithURL url:String?, barTint colour:UIColor?) {
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: NSURL(string: url ?? "")! as URL, configuration: config)
        vc.preferredBarTintColor = colour
        vc.preferredControlTintColor = UIColor.white
        self.present(vc, animated: true)
    }
}

