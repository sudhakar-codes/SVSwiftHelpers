//
//  UIViewControllerExtensions.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 08/04/21.
//

import Foundation
import UIKit


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
}

