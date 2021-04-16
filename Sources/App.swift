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
        return getFromInfo(key: "CFBundleDisplayName")
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
}

