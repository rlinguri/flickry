/**
 PhotoModelDelegate
 flickry
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Roderic Linguri
 - Requires:  iOS >11
 - Version:   0.1.3
 - Since:     0.1.3
*/

import UIKit

protocol PhotoModelDelegate {
  
  /**
   Called when the model has an error
   - Parameter model: PhotoModel
   - Parameter error: Error
   */
  func model(_ model: PhotoModel, didProduceError error: Error)
  
  func model(_ model: PhotoModel, didSaveData data: [Photo])
  
} // ./PhotoModelDelegate
