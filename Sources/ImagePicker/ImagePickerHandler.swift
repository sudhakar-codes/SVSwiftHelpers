//
//  ImagePickerHandler.swift
//  Swachhata
//
//  Created by Sudhakar Dasari on 04/05/21.
//  Copyright © 2021 Janaagraha. All rights reserved.
//

import UIKit
import Photos

public protocol ImagePickerDelegate: AnyObject {
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool, to sourceType: UIImagePickerController.SourceType)
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage, assetInfo:[UIImagePickerController.InfoKey : Any])
    func cancelButtonDidClick(on imageView: ImagePicker)
}

public class ImagePicker: NSObject {
    
    private weak var controller: UIImagePickerController?
    
    /// Allow to edit the selected image. default is `true` can override.
    public var allowsEditing = true
    
    public weak var delegate: ImagePickerDelegate? = nil
    
    public func dismiss(completion: (() -> Void)? = nil) { controller?.dismiss(animated: true, completion: completion) }
    
    public func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        
        DispatchQueue.main.async {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.allowsEditing = self.allowsEditing
            controller.sourceType = sourceType
            self.controller = controller
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: - Get access to camera or photo library

extension ImagePicker {
    
    /// Access request for `camera`. Prompt Alert if user denied
    public func cameraAccessRequest() {
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            
            if delegate == nil { return }
            let source = UIImagePickerController.SourceType.camera
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                delegate?.imagePicker(self, grantedAccess: true, to: source)
            } else {
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    guard let self = self else { return }
                    if granted {
                        self.delegate?.imagePicker(self, grantedAccess: granted, to: source)
                    } else {
                        self.showAlert(targetName: "camera") { self.delegate?.imagePicker(self, grantedAccess: $0, to: source) }
                    }
                }
            }
            
        } else {
            UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController?.showAlert(App.name, "You don't have camera", "Ok")
        }
        
    }
    
    /// Assess request for `Photos`. Prompt Alert if user denied
    public func photoGalleryAccessRequest() {
        
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self = self else { return }
            let source = UIImagePickerController.SourceType.photoLibrary
            if result == .authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.imagePicker(self, grantedAccess: result == .authorized, to: source)
                }
            } else {
                self.showAlert(targetName: "photo gallery") { self.delegate?.imagePicker(self, grantedAccess: $0, to: source) }
            }
        }
    }
    
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

// MARK: UINavigationControllerDelegate

extension ImagePicker: UINavigationControllerDelegate { }

// MARK: UIImagePickerControllerDelegate

extension ImagePicker: UIImagePickerControllerDelegate {
    
    
    /// Callback when user select image from `photos` or `camera`
    /// - Parameters:
    ///   - picker:
    ///   - info: selected image (editedImage)
    public func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image, assetInfo: info)
            return
        }
        
        if let image = info[.originalImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image, assetInfo: info)
        } else {
            print("Other source")
        }
    }
    
    
    /// Callback if user cancel
    /// - Parameter picker: 
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.cancelButtonDidClick(on: self)
    }
}
