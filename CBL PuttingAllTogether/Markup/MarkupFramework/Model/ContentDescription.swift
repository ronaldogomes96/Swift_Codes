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

/// Content Description is a concrete implementation of a ContentDescription
/// It provides NSCoding conformance to allow serialization via NSKeyedArchiver/NSKeyedDearchiver
public class ContentDescription: NSObject, NSSecureCoding {
  public static var supportsSecureCoding = true

  public var textColor: UIColor = .black
  public var longDescription: String?
  public var title: String?
  public var textBackgroundColor: UIColor = .white
  public var image: UIImage?
  public var template: String

  public init(template: String) {
    self.template = template
  }

  private enum Keys: String, CustomStringConvertible {
    case textColor
    case longDescription
    case title
    case textBackgroundColor
    case image
    case template

    var description: String {
      return self.rawValue
    }
  }

  /// NSCoding conformance
  /// Use NSKeyedArchiver.archiveRootObject(...) to encode to Data
  public func encode(with coder: NSCoder) {
    coder.encode(template, forKey: Keys.template.description)
    coder.encode(title, forKey: Keys.title.description)
    coder.encode(longDescription, forKey: Keys.longDescription.description)
    if let image = image, let data = image.jpegData(compressionQuality: 1.0) {
      coder.encode(data, forKey: Keys.image.description)
    }
    coder.encode(textBackgroundColor, forKey: Keys.textBackgroundColor.description)
    coder.encode(textColor, forKey: Keys.textColor.description)
  }

  /// NSSecureCoding conformance
  /// Use NSKeyedUnarchiver.unarchiveObject(...) to decode from Data
  public required init?(coder decoder: NSCoder) {
    guard let plugin = decoder.decodeObject(of: NSString.self, forKey: Keys.template.description) else {
          return nil
        }
    template = plugin as String
    title = decoder.decodeObject(of: NSString.self, forKey: Keys.title.description) as String?
    longDescription = decoder.decodeObject(of: NSString.self, forKey: Keys.longDescription.description) as String?
    if let data = decoder.decodeObject(of: NSData.self, forKey: Keys.image.description) as Data? {
      image = UIImage(data: data)
    }
    textBackgroundColor = decoder.decodeObject(of: UIColor.self, forKey: Keys.textBackgroundColor.description) ?? .white
    textColor = decoder.decodeObject(of: UIColor.self, forKey: Keys.textColor.description) ?? .black
  }
}
