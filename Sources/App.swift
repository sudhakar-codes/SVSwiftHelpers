//
//  App.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 08/04/21.
//

import Foundation

/**
 Contains values about the currently running application. This struct should not
 need to be initialized directly.
*/
public struct App {
    
    /// Specifies whether the app is running within the iPhone
    /// simulator or not.
    public static var inSimulator: Bool {
        return (TARGET_IPHONE_SIMULATOR != 0)
    }

    /**
     Specifies whether the app is running in a Debug configuration.
     - Returns: Bool whether the app is running in simulator
    */
    public static var isDebug: Bool {
        return _isDebugAssertConfiguration()
    }

    /// Get the name of the currently running application
    public static var name: String? {
        
        if let bundleDisplayName = getFromInfo(key: "CFBundleDisplayName") {
            return bundleDisplayName
        } else if let bundleName = getFromInfo(key: "CFBundleName") {
            return bundleName
        }
        return nil
    }

    /// Get the version of the currently running application
    public static var version: String? {
        return getFromInfo(key: "CFBundleShortVersionString")
    }

    /**
     Get a formatted name and version for the running application
     in this format: `MyApp (1.1)`.
    */
    public static var formattedNameAndVersion: String? {
        if let name = App.name, let ver = App.version {
            return "\(name) (\(ver))"
        } else {
            return nil
        }
    }
    
    /// EZSE: Return app's build number
    public static var appBuild: String? {
        return getFromInfo(key: kCFBundleVersionKey as String)
    }

    /// EZSE: Return app's bundle ID
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }

    /// EZSE: Returns both app's version and build numbers "v0.3(7)"
    public static var appVersionAndBuild: String? {
        if version != nil && appBuild != nil {
            if version == appBuild {
                return "v\(version!)"
            } else {
                return "v\(version!)(\(appBuild!))"
            }
        }
        return nil
    }
    
    /**
     Get info from the bundle's plist for a specific key
     - Parameter key: The key to look up
     - Returns: A value from the bundle's plist
    */
    private static func getFromInfo(key: String) -> String? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String
    }
    
    /// Get the MAC Address of the currently running application
    public static var macAddress: String? {
        return UIDevice.current.identifierForVendor?.uuidString//NSUUID().uuidString
    }
    
    /// Get the systemVersion of the currently running application
    public static var systemVersion: String? {
        return UIDevice.current.systemVersion
    }
    ///  Returns the locale country code. An example value might be "ES". //TODO: Add to readme
    public static var currentRegion: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }
    
    /// Submits a block for asynchronous execution on the main queue
    public static func runThisInMainThread(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }

    /// Runs in Default priority queue
    public static func runThisInBackground(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
}

