/// Copyright (c) 2018 Razeware LLC
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
import MarkupFramework

protocol MarkupViewControllerDelegate: class {
  func markupEditorDidFinishEditing(_ controller: MarkupViewController, markup: ContentDescription)
  func markupEditorDidUpdateContent(_ controller: MarkupViewController, markup: ContentDescription)
}

class MarkupViewController: UIViewController {
  @IBOutlet weak var chooseImageButton: UIButton!
  @IBOutlet weak var titleField: UITextField!
  @IBOutlet weak var descriptionField: UITextField!
  @IBOutlet weak var templateContainer: UIView!

  @IBOutlet weak var managedKeyboardExpander: UIView!
  var keyboardExpander: KeyboardExpander?

  var currentContent: ContentDescription? {
    didSet {
      if let markup = currentContent {
        delegate?.markupEditorDidUpdateContent(self, markup: markup)
      }
      loadCurrentContent()
    }
  }
  var currentTemplate: PluginView?
  var delegate: MarkupViewControllerDelegate?

  @IBAction func chooseImageAction(_ sender: Any) {
    let helper = ImagingHelper(presenter: self, sourceview: chooseImageButton)
    helper.pickImage()
  }

  @IBAction func colorAction(_ button: UIButton) {
    guard let template = currentContent else {
      return
    }
    template.textBackgroundColor = button.backgroundColor ?? .white
    currentContent = template
  }

  @IBAction func doneAction(_ sender: Any) {
    view.endEditing(true)
    if let markup = currentContent {
      delegate?.markupEditorDidFinishEditing(self, markup: markup)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    keyboardExpander = KeyboardExpander(managedView: managedKeyboardExpander)
    configureDragInteraction()
    configureDropInteraction()
    observeAppBackground()
    loadDocument()
  }

  func loadCurrentContent() {
    guard let content = currentContent, isViewLoaded else {
      return
    }

    if currentTemplate == nil {
      loadTemplate(content)
    }
    currentTemplate?.update(content)
  }
}

extension MarkupViewController {
  static func freshController(markup: ContentDescription? = nil, delegate: MarkupViewControllerDelegate? = nil) -> MarkupViewController {
    let storyboard = UIStoryboard(name: "MarkupViewController", bundle: nil)
    
    guard let controller = storyboard.instantiateInitialViewController() as? MarkupViewController else {
      fatalError("Project fault - cant instantiate MarkupViewController from storyboard")
    }
    controller.delegate = delegate
    controller.currentContent = markup
    return controller
  }
}

extension MarkupViewController {
  /// POC implementation - swapping templates would require more clever to discard any insitu view
  func loadTemplate(_ content: ContentDescription) {
    let template = PluginViewFactory.plugin(named: content.template)
    templateContainer.pinToInside(view: template.view)

    currentTemplate = template
    currentContent = content

    titleField.text = currentContent?.title
    descriptionField.text = currentContent?.longDescription
  }
}

extension MarkupViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField === titleField {
      descriptionField.becomeFirstResponder()
    } else {
      view.endEditing(true)
    }
    return true
  }

  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    guard let template = currentContent else {
      return
    }

    switch textField.tag {
    case 0:
      template.title = textField.text
    case 1:
      template.longDescription = textField.text
    default:
      print("unhandled text field?")
    }

    currentContent = template
  }
}

extension MarkupViewController: UIImagePickerControllerDelegate {
  public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }

  public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    dismiss(animated: true)
    guard let template = currentContent else {
      return
    }
    ImagingHelper.image(infoDictionary: info, completion: { (image, error) in
      if let error = error {
        print("unable to get image from picker - \(error)")
      } else if let image = image {
        template.image = image
        currentContent = template
      }
    })
  }
}

extension MarkupViewController: UINavigationControllerDelegate {
  //ImagingHelper conformance only
}

extension MarkupViewController {
  @IBAction func shareAction(_ sender: UIButton) {
    guard
      let template = currentTemplate,
      let content = currentContent
      else {
        return
    }

    guard let image = template.renderImage(content: content, maxDimension: 1024) else {
      return
    }

    let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
    activity.popoverPresentationController?.sourceView = sender
    present(activity, animated: true)
  }
}

extension MarkupViewController {
  func observeAppBackground() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleAppBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
  }

  @objc func handleAppBackground(_ note: Notification) {
    if let content = currentContent {
      let result = saveDefaultDocument(content)
      print("save \(result ? "OK" : "Fail!") to \(defaultDocumentURL)")
    }
  }

  var defaultDocumentURL: URL {
    let docspath = UIApplication.documentsDirectory()
    return docspath.appendingPathComponent("Default.rwmarkup")
  }

  func loadDefaultDocument() -> ContentDescription? {
    print("loading from ", defaultDocumentURL)

    do {
      let data = try Data(contentsOf: defaultDocumentURL)
      let description = try NSKeyedUnarchiver.unarchivedObject(ofClass: ContentDescription.self, from: data)
      return description
    } catch {
      return nil
    }
  }

  @discardableResult func saveDefaultDocument(_ content: ContentDescription) -> Bool {
    print("saving to ", defaultDocumentURL)

    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: content, requiringSecureCoding: false)
      guard !data.isEmpty else {
        return false
      }
      try data.write(to: defaultDocumentURL)
    } catch {
      return false
    }
    return true
  }

  private func loadDocument() {
    if let content = loadDefaultDocument() {
      currentContent = content
    } else {
      currentContent = ContentDescription(template: BottomAlignedView.name)
    }
  }
}
