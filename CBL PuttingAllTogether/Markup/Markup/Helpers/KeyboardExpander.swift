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

class KeyboardExpander: NSObject {
  let managedView: UIView
  var heightContraint: NSLayoutConstraint?
  var multiplier: CGFloat = 1.0
  var restStateConstant: CGFloat = 0
  
  deinit {
    if let constraint = heightContraint {
      self.managedView.removeConstraint(constraint)
    }
  }
  
  init(managedView: UIView, constraint: NSLayoutConstraint? = nil, multiplier: CGFloat = 1.0) {
    self.managedView = managedView
    self.multiplier = multiplier
    super.init()
    if let constraint = constraint {
      heightContraint = constraint
    } else {
      constrainManagedView()
    }
    
    managedView.backgroundColor = .clear
    startObserving()
  }
  
  func constrainManagedView() {
    guard let constraint = managedView.constrainToHeight(0) else {
      assertionFailure("this should always return a constraint??")
      return
    }
    heightContraint = constraint
  }
  
  func startObserving() {
    NotificationCenter.default.addObserver(self, selector: #selector(raiseKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(dropKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func raiseKeyboard(_ notification: Notification) {
    guard
      let info = notification.userInfo,
      let targetFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
      let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
      else {
        return
    }
    
    UIView.animate(withDuration: duration.doubleValue) {
      self.heightContraint?.constant = targetFrame.height * self.multiplier
      self.managedView.superview?.layoutIfNeeded()
    }
  }
  
  @objc func dropKeyboard(_ notification: Notification) {
    guard
      let info = notification.userInfo,
      let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
      else {
        return
    }
    
    UIView.animate(withDuration: duration.doubleValue) {
      self.heightContraint?.constant = self.restStateConstant
      self.managedView.superview?.layoutIfNeeded()
    }
  }
}
