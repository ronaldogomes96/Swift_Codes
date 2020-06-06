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

public class BottomAlignedView: UIView, PluginView {
  let unitSize: CGFloat = 1024

  public func update(_ content: ContentDescription) {
    markup = content
    setNeedsDisplay()
  }

  public static var name: String {
    return "BottomAlignedView"
  }

  public var view: UIView {
    return self
  }

  public override var bounds: CGRect {
    didSet {
      setNeedsDisplay()
    }
  }

  public func renderImage(content: ContentDescription, maxDimension: CGFloat) -> UIImage? {
    var renderSize = CGSize(width: maxDimension, height: maxDimension)
    if let image = content.image {
      renderSize = projectedSizeForImage(image, bounds: renderSize)
    }
    let renderer = BottomAlignedView(frame: CGRect(origin: .zero, size: renderSize))
    renderer.update(content)
    UIGraphicsBeginImageContextWithOptions(renderSize, true, 0.0)
    renderer.drawHierarchy(in: renderer.bounds, afterScreenUpdates: true)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }

  func projectedSizeForImage(_ image: UIImage, bounds: CGSize) -> CGSize {
    let aspectRatio = image.size.width/image.size.height
    var projectedWidth = bounds.width
    var projectedHeight = projectedWidth/aspectRatio

    if projectedHeight > bounds.height {
      projectedHeight = bounds.height
      projectedWidth = projectedHeight * aspectRatio
    }

    return CGSize(width: projectedWidth, height: projectedHeight)
  }

  var markup: ContentDescription?

  public override func draw(_ rect: CGRect) {
    let path = UIBezierPath(rect: bounds)
    UIColor.systemBackground.set()
    path.fill()

    guard let markup = markup else {
      return
    }

    var projectedHeight = bounds.height
    var projectedWidth = bounds.width
    if let image = markup.image {
      let projectedSize = projectedSizeForImage(image, bounds: bounds.size)
      projectedWidth = projectedSize.width
      projectedHeight = projectedSize.height
      let imageRect = CGRect(x: (bounds.width - projectedWidth)/2, y: (bounds.height - projectedHeight)/2, width: projectedWidth, height: projectedHeight)
      image.draw(in: imageRect)
    }

    var totalTextHeight: CGFloat = 0
    let imagebaselineY = bounds.height - (bounds.height - projectedHeight)/2
    let imagebaselineX = (bounds.width - projectedWidth)/2
    var futureDrawingInstructions = [(()->Void)]()
    let fontScaler = projectedHeight/unitSize
    let inset: CGFloat = 8.0 * fontScaler

    if let longDescription = markup.longDescription, !longDescription.isEmpty {
      let font = UIFont.systemFont(ofSize: 20 * fontScaler)
      let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: markup.textColor]
      let projectedrect = longDescription.ns().boundingRect(with: CGSize(width: projectedWidth - 2 * inset, height: projectedHeight/4), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
      let drawingrect = projectedrect.applying(CGAffineTransform(translationX: inset + imagebaselineX, y: imagebaselineY - inset - projectedrect.height))
      futureDrawingInstructions.append {
        longDescription.ns().draw(in: drawingrect, withAttributes: attributes)
      }
      totalTextHeight += drawingrect.height + 2 * inset
    }

    if let title = markup.title, !title.isEmpty {
      let font = UIFont.boldSystemFont(ofSize: 36 * fontScaler)
      let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: markup.textColor]
      let projectedrect = title.ns().boundingRect(with: CGSize(width: projectedWidth - 2 * inset, height: projectedHeight/4), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
      let drawingrect = projectedrect.applying(CGAffineTransform(translationX: inset + imagebaselineX, y: imagebaselineY - projectedrect.height - totalTextHeight))
      futureDrawingInstructions.append {
        title.ns().draw(in: drawingrect, withAttributes: attributes)
      }
      totalTextHeight += drawingrect.height + 2 * inset
    }

    if totalTextHeight > 0 {
      let strip = CGRect(x: imagebaselineX, y: imagebaselineY - totalTextHeight, width: projectedWidth, height: totalTextHeight)
      let path = UIBezierPath(rect: strip)
      markup.textBackgroundColor.withAlphaComponent(0.8).set()
      path.fill()
    }

    for instruction in futureDrawingInstructions {
      instruction()
    }
  }
}
