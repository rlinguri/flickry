/**
 Localized
 flickry
 - Author:    Roderic Linguri <rlinguri@mac.com>
 - Copyright: 2019 Roderic Linguri
 - Requires:  iOS >11
 - Version:   0.1.3
 - Since:     0.1.1
 */

import UIKit

struct Localized {
  
  // MARK: - Localized Strings
  
  static var helloWorld: String {
    return NSLocalizedString(
      "Hello World",
      comment: "An example string for localization"
    )
  }
  static var untitled: String {
    return NSLocalizedString(
      "Untitled",
      comment: "A title for a photo, indicating that it has no title"
    )
  }
  
  // MARK: - Error Messages
  
  static var unknownError: String {
    return NSLocalizedString(
      "An unknown error has occurred",
      comment: "Message indicating that an unknown error has occurred"
    )
  }
} // ./Localized
