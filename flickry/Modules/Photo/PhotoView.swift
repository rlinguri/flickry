/**
 PhotoView
 flickry
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Roderic Linguri
 - Requires:  iOS >11
 - Version:   0.1.6
 - Since:     0.1.2
*/

import UIKit

class PhotoView: UIViewController {

  // MARK: - Properties

  let controller: PhotoController = PhotoController.shared

  // MARK: - Outlets
  
  @IBOutlet weak var photoView: UIImageView!
  
  // MARK: - Actions
  
  // MARK: - PhotoView

  /**
   Update Content
   */
  func updateContent() {
    
    var messages: [String] = []
    
    if let photo = self.controller.model.getObjectAtCursor() {
      
      messages.append("have object at cursor")
      
      self.navigationItem.title = photo.title
      
      if let url = photo.remoteURL {
        
        messages.append("have remote URL: \(url)")
        
        do {
          let imageData = try Data(contentsOf: url)
          self.photoView.image = UIImage(data: imageData)
        } // ./do
          
        catch let e as NSError {
          messages.append(e.localizedDescription)
        } // ./catch

      } // ./have URL
      
      else {
        messages.append("url was not valid")
      }
      
    } // ./have photo
    
    else {
      messages.append("could not retrieve object at cursor")
    } // ./no object at cursor

    Console.log(filePath: #file, function: #function, params: nil, message: messages.joined(separator: " | "))

  } // ./updateContent
  
  /**
   Configure outlets and constraints
   - Parameter animated: Bool
   */
  func updateLayout(animated: Bool) {
    
    Console.log(filePath: #file, function: #function, params: ["animated": animated], message: nil)
    
    // Update Constraints
    
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
    self.controller.detailView = self
  } // ./awakeFromNib
  
  /**
   Called when all outlets are loaded
   */
  override func viewDidLoad() {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)

    // @TODO: Put image inside of a scrollView, so that we can add zooming capability
    
    super.viewDidLoad()
    self.updateContent()
    self.updateLayout(animated: false)
    
  } // ./viewDidLoad

}
