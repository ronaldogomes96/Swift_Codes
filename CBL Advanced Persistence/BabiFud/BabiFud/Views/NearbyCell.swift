
import UIKit

class NearbyCell: UITableViewCell {
  // MARK: - Outlets
  @IBOutlet private weak var placeImageView: UIImageView!
  @IBOutlet private weak var name: UILabel!

  var establishment: Establishment? {
    didSet {
      placeImageView.image = nil
      name.text = establishment?.name
      establishment?.loadCoverPhoto { [weak self] image in
        guard let self = self else { return }
        self.placeImageView.image = image
      }
    }
  }
}
