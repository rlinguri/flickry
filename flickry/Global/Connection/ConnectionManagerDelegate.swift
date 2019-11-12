/**
 ConnectionManagerDelegate
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS >11
 - Version:   0.1.5
 - Since:     0.1.1
 */

protocol ConnectionManagerDelegate {
  
  /**
   Called once the connection manager has sent the request
   */
  func connectionManagerDidSendRequest()
  
  /**
   Called if the connection manager receives an error
   - parameter error: Error
   */
  func connectionManagerDidProduceError(error: Error)
  
  /**
   Called when the connection manager receives a string that cannot be deserialized
   - parameter string: String
   */
  func connectionManagerDidReceiveString(string: String)
  
  
  /**
   Called when the connection manager receives a string that can be deserialized into an object
   - parameter object: Any
   */
  func connectionManagerDidReceiveObject(object: Any)
  
} // ./ConnectionManagerDelegate
