/**
 Index
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS >11
 - Version:   0.2.5
 - Since:     0.2.4
 */

class Index: NSObject, NSCoding {
  
  // MARK: - Properties
  
  var created: TimeInterval
  
  var updated: TimeInterval
  
  var synced: Bool
  
  var sections: [[Int]]
  
  // MARK: - Index
  
  /**
   Sequence Id at Path
   - Parameter path: IndexPath
   - Returns:  Int | nil
   */
  func seqID(atPath path: IndexPath) -> Int? {
    
    Console.log(filePath: #file, function: #function, params: ["atPath": path], message: nil)
    
    if self.sections.count > path.section {
      let section = self.sections[path.section]
      if section.count > path.row && path.row >= 0 {
        return section[path.row]
      } // ./indexPath.row in range
    } // ./indexPath.section in range
    
    return nil
    
  } // ./seqID
  
  /**
   Row count for section
   - Parameter section: Int
   - Returns:  Int
   */
  func rowCount(forSection section: Int) -> Int {
    
    Console.log(filePath: #file, function: #function, params: ["forSection": section], message: nil)
    
    if self.sections.count > section {
      return self.sections[section].count
    }
    
    return 0
    
  } // ./rowCountForSection
  
  func deleteSeqID(atIndexPath path: IndexPath) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    if self.sections.count > path.section {
      let section = self.sections[path.section]
      if section.count > path.row {
        
        print("indexpath.row \(path.row) in range... removing")
        self.sections[path.section].remove(at: path.row)
        
      } // ./indexPath.row in range
        
      else {
        print("indexpath.row \(path.row) is not in range... abandoning")
      }
      
    } // ./indexPath.section in range
      
    else {
      print("indexpath.row \(path.section) is not in range... abandoning")
    }
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
    self.sections = [[]]
    super.init()
  } // ./init
  
  // MARK: - NSCoding
  
  /**
   Init With Coder
   - Parameter aDecoder: NSCoder
   */
  required init?(coder aDecoder: NSCoder) {
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    self.sections = aDecoder.decodeObject(forKey: "sections") as! [[Int]]
    self.created = aDecoder.decodeDouble(forKey: "created")
    self.updated = aDecoder.decodeDouble(forKey: "updated")
    self.synced = aDecoder.decodeBool(forKey: "synced")
    super.init()
  } // ./initWithCoder
  
  /**
   Encode With Coder
   - Parameter aCoder: NSCoder
   */
  func encode(with aCoder: NSCoder) {
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    aCoder.encode(self.sections, forKey: "sections")
    aCoder.encode(self.created, forKey: "created")
    aCoder.encode(self.updated, forKey: "updated")
    aCoder.encode(self.synced, forKey: "synced")
  } // ./encodeWithCoder
  
} // ./Index
