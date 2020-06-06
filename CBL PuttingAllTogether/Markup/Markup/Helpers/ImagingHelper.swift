/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import AVFoundation

typealias ImageUIPresenter = UIViewController & UIImagePickerControllerDelegate

/// cheap bolt on for presenting image picker for camera or photos in a presenting view controller
public class ImagingHelper: NSObject {
  let presenter: UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate
  private let sourceView: UIView
  var removeAction: UIAlertAction?
  private var cameraIsUserPermitted = false
  public var canPickImage = true

  public init(presenter: UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate, sourceview: UIView) {
    self.presenter = presenter
    self.sourceView = sourceview
    super.init()
  }

  public func pickImage() {
    requestPermission()
  }
}

extension ImagingHelper {
  private func requestPermission() {
    var doChooseSource = true
    
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      let cameraMediaType = AVMediaType.video
      let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)

      switch cameraAuthorizationStatus {
      case .denied:
        break
      case .restricted:
        break
      case .authorized:
        cameraIsUserPermitted = true
      case .notDetermined:
        // Prompting user for the permission to use the camera.
        doChooseSource = false
        AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
          if granted {
            self.cameraIsUserPermitted = true
          }
          DispatchQueue.main.async {
            self.chooseSource()
          }
        }

      @unknown default:
        assertionFailure("unhandled future case")
      }
    }

    if doChooseSource {
      chooseSource()
    }
  }

  private func chooseSource() {
    #if targetEnvironment(macCatalyst)
    displayPhotoPicker()
    #else
    let chooser = UIAlertController(title: NSLocalizedString("Image Source", comment: ""), message: nil, preferredStyle: .actionSheet)
    
    chooser.modalPresentationStyle = .popover
    chooser.popoverPresentationController?.sourceView = sourceView

    if canPickImage {
      chooser.addAction(UIAlertAction(title: NSLocalizedString("Photos", comment: ""), style: .default, handler: { (_) in
        self.displayPhotoPicker()
      }))
      if cameraIsUserPermitted {
        chooser.addAction(UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: { (_) in
          self.displayCameraUI()
        }))
      }
    }

    if let action = removeAction {
      chooser.addAction(action)
    }

    presenter.present(chooser, animated: true, completion: nil)
    #endif
  }

  private func displayPhotoPicker() {
    let imagePicker =  UIImagePickerController()
    imagePicker.delegate = presenter
    imagePicker.modalPresentationStyle = .popover
    imagePicker.popoverPresentationController?.sourceView = sourceView

    presenter.present(imagePicker, animated: true, completion: nil)
  }

  private func displayCameraUI() {
    let cameraUI =  UIImagePickerController()
    cameraUI.delegate = presenter
    cameraUI.sourceType = .camera
    cameraUI.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []

    presenter.present(cameraUI, animated: true, completion: nil)
  }
}
