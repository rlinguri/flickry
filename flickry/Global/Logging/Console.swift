/**
 Console
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS >11
 - Version:   0.1.1
 - Since:     0.1.1
 */

import UIKit

class Console {
  
  class func log(className: String, funcName: String, params: [String:Any]?, message: String?) {
    
    if DEBUG {
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
      dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
      
      var output: String = "\(dateFormatter.string(from: Date())): \(className).\(funcName)("
      
      if let paramsDict = params {
        
        let c = paramsDict.count
        var i = 1
        
        for item in paramsDict {
          output.append("\(item.key): \(item.value)")
          if c > i {
            output.append(", ")
          } // ./more params to follow
          i += 1
        }
        
      } // ./have params
      
      output.append(")")
      
      if let messageStr = message {
        output.append(" // \(messageStr)")
      } // ./have message
      
      print(output)
      
    } // ./DEBUG is true
    
  } // ./log
  
  class func log(filePath: String, function: String, params: [String:Any]?, message: String?) {
    
    if DEBUG {
      
      // extract the className
      let fileComponents = filePath.split(separator: "/")
      let className = fileComponents.last!.split(separator: ".").first!
      
      // extract funcName
      let pattern = "\\x28.*?\\x29"
      let funcName = function.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
      
      Console.log(className: "\(className)", funcName: funcName, params: params, message: message)
      
    }
    
  }
  
} // ./Console
