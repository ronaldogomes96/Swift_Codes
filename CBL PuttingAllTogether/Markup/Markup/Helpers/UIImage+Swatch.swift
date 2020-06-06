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

extension UIImage {
  static func swatch(_ color: UIColor, size: CGSize = CGSize(width: 32, height: 32)) -> UIImage? {
    var image: UIImage?
    let rect = CGRect(origin: .zero, size: size)
    
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
    color.set()
    let path = UIBezierPath(roundedRect: rect.insetBy(dx: size.width/8, dy: size.width/8), cornerRadius: size.width/2.0)
    path.fill()
    UIColor.gray.set()
    path.stroke()
    image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }

  func forNSToolbar() -> UIImage? {
    var image: UIImage?
    let toolbarImageSize: CGFloat = 32
    let imageRect = CGRect(x: 0, y: 0, width: toolbarImageSize, height: toolbarImageSize)

    let sourceAspect = size.width/size.height
    let destHeight: CGFloat = sourceAspect > 1 ? toolbarImageSize/sourceAspect:toolbarImageSize
    let destWidth: CGFloat = sourceAspect > 1 ? toolbarImageSize:toolbarImageSize*sourceAspect
    let destSize = CGSize(width: destWidth, height: destHeight)
    let destOrigin = CGPoint(x: (toolbarImageSize - destWidth)/2, y: (toolbarImageSize - destHeight)/2)
    let destRect = CGRect(origin: destOrigin, size: destSize)

    UIGraphicsBeginImageContextWithOptions(imageRect.size, false, 0)
    draw(in: destRect)
    image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
