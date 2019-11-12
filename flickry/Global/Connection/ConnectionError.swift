/**
 ConnectionError.swift
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS 11
 - Version:   0.1.5
 - Since:     0.1.1
 */

class ConnectionError {
  
  static var requestCreationError: Error {
    return NSError(
      domain:"Connection",
      code: 90001,
      userInfo: [kCFErrorLocalizedDescriptionKey as String:"Request failed to be created"]
    )
  }
  
  static var nilAuthString: Error {
    return NSError(
      domain:"Connection",
      code: 90002,
      userInfo: [kCFErrorLocalizedDescriptionKey as String:"Authorization string cannot be nil"]
    )
  }
  
  static var unrecognizedData: Error {
    return NSError(
      domain:"Connection",
      code: 90003,
      userInfo: [kCFErrorLocalizedDescriptionKey as String:"Received data was in an unrecognized format"]
    )
  }
  
}
