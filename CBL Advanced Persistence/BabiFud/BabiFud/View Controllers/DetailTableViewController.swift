
import UIKit

class DetailTableViewController: UITableViewController {
  // MARK: - Outlets
  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var kidsMenuImageView: UIImageView!
  @IBOutlet private weak var healthyOptionImageView: UIImageView!
  @IBOutlet private weak var womensChangingLabel: UILabel!
  @IBOutlet private weak var mensChangingLabel: UILabel!
  
  // MARK: - Properties
  var establishment: Establishment?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    guard let establishment = establishment else { return }
    title = establishment.name
    let circleFill = "checkmark.circle.fill"
    let notAvailable = "xmark.circle"
    var kidsImageName = circleFill
    var healthyFoodName = circleFill
    if !establishment.kidsMenu {
      kidsImageName = notAvailable
    }
    if !establishment.healthyOption {
      healthyFoodName = notAvailable
    }
    kidsMenuImageView.image = UIImage(systemName: kidsImageName)
    healthyOptionImageView.image = UIImage(systemName: healthyFoodName)
    let changingTable = establishment.changingTable
    womensChangingLabel.alpha = (changingTable == .womens || changingTable == .both) ? 1.0 : 0.5
    mensChangingLabel.alpha = (changingTable == .mens || changingTable == .both) ? 1.0 : 0.5
    establishment.loadCoverPhoto { [weak self] image in
      guard let self = self else { return }
      self.imageView.image = image
    }
  }
  
  // MARK: - Navigation
  @IBSegueAction private func notesSegue(coder: NSCoder, sender: Any?) -> NotesTableViewController? {
    guard let notesTableViewController = NotesTableViewController(coder: coder) else { return nil }
    notesTableViewController.establishment = establishment
    return notesTableViewController
  }
}
