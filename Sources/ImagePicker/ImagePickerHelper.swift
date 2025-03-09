//
//  ImagePickerHelper.swift
//  SVSwiftHelpers
//
//  Created by Sudhakar Dasari on 09/03/25.
//

import UIKit
import PhotosUI
import ImageIO

/// Protocol to handle selected media (images/videos) and their metadata
public protocol ImagePickerHelperDelegate: AnyObject {
    /// Called when media is selected
    /// - Parameter media: Array of selected media along with their metadata
    func didSelectMedia(_ media: [(media: UIImage?, videoURL: URL?, metadata: ImageMetadata)])
    func imagePicker(_ imagePicker: ImagePickerHelper, grantedAccess: Bool, to sourceType: UIImagePickerController.SourceType)
}

/// Structure to store media metadata
public struct ImageMetadata {
    public var fileName: String?   // Name of the media file
    public var fileType: String?   // File type (e.g., jpg, png, mov)
    public var fileSize: Int?      // Size of the file in bytes
    public var mediaURL: URL?      // URL of the media in the file system
    public var captureDate: Date? // Date and time when the media was captured
    public var location: (latitude: Double, longitude: Double)? // GPS location data
    public var metadata: [String: Any]? // Full metadata dictionary for additional details
    public var assetInfo:[UIImagePickerController.InfoKey: Any]?
    public var duration: Double?   // Duration of video (only applicable for videos)
    
    public init(fileName: String?, fileType: String?, fileSize: Int?, mediaURL: URL?, captureDate: Date?, location: (latitude: Double, longitude: Double)?, metadata: [String: Any]?, duration: Double?, assetInfo:[UIImagePickerController.InfoKey: Any]?) {
        self.fileName = fileName
        self.fileType = fileType
        self.fileSize = fileSize
        self.mediaURL = mediaURL
        self.captureDate = captureDate
        self.location = location
        self.metadata = metadata
        self.duration = duration
        self.assetInfo = assetInfo
    }
}

/// Helper class for handling media selection using PHPickerViewController
public class ImagePickerHelper: NSObject  {
    
    /// Delegate to receive selected media and metadata
    public weak var delegate: ImagePickerHelperDelegate?
    
    /// Initializes the media picker helper
    public override init() {
        super.init()
    }
    
    /// Request access for Camera or Photo Library based on the given source type
    /// - Parameter sourceType: The source type (Camera or Photo Library)
    public func mediaAccessRequest(for sourceType: UIImagePickerController.SourceType) {
        switch sourceType {
        case .camera:
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
                    delegate?.imagePicker(self, grantedAccess: true, to: .camera)
                } else {
                    AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                        guard let self = self else { return }
                        if granted {
                            self.delegate?.imagePicker(self, grantedAccess: granted, to: .camera)
                        } else {
                            self.showAlert(targetName: "camera") { self.delegate?.imagePicker(self, grantedAccess: $0, to: .camera) }
                        }
                    }
                }
            } else {
                UIApplication.shared.windows.first?.rootViewController?.showAlert(App.name, "This device doesn't have a camera", "Ok")
            }
        case .photoLibrary:
            let status = PHPhotoLibrary.authorizationStatus()
            if status == .authorized || status == .limited {
                delegate?.imagePicker(self, grantedAccess: true, to: .photoLibrary)
            } else if status == .notDetermined {
                PHPhotoLibrary.requestAuthorization { [weak self] newStatus in
                    guard let self = self else { return }
                    DispatchQueue.main.async {
                        if newStatus == .authorized || newStatus == .limited {
                            self.delegate?.imagePicker(self, grantedAccess: true, to: .photoLibrary)
                        } else {
                            self.showAlert(targetName: "photo library") { self.delegate?.imagePicker(self, grantedAccess: $0, to: .photoLibrary) }
                        }
                    }
                }
            } else {
                showAlert(targetName: "photo library") { self.delegate?.imagePicker(self, grantedAccess: $0, to: .photoLibrary) }
            }
        default:
            break
        }
    }
    
    /// Show an alert prompting the user to enable permissions in Settings
    private func showAlert(targetName: String, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: "Permission Denied", message: "Please enable access to your \(targetName) in Settings.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completion(false) }))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UIImagePickerController

extension ImagePickerHelper:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// Presents the camera to capture an image or video
    public func presentCamera(from viewController: UIViewController, mediaType: UIImagePickerController.SourceType = .camera, allowsEditing:Bool = false) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = mediaType
        imagePicker.allowsEditing = allowsEditing
        imagePicker.mediaTypes = [UTType.image.identifier, UTType.movie.identifier]
        imagePicker.delegate = self
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        var selectedMedia: [(media: UIImage?, videoURL: URL?, metadata: ImageMetadata)] = []
        
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage,
           let fileURL = info[.imageURL] as? URL {
            
            let metadata = extractMetadata(from: fileURL, info: info)
            
            selectedMedia.append((media: image, videoURL: nil, metadata: metadata))
            
        } else if let videoURL = info[.mediaURL] as? URL {
            
            var metadata = extractMetadata(from: videoURL, info: info)
            metadata.duration = CMTimeGetSeconds(AVAsset(url: videoURL).duration)
            
            selectedMedia.append((media: nil, videoURL: videoURL, metadata: metadata))
        }
        
        self.delegate?.didSelectMedia(selectedMedia)
    }
    private func extractMetadata(from fileURL: URL, info: [UIImagePickerController.InfoKey: Any]) -> ImageMetadata {
        var metadata = ImageMetadata(
            fileName: fileURL.lastPathComponent,
            fileType: fileURL.pathExtension,
            fileSize: nil,
            mediaURL: fileURL,
            captureDate: nil,
            location: nil,
            metadata: nil,
            duration: nil,
            assetInfo: info
        )
        if let asset = info[.phAsset] as? PHAsset {
            metadata.captureDate = asset.creationDate ?? Date()
            if let assetLocation = asset.location {
                metadata.location = (latitude: assetLocation.coordinate.latitude, longitude: assetLocation.coordinate.longitude)
            }
        }
        return metadata
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - PHPickerViewController

extension ImagePickerHelper:PHPickerViewControllerDelegate {
    
    /// Presents the media picker to allow the user to select images or videos
    /// - Parameters:
    ///   - viewController: The view controller from which the picker is presented
    ///   - selectionLimit: Maximum number of media items the user can select (default: 4)
    ///   - filter: Filter type (images, videos, or both). default .any(of: [.images]
    public func presentMediaPicker(from viewController: UIViewController, selectionLimit: Int = 4, filter: PHPickerFilter = .any(of: [.images])) {
        var configuration = PHPickerConfiguration()
        configuration.filter = filter
        configuration.selectionLimit = selectionLimit
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        viewController.present(picker, animated: true, completion: nil)
    }
    
    /// Handles media selection from PHPickerViewController
    /// - Parameters:
    ///   - picker: The PHPickerViewController instance
    ///   - results: Array of selected PHPickerResult objects
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        var selectedMedia: [(media: UIImage?, videoURL: URL?, metadata: ImageMetadata)] = []
        let group = DispatchGroup()
        
        for result in results {
            let provider = result.itemProvider
            
            if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                group.enter()
                provider.loadObject(ofClass: UIImage.self) { (image, error) in
                    self.extractMetadata(from: provider, typeIdentifier: UTType.image.identifier) { metadata in
                        selectedMedia.append((media: image as? UIImage, videoURL: nil, metadata: metadata))
                        group.leave()
                    }
                }
            } else if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                group.enter()
                provider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, error) in
                    if let videoURL = url {
                        self.extractMetadata(from: provider, typeIdentifier: UTType.movie.identifier) { metadata in
                            selectedMedia.append((media: nil, videoURL: videoURL, metadata: metadata))
                            group.leave()
                        }
                    } else {
                        group.leave()
                    }
                }
            }
        }
        
        /// Notify delegate once all media are processed
        group.notify(queue: .main) {
            self.delegate?.didSelectMedia(selectedMedia)
        }
    }
    
    /// Extracts metadata from the selected media
    /// - Parameters:
    ///   - provider: NSItemProvider instance from PHPickerResult
    ///   - typeIdentifier: Type identifier to determine if it’s an image or video
    ///   - completion: Completion handler returning ImageMetadata
    private func extractMetadata(from provider: NSItemProvider, typeIdentifier: String, completion: @escaping (ImageMetadata) -> Void) {
        
        provider.loadInPlaceFileRepresentation(forTypeIdentifier: typeIdentifier) { url, inPlace, error in
            guard let fileURL = url else {
                completion(ImageMetadata(fileName: nil, fileType: nil, fileSize: nil, mediaURL: nil, captureDate: nil, location: nil, metadata: nil, duration: nil, assetInfo: nil))
                return
            }
            
            var metadata = ImageMetadata(fileName: fileURL.lastPathComponent, fileType: fileURL.pathExtension, fileSize: nil, mediaURL: fileURL, captureDate: nil, location: nil, metadata: nil, duration: nil, assetInfo: nil)
            
            /// Retrieve file size
            if let attributes = try? FileManager.default.attributesOfItem(atPath: fileURL.path),
               let fileSize = attributes[.size] as? Int {
                metadata.fileSize = fileSize
            }
            
            /// Extract metadata if it's an image
            if typeIdentifier == UTType.image.identifier,
               let source = CGImageSourceCreateWithURL(fileURL as CFURL, nil),
               let imageProperties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [String: Any] {
                metadata.metadata = imageProperties
                
                /// Extract capture date from EXIF data
                if let exifData = imageProperties[kCGImagePropertyExifDictionary as String] as? [String: Any],
                   let dateTime = exifData[kCGImagePropertyExifDateTimeOriginal as String] as? String {
                    metadata.captureDate = dateTime.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
                }
                
                /// Extract GPS location data
                if let gpsData = imageProperties[kCGImagePropertyGPSDictionary as String] as? [String: Any],
                   let lat = gpsData[kCGImagePropertyGPSLatitude as String] as? Double,
                   let long = gpsData[kCGImagePropertyGPSLongitude as String] as? Double {
                    metadata.location = (latitude: lat,longitude: long)
                }
            }
            
            /// Extract metadata for videos
            if typeIdentifier == UTType.movie.identifier {
                let asset = AVAsset(url: fileURL)
                metadata.duration = CMTimeGetSeconds(asset.duration)
                
                if let creationDateItem = asset.metadata.first(where: { $0.commonKey == .commonKeyCreationDate }),
                   let dateValue = creationDateItem.value as? String {
                    metadata.captureDate = dateValue.toDate(withFormat: "yyyy-MM-dd HH:mm:ss")
                }
                
                if let locationItem = asset.metadata.first(where: { $0.commonKey == .commonKeyLocation }),
                   let locationString = locationItem.value as? String {
                    let coordinates = locationString.split(separator: ",").compactMap { Double($0) }
                    if coordinates.count == 2 {
                        metadata.location = (latitude: coordinates[0], longitude: coordinates[1])
                    }
                }
            }
            
            completion(metadata)
        }
    }
}

