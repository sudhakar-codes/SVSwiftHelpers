//
//  UIApplicationExtension.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 06/05/21.
//

import Foundation

public extension UIApplication {
    
    /// Get the top most view controller from the base view controller; default param is UIWindow's rootViewController
    class func topViewController(_ base: UIViewController? = UIApplication.shared.activeWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
    
    /// Computed property to get the active window
    var activeWindow: UIWindow? {
        if #available(iOS 15.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                .first
        } else {
            return UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        }
    }
    
    /// Get the current orientation of the app
    var orientation: UIInterfaceOrientation? {
        if #available(iOS 13.0, *) {
            return activeWindow?.windowScene?.interfaceOrientation
        } else {
            return UIApplication.shared.statusBarOrientation
        }
    }
}
