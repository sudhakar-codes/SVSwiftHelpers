//
//  PermissionHandler.swift
//  iChangeMyCity
//
//  Created by Sudhakar Dasari on 15/05/22.
//  Copyright © 2022 janaagraha. All rights reserved.
//

import UIKit
import Photos

public class PermissionHandler: NSObject {
    
    public static let shared = PermissionHandler()
    
    // Change initializer access level to prevent creating object outside of the class.
    private override init() { }
    
    // MARK: - camera
    
    /// Access request for `camera`. Prompt Alert if user denied
    /// - Parameter success:
    public func cameraAccessRequest(success:@escaping (Bool) -> Void) {
        
        guard let _ = Bundle.main.object(forInfoDictionaryKey: .cameraUsageDescription) else {
            print("WARNING: \(String.cameraUsageDescription) not found in Info.plist")
            return
        }
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                success(true)
            } else {
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    guard let self = self else { return }
                    if granted {
                        success(true)
                    } else {
                        self.showAlert(targetName: "camera") { _ in  }
                    }
                }
            }
        }else{
            UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController?.showAlert(App.name, "You don't have camera", "Ok")
        }
        
    }
    
    // MARK: - Photos
    
    /// Access request for `Photos`. Prompt Alert if user denied
    /// - Parameter success:
    public func photoGalleryAccessRequest(success:@escaping (Bool) -> Void) {
        
        guard let _ = Bundle.main.object(forInfoDictionaryKey: .photoLibraryUsageDescription) else {
            print("WARNING: \(String.photoLibraryUsageDescription) not found in Info.plist")
            return
        }
        
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized, .limited: success(true)
            break
        default:
            PHPhotoLibrary.requestAuthorization { [weak self] result in
                
                guard let self = self else { return }
                
                if result == .authorized {
                    DispatchQueue.main.async {
                        success(true)
                    }
                } else {
                    self.showAlert(targetName: "photo gallery") { _ in }
                }
            }
            break
        }
        
    }

    
}

extension PermissionHandler {
    
    private func showAlert(targetName: String, completion: ((Bool) -> Void)?) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alertVC = UIAlertController(title: "Access to the \(targetName)",
                                            message: "Please provide access to your \(targetName)",
                                            preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl) else { completion?(false); return }
                
                UIApplication.shared.open(settingsUrl, options: [:]) { [weak self] _ in
                    self?.showAlert(targetName: targetName, completion: completion)
                }
            }))
            
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completion?(false) }))
            
            UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController?.present(alertVC, animated: true, completion: nil)
        }
    }
    
}

extension String {
    
    static let locationWhenInUseUsageDescription = "NSLocationWhenInUseUsageDescription"
    static let locationAlwaysUsageDescription    = "NSLocationAlwaysUsageDescription"
    static let microphoneUsageDescription        = "NSMicrophoneUsageDescription"
    static let speechRecognitionUsageDescription = "NSSpeechRecognitionUsageDescription"
    static let photoLibraryUsageDescription      = "NSPhotoLibraryUsageDescription"
    static let cameraUsageDescription            = "NSCameraUsageDescription"
    static let mediaLibraryUsageDescription      = "NSAppleMusicUsageDescription"
    static let siriUsageDescription              = "NSSiriUsageDescription"
}
