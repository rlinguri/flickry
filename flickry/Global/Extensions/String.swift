/**
 String
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS >11
 - Version:   0.1.5
 - Since:     0.1.1
 */

extension String {
  
  /**
   Remove HTML tags from string
   Mimics syntax from PHP
   - Returns:  Character
   */
  func stripTags() -> String {
    return self.replacingOccurrences(
      of: "<[^>]+>",
      with: "",
      options: .regularExpression,
      range: nil
    )
  }
  
  /**
   Split a string by regular expression
   - Parameter String (pattern)
   - Return    String
   */
  func split(regex pattern: String) -> [String] {
    
    guard let re = try? NSRegularExpression(pattern: pattern, options: [])
      else { return [] }
    
    let nsString = self as NSString // needed for range compatibility
    let stop = "<SomeStringThatIsNotExpectedToOccurInSelf>"
    let modifiedString = re.stringByReplacingMatches(
      in: self,
      options: [],
      range: NSRange(location: 0, length: nsString.length),
      withTemplate: stop
    )
    return modifiedString.components(separatedBy: stop)
    
  } // ./split
  
  /**
   Truncate a string to the specified length number of characters and appends an optional trailing string if longer.
   - Parameter Integer
   - Parameter String
   - Return    String
   */
  func truncate(length: Int, trailing: String = "…") -> String {
    if self.count > length {
      return String(self.prefix(length)) + trailing
    } else {
      return self
    }
  } // ./truncate
  
}
