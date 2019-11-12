/**
 PhotoController
 flickry
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Roderic Linguri
 - Requires:  iOS >11
 - Version:   0.1.3
 - Since:     0.1.3
*/

import UIKit

class PhotoController: PhotoModelDelegate {

  // MARK: - Properties
  
  static let shared: PhotoController = PhotoController()
  
  var model: PhotoModel!
  
  var masterView: PhotosView?
  
  var detailView: PhotoView?
  
  var cells: [PhotoCell] = []

  var alert: UIAlertController?
  
  // MARK: - PhotoController

  private init() {
    self.model = PhotoModel(delegate: self)
  }

  @objc func cancelhandler(_ action: UIAlertAction) {
    Console.log(filePath: #file, function: #function, params: ["action": action], message: nil)
    self.alert?.dismiss(animated: true, completion: nil)
  }
  
  /**
   Completes download method
   - Parameter location: URL | nil
   - Parameter response: URLResponse | nil
   - Parameter error:    Error | nil
   */
  @objc func completionHandler(location: URL?, response: URLResponse?, error: Error?) {
        
    var messages: [String] = []
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    if let e = error {
      messages.append(e.localizedDescription)
    }
    
    if let tempURL = location {
      
      if let filename = response?.url?.lastPathComponent {
 
        if let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
          
          let localURL = documents.appendingPathComponent(filename)

          do {
            
            try FileManager.default.moveItem(at: tempURL, to: localURL)
            
            if let data = self.model?.data {
                            
              for photo in data {
                
                if let photoFile = photo.url.split(separator: "/").last {
                  if "\(photoFile)" == filename {
                    OperationQueue.main.addOperation {
                      self.masterView?.collectionView?.reloadItems(at: [IndexPath(row: photo.seq, section: 0)])
                    }
                  }
                }
              }
            }
            
            
          } // ./do
            
          catch let e as NSError {
            // @TODO: handle error
            messages.append(e.localizedDescription)
          } // ./catch
          
        } // ./have documents directory
          
        else {
          // @TODO: handle error
          messages.append("Failed to get documents directory")
        }
        
      } // ./have filename
        
      else {
        // @TODO: handle error
        messages.append("Failed to get filename")
      }
      
    } // ./have temp file location
      
    else {
      // @TODO: handle error
      messages.append("Failed to get temp file location")
    }
    
    Console.log(filePath: #file, function: #function, params: nil, message: messages.joined(separator: " | "))
    
  } // ./completionHandler
  
  /**
   Download image file for photo
   - Parameter photo: Photo
   */
  func downloadImage(forPhoto photo: Photo) {
    
    if let localURL = photo.localImageURL {
      
      if FileManager.default.fileExists(atPath: localURL.path) {
        Console.log(filePath: #file, function: #function, params: ["photo": photo], message: "image file exists, aborting download...")
        return
      } // ./file exists -- skip

      else {
        Console.log(filePath: #file, function: #function, params: ["photo": photo], message: "image file does not exist, downloading...")
        
        if let remoteURL = URL(string: photo.url) {
          let task = URLSession.shared.downloadTask(with: remoteURL, completionHandler: self.completionHandler)
          task.resume()
        }
        
      } // ./file does not exist

    } // ./have local_url
    
  } // ./downloadImage
  
  /**
   Download all photos in the current dataset
   */
  func downloadPhotos(photos: [Photo]) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    
    for photo in photos {
      self.downloadImage(forPhoto: photo)
    }
    
  } // ./downloadPhotos

  // MARK: - PhotoModelDelegate

  /**
   Called when the model has an error
   - Parameter model: PhotoModel
   - Parameter error: Error
   */
  func model(_ model: PhotoModel, didProduceError error: Error) {

    Console.log(filePath: #file, function: #function, params: ["error": error.localizedDescription], message: nil)
    
    self.masterView?.refreshControl.endRefreshing()
    self.alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: self.cancelhandler)
    self.alert!.addAction(cancelAction)
    self.masterView?.present(self.alert!, animated: true, completion: nil)
    
  } // ./modelDidProduceError
  
  /**
   Called when the model has new data
   - Parameter model: PhotoModel
   - Parameter data: [Photo]
   */
  func model(_ model: PhotoModel, didSaveData data: [Photo]) {
    Console.log(filePath: #file, function: #function, params: ["data": data.count], message: nil)
    self.downloadPhotos(photos: data)
    self.masterView?.collectionView?.reloadData()
    self.masterView?.refreshControl.endRefreshing()

  } // ./modelDidSaveData
  
} // ./PhotoController
