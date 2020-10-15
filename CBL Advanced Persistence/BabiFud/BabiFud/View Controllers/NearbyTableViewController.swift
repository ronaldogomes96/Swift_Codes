
import UIKit
import CoreLocation

class NearbyTableViewController: UITableViewController {
  var locationManager: CLLocationManager!
  var dataSource: UITableViewDiffableDataSource<Int, Establishment>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLocationManager()
    dataSource = establishmentDataSource()
    tableView.dataSource = dataSource
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    refresh()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    reloadSnapshot(animated: false)
  }
  
  @objc private func refresh() {
    Model.currentModel.refresh { error in
      if let error = error {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        self.tableView.refreshControl?.endRefreshing()
        return
      }
      self.tableView.refreshControl?.endRefreshing()
      self.reloadSnapshot(animated: true)
    }
  }

  // MARK: - Navigation
  @IBSegueAction private func detailSegue(coder: NSCoder, sender: Any?) -> DetailTableViewController? {
    guard
      let cell = sender as? NearbyCell,
      let indexPath = tableView.indexPath(for: cell),
      let detailViewController = DetailTableViewController(coder: coder)
      else { return nil }
    detailViewController.establishment = Model.currentModel.establishments[indexPath.row]
    return detailViewController
  }
}

extension NearbyTableViewController {
  private func establishmentDataSource() -> UITableViewDiffableDataSource<Int, Establishment> {
    let reuseIdentifier = "NearbyCell"
    return UITableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, establishment) -> NearbyCell? in
      let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NearbyCell
      cell?.establishment = establishment
      return cell
    }
  }
  
  private func reloadSnapshot(animated: Bool) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, Establishment>()
    snapshot.appendSections([0])
    snapshot.appendItems(Model.currentModel.establishments)
    dataSource?.apply(snapshot, animatingDifferences: animated)
    if Model.currentModel.establishments.isEmpty {
      let label = UILabel()
      label.text = "No Restaurants Found"
      label.textColor = UIColor.systemGray2
      label.textAlignment = .center
      label.font = UIFont.preferredFont(forTextStyle: .title2)
      tableView.backgroundView = label
    } else {
      tableView.backgroundView = nil
    }
  }
}

// MARK: - CLLocationManagerDelegate
extension NearbyTableViewController: CLLocationManagerDelegate {
  func setupLocationManager() {
    locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    
    // Only look at locations within a 0.5 km radius.
    locationManager.distanceFilter = 500.0
    locationManager.delegate = self
    
    CLLocationManager.authorizationStatus()
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)  {
    switch status {
    case .notDetermined:
      manager.requestWhenInUseAuthorization()
    case .authorizedWhenInUse:
      manager.startUpdatingLocation()
    default:
      // Do nothing.
      print("Other status")
    }
  }
}
