/**
 Int
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS >11
 - Version:   0.2.3
 - Since:     0.1.1
 */

extension Int {
  
  /**
   Character for ord
   Mimics syntax from PHP
   - Returns:  Character
   */
  func chr() -> Character {
    return Character(UnicodeScalar(self)!)
  } // ./chr
  
} // ./Int
