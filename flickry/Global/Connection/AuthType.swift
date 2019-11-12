/**
 AuthType.swift
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS 11
 - Version:   0.1.5
 - Since:     0.1.1
 */

enum AuthType: String {
  
  case none = ""
  
  case basic = "Basic"
  
  case bearer = "Bearer"
  
  case digest = "Digest"
  
  case hawk = "Hawk"
  
  case aws = "AWS4-HMAC-SHA256"
  
}
