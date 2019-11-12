/**
 Defaults
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS >11
 - Version:   0.1.1
 - Since:     0.1.1
 */

class Defaults {
  
  /**
   Set
   - Parameter object: Any
   - Parameter key: String
   */
  class func set(object: Any, forKey key: String) {
    
    do {
      let dataToStore = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
      UserDefaults.standard.set(dataToStore, forKey: key)
      Console.log(filePath: #file, function: #function, params: ["object": object, "forKey": key], message: "data was stored")
    } // ./do
      
    catch let e as NSError {
      Console.log(filePath: #file, function: #function, params: ["object": object, "forKey": key], message: e.localizedDescription)
    } // ./catch
    
  } // ./set
  
  /**
   Get
   - Parameter key: String
   - Returns:  Any || nil
   */
  class func object(forKey key: String) -> Any? {
    
    do {
      
      if let storedData = UserDefaults.standard.data(forKey: key) {
        
        let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData)
        
        if let unarchivedObject = object {
          Console.log(filePath: #file, function: #function, params: ["forKey": key], message: "retrieved data and returned unarchived object")
          return unarchivedObject
        }
          
        else {
          Console.log(filePath: #file, function: #function, params: ["forKey": key], message: "data could not be unarchived")
        }
        
      } // ./have data
        
      else {
        Console.log(filePath: #file, function: #function, params: ["forKey": key], message: "no data for key")
      } // ./no data
      
    } // ./do
      
    catch let e as NSError {
      Console.log(filePath: #file, function: #function, params: ["forKey": key], message: e.localizedDescription)
    } // ./catch
    
    
    return nil
    
  } // ./objectForKey
  
} // ./Defaults
