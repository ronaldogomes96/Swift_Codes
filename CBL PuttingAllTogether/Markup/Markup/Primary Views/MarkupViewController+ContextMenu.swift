
import UIKit
import MarkupFramework

extension MarkupViewController: UIContextMenuInteractionDelegate {
  
  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
      let config = UIContextMenuConfiguration(identifier: "display" as NSString, previewProvider: nil,
                actionProvider:{ _ in
                  let identifier = UIAction.Identifier("Clear View")
                  let clearAction = UIAction (title: "Clear Editor", image: UIImage(systemName: "trash"), identifier: identifier) { (action) in
                      self.cleanDocumentAction(self)
                  }
                                              
      
      })
  }
  
  
}
