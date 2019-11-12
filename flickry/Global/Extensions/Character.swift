/**
 Character
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS >11
 - Version:   0.1.5
 - Since:     0.1.1
 */

extension Character {

  /**
   Ord for Character
   Mimics syntax from PHP
   - Returns:  Int
   */
  func ord() -> Int {
    let scalar = self.unicodeScalars
    return Int(scalar[scalar.startIndex].value)
  } // ./ord

}
