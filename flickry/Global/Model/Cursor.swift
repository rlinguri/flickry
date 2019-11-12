/**
 Cursor
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS >11
 - Version:   0.2.5
 - Since:     0.2.3
 */

class Cursor: NSObject, NSCoding {
  
  // MARK: - Properties
  
  var created: TimeInterval
  
  var updated: TimeInterval
  
  var synced: Bool
  
  var section: Int
  
  var row: Int
  
  var indexPath: IndexPath {
    return IndexPath(row: self.row, section: self.section)
  }
  
  // MARK: - Cursor
  
  /**
   Init with Index Path
   - Parameter section: Int
   - Parameter row: Int
   */
  init(withIndexPath indexPath: IndexPath) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    self.created = Date().timeIntervalSince1970
    self.updated = Date().timeIntervalSince1970
    self.synced = false
    self.section = indexPath.section
    self.row = indexPath.row
    
    super.init()
    
  } // ./initWithIndexPath
  
  /**
   Init with Section and Row
   - Parameter section: Int
   - Parameter row: Int
   */
  init(withSection section: Int, andRow row: Int) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    self.created = Date().timeIntervalSince1970
    self.updated = Date().timeIntervalSince1970
    self.synced = false
    self.section = section
    self.row = row
    
    super.init()
    
  } // ./initWithSection
  
  func isEqual(toIndexPath indexPath: IndexPath) -> Bool {
    if self.section == indexPath.section {
      if self.row == indexPath.row {
        return true
      }
    }
    return false
  }
  
  // MARK: - NSObject
  
  /**
   NSObject init
   */
  override init() {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    self.created = Date().timeIntervalSince1970
    self.updated = Date().timeIntervalSince1970
    self.synced = false
    self.section = 0
    self.row = -1
    
    super.init()
    
  } // ./init
  
  // MARK: - NSCoding
  
  /**
   Init With Coder
   - Parameter aDecoder: NSCoder
   */
  required init?(coder aDecoder: NSCoder) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    self.created = aDecoder.decodeDouble(forKey: "created")
    self.updated = aDecoder.decodeDouble(forKey: "updated")
    self.synced = aDecoder.decodeBool(forKey: "synced")
    self.section = aDecoder.decodeInteger(forKey: "section")
    self.row = aDecoder.decodeInteger(forKey: "row")
    
    super.init()
    
  } // ./initWithCoder
  
  /**
   Encode With Coder
   - Parameter aCoder: NSCoder
   */
  func encode(with aCoder: NSCoder) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    aCoder.encode(self.created, forKey: "created")
    aCoder.encode(self.updated, forKey: "updated")
    aCoder.encode(self.synced, forKey: "synced")
    aCoder.encode(self.section, forKey: "section")
    aCoder.encode(self.row, forKey: "row")
    
  } // ./encodeWithCoder
  
} // ./Cursor
