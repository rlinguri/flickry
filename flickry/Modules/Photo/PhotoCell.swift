/**
 PhotoCell
 flickry
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Roderic Linguri
 - Requires:  iOS >11
 - Version:   0.1.2
 - Since:     0.1.2
 */

import UIKit

class PhotoCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  // MARK: - Outlets
  
  @IBOutlet weak var thumbnailView: UIImageView?
  
  // MARK: - Actions
  
  // MARK: - PhotoCell
  
  // MARK: - UITableViewCell
  
  /**
   Called just after init
   */
  override func awakeFromNib() {
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    super.awakeFromNib()
  } // ./awakeFromNib
  
}
