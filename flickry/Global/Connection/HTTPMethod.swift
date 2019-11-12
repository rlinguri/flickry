/**
 HTTPMethod.swift
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS 11
 - Version:   0.1.5
 - Since:     0.1.1
 */

enum HTTPMethod: String {
  case get = "GET"
  case head = "HEAD"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
  case connect = "CONNECT"
  case options = "OPTIONS"
  case trace = "TRACE"
  case patch = "PATCH"
}
