/**
 Connection.swift
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS 11
 - Version:   0.1.6
 - Since:     0.1.1
 */

class Connection {
  
  // MARK: - Properties
  
  let urlString: String
  
  var method: HTTPMethod
  
  var authType: AuthType
  
  var authString: String?
  
  var parameters: [String:String]?
  
  var json: String?
  
  var headers: [String:String]?
  
  var error: Error?
  
  /** Computed property: URLRequest (based on object) */
  var request: URLRequest? {
    get {
      
      // make a copy of our stored URL
      var urlString: String = self.urlString.copy() as! String
      
      // initialize body with empty string
      var bodyString: String = ""
      
      // initialize empty data
      var bodyData: Data? = nil
      
      // check for GET
      if self.method == .get {
        if let params = self.parameters {
          urlString.append("?")
          let c = params.count
          var i = 1
          for (key, value) in params {
            urlString.append("\(key)=\(value)")
            if i < c {
              urlString.append("&")
            } // ./still have params
            i += 1
          } // ./params iterator
        } // ./we have params
      } // ./get
      
      // check for POST
      if self.method == .post {
        if let params = self.parameters {
          let c = params.count
          var i = 1
          for (key, value) in params {
            bodyString.append("\(key)=\(value)")
            if i < c {
              bodyString.append("&")
            }
            i += 1
          } // ./params iterator
          bodyData = bodyString.data(using: .utf8)
        } // ./we have params
        
        if let json = self.json {
          bodyData = json.data(using: .utf8)
        }
        
      } // ./post
      
      if let url = URL(string: "\(urlString)") {
        
        var request: URLRequest = URLRequest(url: url)
        request.timeoutInterval = 16
        request.httpMethod = self.method.rawValue
        
        if self.authType != .none {
          if let authData: Data = self.authString?.data(using: .utf8) {
            let encodedAuth = authData.base64EncodedString(options: [])
            // force unwrap authTypeString because we have verified that authType is not none
            let value = "\(self.authType.rawValue) \(encodedAuth)"
            request.setValue(value, forHTTPHeaderField: "Authorization")
          } // ./authString converted to data
            
          else {
            self.error = ConnectionError.nilAuthString
          } // ./authString is nil
          
        } // /./some type of authorization
        
        if self.method == .post {
          if let data = bodyData {
            request.httpBody = data
          } // ./have POST data
        } // ./this is a POST
        
        if let headers = self.headers {
          request.allHTTPHeaderFields = headers
        }
        
        return request
        
      } // ./url is valid
      
      return nil
      
    } // ./get
    
  } // var request
  
  // MARK: - Methods
  
  /**
   * Construct a new Connection object
   * - parameter: String
   * - parameter: HTTPMethod default is GET
   * - parameter: AuthType default is none
   */
  init(urlString: String, method: HTTPMethod = .get, authType: AuthType = .none) {
    
    self.urlString = urlString
    self.method = method
    self.authType = authType
    
    Console.log(filePath: #file, function: #function, params: ["url":self.urlString,"method":"\(self.method)","auth":"\(self.authType)"], message: nil)
    
  } // ./init
  
} // ./Connection
