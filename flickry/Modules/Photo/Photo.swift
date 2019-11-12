/**
 Photo
 flickry
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Roderic Linguri
 - Requires:  iOS >11
 - Version:   0.1.6
 - Since:     0.1.3
*/

import UIKit

class Photo: NSObject, NSCoding {
  
  // MARK: - Properties
  
  var seq: Int
  
  var id: String
  
  var title: String
  
  var url: String
  
  var ext: String
  
  var height: Double
  
  var width: Double
  
  var localImageURL: URL? {
    if let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
      let filename = "\(self.url.split(separator: "/").last!)"
      return documents.appendingPathComponent(filename)
    }
    return nil
  }
  
  var remoteURL: URL? {
    var urlComponents = self.url.split(separator: "/")
    urlComponents.removeLast()
    let thumbnail = "\(self.url.split(separator: "/").last!)"
    var tnComponents = thumbnail.split(separator: "_")
    tnComponents.removeLast()
    tnComponents.append(String.SubSequence("b.\(self.ext)"))
    let filename = tnComponents.joined(separator: "_")
    urlComponents.append(String.SubSequence(filename))
    let urlString = urlComponents.joined(separator: "/")
    return URL(string: urlString)
  }
  
  // MARK: - Photo

  /**
   Init With Dict
   - Parameter seq: Int
   - Parameter dict: [String:Any]
   */
  init(withSeq seq: Int, withDict dict: [String:Any]) {

    Console.log(filePath: #file, function: #function, params: ["withDict": dict], message: nil)

    /** EXAMPLE JSON
     {
       "farm": 1,
       "height_s": "240",
       "id": "33094387050",
       "isfamily": 0,
       "isfriend": 0,
       "ispublic": 1,
       "owner": "29314320@N07",
       "secret": "89019909cc",
       "server": "667",
       "title": "Stanley T. 3-16-2017",
       "url_s": "https://farm1.staticflickr.com/667/33094387050_89019909cc_m.jpg",
       "width_s": "180"
     }
     **/

    self.seq = seq
    
    if let idStr = dict[PhotoKey.id] as? String {
      self.id = idStr
    } else {
      self.id = ""
    }
    
    if let titleStr = dict[PhotoKey.title] as? String {
      self.title = titleStr
    } else {
      self.title = Localized.untitled
    }
    
    if let urlStr = dict[PhotoKey.url] as? String {
      self.url = urlStr
    } else {
      self.url = UNKNOWN_IMAGE_URL
    }
    
    // calculate the image extension from URL
    let urlComponents = self.url.split(separator: ".")
    if let last = urlComponents.last {
      self.ext = "\(last)"
    } else {
      self.ext = ""
    }
    
    if let heightStr = dict[PhotoKey.height] as? String {
      if let heightDbl = Double(heightStr) {
        self.height = heightDbl
      } else {
        self.height = 0.0
      }
    } else {
      self.height = 0.0
    }
    
    if let widthStr = dict[PhotoKey.width] as? String {
      if let widthDbl = Double(widthStr) {
        self.width = widthDbl
      } else {
        self.width = 0.0
      }
    } else {
      self.width = 0.0
    }
    
    super.init()

  } // ./initWithDict
  
  // MARK: - NSObject
  
  /**
   NSObject init
   */
  override init() {

    Console.log(
      filePath: #file,
      function: #function,
      params: nil,
      message: "ASSERT ERROR: Default init should never be called"
    )
    
    // initialize default properties

    self.seq = 0
    self.id = ""
    self.title = Localized.untitled
    self.url = UNKNOWN_IMAGE_URL
    self.ext = ""
    self.height = 0.0
    self.width = 0.0
    
    super.init()

  } // ./init
  
  // MARK: - NSCoding
  
  /**
   Init With Coder
   - Parameter aDecoder: NSCoder
   */
  required init?(coder aDecoder: NSCoder) {

    Console.log(filePath: #file, function: #function, params: ["coder": aDecoder.description], message: nil)

    self.seq = aDecoder.decodeInteger(forKey: PhotoKey.seq)
    self.id = aDecoder.decodeObject(forKey: PhotoKey.id) as! String
    self.title = aDecoder.decodeObject(forKey: PhotoKey.title) as! String
    self.url = aDecoder.decodeObject(forKey: PhotoKey.url) as! String
    self.ext = aDecoder.decodeObject(forKey: PhotoKey.ext) as! String
    self.height = aDecoder.decodeDouble(forKey: PhotoKey.height)
    self.width = aDecoder.decodeDouble(forKey: PhotoKey.width)

    super.init()

  } // ./initWithCoder
  
  /**
   Encode With Coder
   - Parameter aCoder: NSCoder
   */
  func encode(with aCoder: NSCoder) {

    Console.log(filePath: #file, function: #function, params: ["withCoder": aCoder.description], message: nil)

    aCoder.encode(self.seq, forKey: PhotoKey.seq)
    aCoder.encode(self.id, forKey: PhotoKey.id)
    aCoder.encode(self.title, forKey: PhotoKey.title)
    aCoder.encode(self.url, forKey: PhotoKey.url)
    aCoder.encode(self.ext, forKey: PhotoKey.ext)
    aCoder.encode(self.height, forKey: PhotoKey.height)
    aCoder.encode(self.width, forKey: PhotoKey.width)

  } // ./encodeWithCoder
  
} // ./Photo
