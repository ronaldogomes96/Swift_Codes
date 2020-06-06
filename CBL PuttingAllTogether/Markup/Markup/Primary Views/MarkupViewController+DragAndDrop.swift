//
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

extension MarkupViewController: UIDragInteractionDelegate {
  func configureDragInteraction() {
    let interaction = UIDragInteraction(delegate: self)
    templateContainer.addInteraction(interaction)
  }

  func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
    guard let template = currentTemplate, let content = currentContent else {
      return []
    }

    guard let image = template.renderImage(content: content, maxDimension: 1024) else {
      return []
    }

    let itemprovider = NSItemProvider(object: image)
    let dragitem = UIDragItem(itemProvider: itemprovider)

    return [dragitem]
  }
}

extension MarkupViewController: UIDropInteractionDelegate {
  func configureDropInteraction() {
    let interaction = UIDropInteraction(delegate: self)
    templateContainer.addInteraction(interaction)
  }

  func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
    //print("yo promise",session.canLoadObjects(ofClass: URL.self))
    return session.canLoadObjects(ofClass: UIImage.self)
  }

  func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
    print("enter")
    highlightTemplateContainer(true)
  }

  func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: UIDropSession) {
    highlightTemplateContainer(false)
  }

  func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession) {
    highlightTemplateContainer(false)
  }

  func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
    //only want external app sessions
    if session.localDragSession == nil {
      return UIDropProposal(operation: .copy)
    }
    return UIDropProposal(operation: .cancel)
  }

  func highlightTemplateContainer(_ highlight: Bool) {
    templateContainer.layer.borderColor = highlight ? UIColor.systemOrange.cgColor: UIColor.clear.cgColor
    templateContainer.layer.borderWidth = highlight ? 4:0
  }

  func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
    if session.localDragSession == nil {
      session.loadObjects(ofClass: UIImage.self) { images in
        if let image = images.first as? UIImage {
          guard let template = self.currentContent else {
            return
          }
          template.image = image
          self.currentContent = template
        }
      }
    }
  }

  func dropInteraction(_ interaction: UIDropInteraction, concludeDrop session: UIDropSession) {
    highlightTemplateContainer(false)
  }
}
