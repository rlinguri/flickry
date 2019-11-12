/**
 ConnectionManager.swift
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS 11
 - Version:   0.2.3
 - Since:     0.1.1
 */

class ConnectionManager {
  
  // MARK: - Properties
  
  var delegate: ConnectionManagerDelegate
  
  // MARK: - Methods
  
  /**
   * Create a ConnectionManager instance with a delegate
   * - parameter: delegate to receive notifications
   */
  init(delegate: ConnectionManagerDelegate) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    self.delegate = delegate
    
  } // ./init
  
  /**
   * Receive completion of URLSession Task on background queue
   * - parameter: optional Data (body of the response)
   * - parameter: optional URLResponse (contains response codes, etc.)
   * - parameter: optional Error (Server Error, not-found etc.)
   */
  func completionHandler(data: Data?, response: URLResponse?, error: Error?) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    OperationQueue.main.addOperation {
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    if let e = error {
      // debug
      OperationQueue.main.addOperation {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.delegate.connectionManagerDidProduceError(error: e)
      } // ./unwrap self
    } // ./unwrap error
    
    if let d = data {
      
      do {
        let object = try JSONSerialization.jsonObject(with: d, options: .allowFragments)
        OperationQueue.main.addOperation {
          self.delegate.connectionManagerDidReceiveObject(object: object)
        }
      } // ./do
        
      catch let error as NSError {
        if let string = String(data: d, encoding: .utf8) {
          OperationQueue.main.addOperation {
            self.delegate.connectionManagerDidReceiveString(string: string)
          }
        } else {
          OperationQueue.main.addOperation {
            self.delegate.connectionManagerDidProduceError(error: error)
          }
        }
      } // ./catch
      
    } // ./unwrap data
    
    
  } // ./completionHandler
  
  /**
   * Send a connection request
   * - parameter: a Connection object
   */
  func sendRequest(forConnection connection: Connection) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    if let request = connection.request {
      let task = URLSession.shared.dataTask(with: request, completionHandler: self.completionHandler)
      task.resume()
      OperationQueue.main.addOperation {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
      }
    } // ./we have a request
      
    else {
      self.delegate.connectionManagerDidProduceError(error: ConnectionError.requestCreationError)
    } // ./request was nil
    
  } // ./sendRequest
  
} // ./ConnectionManager
