/**
 PhotosView
 flickry
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Roderic Linguri
 - Requires:  iOS >11
 - Version:   0.1.6
 - Since:     0.1.2
 */

import UIKit

class PhotosView: UIViewController, UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
  
  // MARK: - Properties
  
  let controller: PhotoController = PhotoController.shared
  
  let refreshControl: UIRefreshControl = UIRefreshControl()
  
  // MARK: - Outlets
  
  @IBOutlet weak var searchBar: UISearchBar?
  
  @IBOutlet weak var collectionView: UICollectionView?
  
  // MARK: - Actions
  
  /**
   Unwind Anchor
   - Parameter segue: UIStoryboardSegue
   */
  @IBAction func unwindToPhotos(_ segue: UIStoryboardSegue) {
    Console.log(filePath: #file, function: #function, params: ["segue": segue.source], message: nil)
  } // ./unwindToPhotos
  
  // MARK: - PhotosView
  
  /**
   Refresh Selector
   */
  @objc func refresh() {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    if let text = self.searchBar?.text {
      self.controller.model.sendRequest(forSearchTerm: text)
    } else {
      // @TODO: Add Alert to provide user feedback
      print("No Search Term Specified")
      // TEMP: search for "sunset"
      self.controller.model.sendRequest(forSearchTerm: "sunset")
    }
    
  } // ./refresh
  
  /**
   Update Content
   */
  func updateContent() {
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
  } // ./updateContent
  
  /**
   Configure outlets and constraints
   - Parameter animated: Bool
   */
  func updateLayout(animated: Bool) {
    
    Console.log(filePath: #file, function: #function, params: ["animated": animated], message: nil)
    
    self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    if animated {
      UIView.animate(withDuration: 0.33) {
        self.view.layoutIfNeeded()
      } // ./animate
    } // ./animated?
    
  } // ./updateLayout
  
  // MARK: - UIViewController
  
  /**
   Called just after init
   */
  override func awakeFromNib() {
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    super.awakeFromNib()
    self.controller.masterView = self
  } // ./awakeFromNib
  
  /**
   Called when all outlets are loaded
   */
  override func viewDidLoad() {
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    super.viewDidLoad()
    self.refreshControl.addTarget(self, action: #selector(PhotosView.refresh), for: .valueChanged)
    self.collectionView?.refreshControl = self.refreshControl
    self.searchBar?.layer.borderWidth = 0.0
    self.updateContent()
    self.updateLayout(animated: false)
  } // ./viewDidLoad
  
  // MARK: - UISearchBarDelegate
  
  /**
   Called when the search bar begins editing
   - Parameter searchBar: UISearchBar
   */
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    Console.log(filePath: #file, function: #function, params: ["searchBar": searchBar.description], message: nil)
  } // ./searchBarTextDidBeginEditing
  
  /**
   Called when the cancel button is clicked
   - Parameter searchBar: UISearchBar
   */
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    Console.log(filePath: #file, function: #function, params: ["searchBar": searchBar.description], message: nil)
    searchBar.text = ""
    searchBar.resignFirstResponder()
  } // ./searchBarCancelButtonClicked
  
  /**
   Called when the search button is touched
   - Parameter searchBar: UISearchBar
   */
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    Console.log(filePath: #file, function: #function, params: ["searchBar": searchBar.description], message: nil)
    searchBar.resignFirstResponder()
    self.refresh()
  } // ./searchBarSearchButtonClicked
  
  /**
   Called when the search bar text changes
   - Parameter searchBar: UISearchBar
   - Parameter searchText: String
   */
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    Console.log(
      filePath: #file,
      function: #function,
      params: ["searchBar": searchBar.description, "textDidChangeSearchText": searchText],
      message: nil
    )
    
    if searchText.count > 2 {
      self.refresh()
    }
  } // ./textDidChangeSearchText
  
  // MARK: - UICollectionViewDataSource
  
  /**
   Called when tableView needs to know how many rows there are
   - Parameter tableView: UICollectionView
   - Parameter section:   Int
   - Returns:  Int
   */
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let dataCount = self.controller.model.data.count
    if dataCount > 0 {
      return 1000000
    } else {
      return 0
    }
  }
  
  /**
   Called when the collectionView needs the cell
   - Parameter tableView: UITableView
   - Parameter indexPath: IndexPath
   - Returns:  UITableViewCell
   */
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    Console.log(filePath: #file, function: #function, params: ["cellForRowAtIndexPath": indexPath], message: nil)
    
    let dataRow = indexPath.row % self.controller.model.data.count
    
    if let cell = self.collectionView?.dequeueReusableCell(
      withReuseIdentifier: Identifier.photoCell,
      for: indexPath
      ) as? PhotoCell {
      if self.controller.model.data.count > indexPath.row {
        let photo = self.controller.model.data[dataRow]
        if let localURL = photo.localImageURL {
          cell.contentView.contentMode = .center
          cell.thumbnailView?.image = UIImage(contentsOfFile: localURL.path)
        }
      } // ./row index in range
      return cell
    } else {
      return UICollectionViewCell()
    }
    
  }
  
  // MARK: - CollectionViewDelegate
  
  /**
   Called when a cell is selected
   - Parameter collectionView: UICollectionView
   - Parameter indexPath: IndexPath
   */
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    Console.log(filePath: #file, function: #function, params: ["didSelectItemAtIndexPath": indexPath], message: nil)
    let dataRow = indexPath.row % self.controller.model.data.count
    self.controller.model.cursor = Cursor(withSection: 0, andRow: dataRow)
    self.performSegue(withIdentifier: Identifier.photosShowPhoto, sender: nil)
  } // ./didSelectItemAtIndexPath
  
}
