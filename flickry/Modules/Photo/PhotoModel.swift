/**
 PhotoModel
 flickry
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Roderic Linguri
 - Requires:  iOS >11
 - Version:   0.1.6
 - Since:     0.1.3
*/

import UIKit

class PhotoModel: ConnectionManagerDelegate {
  
  // MARK: - Properties

  var data: [Photo]
  
  var index: Index = Index()
  
  var cursor: Cursor = Cursor()
  
  var delegate: PhotoModelDelegate
  
  // MARK: - PhotoModel

  /**
   Initialize the model
   - Parameter delegate: PhotoModelDelegate
   */
  init(delegate: PhotoModelDelegate) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    self.delegate = delegate
    
    if let storedData = Defaults.object(forKey: PhotoKey.data) as? [Photo] {
      self.data = storedData
      self.delegate.model(self, didSaveData: storedData)
    } else {
      self.data = []
    }
    
  } // ./init
  
  /**
   Save
   */
  func save() {
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    Defaults.set(object: self.data, forKey: PhotoKey.data)
    self.delegate.model(self, didSaveData: self.data)
  } // ./save
  
  /**
   Send Request
   - Parameter searchTerm: String
   */
  func sendRequest(forSearchTerm text: String) {

    Console.log(filePath: #file, function: #function, params: ["text": text], message: nil)
    
    // @TODO: Extract URL components and API Keys into Config file
    
    if let encoded = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
      let connection = Connection(urlString: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=675894853ae8ec6c242fa4c077bcf4a0&text=\(encoded)&extras=url_s&format=json&nojsoncallback=1")
      let manager = ConnectionManager(delegate: self)
      manager.sendRequest(forConnection: connection)
    } else {
      self.delegate.model(self, didProduceError: NSError(domain: "com.monster.flickry", code: 996, userInfo: [kCFErrorLocalizedDescriptionKey as String:"The search terms could not be URL encoded"]))
    }

  } // ./sendRequest

  /**
   Get the selected object
   - Returns:  Photo || nil
   */
  func getObjectAtCursor() -> Photo? {
    
    let row = self.cursor.row
    
    if self.data.count > row {
      return self.data[row]
    }
    
    return nil
    
  } // ./getObjectAtCursor
  
  // MARK: - ConnectionManagerDelegate
  
  /**
   Called once the connection manager has sent the request
   */
  func connectionManagerDidSendRequest() {
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
  } // ./connectionManagerDidSendRequest
  
  /**
   Called if the connection manager receives an error
   - parameter error: Error
   */
  func connectionManagerDidProduceError(error: Error) {
    Console.log(filePath: #file, function: #function, params: ["error": error.localizedDescription], message: nil)
    self.delegate.model(self, didProduceError: error)
  } // ./connectionManagerDidProduceError
  
  /**
   Called when the connection manager receives a string that cannot be deserialized
   - parameter string: String
   */
  func connectionManagerDidReceiveString(string: String) {
    Console.log(filePath: #file, function: #function, params: ["string": string], message: nil)
    self.delegate.model(self, didProduceError: NSError(domain: "com.monster.flickry", code: 999, userInfo: [kCFErrorLocalizedDescriptionKey as String:"The response was not recognized"]))
  } // ./connectionManagerDidReceiveString
  
  /**
   Called when the connection manager receives a string that can be deserialized into an object
   - parameter object: Any
   */
  func connectionManagerDidReceiveObject(object: Any) {

    Console.log(filePath: #file, function: #function, params: ["object": object], message: nil)
    
    var newData: [Photo] = []
    
    if let response = object as? [String:Any] {
      
      if let photos = response["photos"] as? [String:Any] {
        
        if let array = photos["photo"] as? [[String:Any]] {
          
          for dict in array {
            let photo = Photo(withSeq: newData.count, withDict: dict)
            newData.append(photo)
          } // ./foreach photo in array
          
        } // ./have photo array in photos object
        
      } // ./have photos object in dict
        
      else {
        
        var error: Error
        if let message = response["message"] as? String {
          error = NSError(domain: "com.monster.flickry", code: 998, userInfo: [kCFErrorLocalizedDescriptionKey as String: message]) as Error
        } else {
          error = NSError(domain: "com.monster.flickry", code: 997, userInfo: [kCFErrorLocalizedDescriptionKey as String:"No further information is available"]) as Error
        }
        self.delegate.model(self, didProduceError: error)
        
      } // ./no photos in dict
      
    } // ./object is dict
    
    /**
     {
       code = "105"
       message = "Service currently unavailable (Site Disabled)"
       stat = "fail"
     }
    **/
    
    if newData.count > 0 {
      self.data = newData
      self.save()
    } // ./have at least one photo
    
    else {
      self.delegate.model(self, didProduceError: NSError(domain: "com.monster.flickry", code: 996, userInfo: [kCFErrorLocalizedDescriptionKey as String:"No new objects were fetched"]))
    } // ./no photos
    
  } // ./connectionManagerDidReceiveObject

} // ./PhotoModel
