
import UIKit
import CloudKit

class NotesTableViewController: UITableViewController {
  // MARK: - Properties
  var notes: [Note] = []
  var establishment: Establishment?
  var dataSource: UITableViewDiffableDataSource<Int, Note>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dataSource = notesDataSource()
    if establishment == nil {
      refreshControl = UIRefreshControl()
      refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
      refresh()
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    reloadSnapshot(animated: false)
  }
  
  @objc private func refresh() {
    Note.fetchNotes { result in
      self.refreshControl?.endRefreshing()
      switch result {
      case .failure(let error):
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
      case .success(let notes):
        self.notes = notes
      }
      self.reloadSnapshot(animated: true)
    }
  }
}

extension NotesTableViewController {
  private func notesDataSource() -> UITableViewDiffableDataSource<Int, Note> {
    let reuseIdentifier = "NoteCell"
    return UITableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, note) -> UITableViewCell? in
      let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
      cell.textLabel?.text = note.noteLabel
      return cell
    }
  }
  
  private func reloadSnapshot(animated: Bool) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, Note>()
    snapshot.appendSections([0])
    var isEmpty = false
    if let establishment = establishment {
      snapshot.appendItems(establishment.notes ?? [])
      isEmpty = (establishment.notes ?? []).isEmpty
    } else {
      snapshot.appendItems(notes)
      isEmpty = notes.isEmpty
    }
    dataSource?.apply(snapshot, animatingDifferences: animated)
    if isEmpty {
      let label = UILabel()
      label.text = "No Notes Found"
      label.textColor = UIColor.systemGray2
      label.textAlignment = .center
      label.font = UIFont.preferredFont(forTextStyle: .title2)
      tableView.backgroundView = label
    } else {
      tableView.backgroundView = nil
    }
  }
}
