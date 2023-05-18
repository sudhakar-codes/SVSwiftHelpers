//
//  ReviewRequest.swift
//  Swachhata
//
//  Created by Sudhakar Dasari on 11/07/22.
//  Copyright © 2022 Janaagraha. All rights reserved.
//

import Foundation
import StoreKit

public class ReviewRequest: NSObject {
    
    /// Singleton object
    public static let shared = ReviewRequest()
    
    // Change initializer access level to prevent creating object outside of the class.
    private override init() { }
    
    /// UserDefaults dictionary key where we store number of runs
    private let runIncrementerSetting = "numberOfRuns"
    
    /// Minimum number of runs that we should have until we ask for review. default is `5`
    public var minimumRunCount = 5
    
    /// Return number of runs from UserDefaults
    private var getRunCounts:Int {
        return UserDefaults.standard.integer(forKey: runIncrementerSetting)
    }
    
    /// Counter for number of runs for the app. You can call this from App Delegate
    public func incrementAppRuns() {
        
        let runs = getRunCounts + 1
        UserDefaults.standard.set(runs, forKey: runIncrementerSetting)
        UserDefaults.standard.synchronize()
        
#if DEBUG
        print("App runs -- \(runs)")
#endif
        
    }
    
    /// Show `SKStoreReviewController`
    public func showReview() {
        
        if getRunCounts > minimumRunCount {
            
            if #available(iOS 14.0, *) {
                
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    DispatchQueue.main.async {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                }
            } else {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
    
}

