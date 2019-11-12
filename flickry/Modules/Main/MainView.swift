/**
 MainView
 flickry
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Roderic Linguri
 - Requires:  iOS >11
 - Version:   0.1.2
 - Since:     0.1.2
*/

import UIKit

class MainView: UIViewController {

  // MARK: - Properties

  var keyboard: CGRect = CGRect.zero

  // MARK: - Outlets

  @IBOutlet weak var viewBottom: NSLayoutConstraint!

  // MARK: - Actions
  
  // MARK: - MainView

  /**
   Called when this view receives a notification
   */
  @objc func notificationHandler(_ notification: Notification) {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)

    if let userInfo = notification.userInfo {
      if let frameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
        let newKeyboard = self.view.convert(frameEnd, from: UIScreen.main.coordinateSpace)
        if newKeyboard.minY != self.keyboard.minY {
          self.keyboard = newKeyboard
          self.viewBottom?.constant = self.view.bounds.height - newKeyboard.minY
          UIView.animate(withDuration: 0.33) {
            self.view.layoutIfNeeded()
          } // ./animate
        } // ./keyboard really did change
      } // ./have keyboard rect
    } // ./have userInfo
    
  } // ./notificationHandler

  // MARK: - UIViewController

  /**
   Called just after init
   */
  override func awakeFromNib() {
    
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    super.awakeFromNib()
    
  } // ./awakeFromNib
  
  /**
   Called when all outlets are loaded
   */
  override func viewDidLoad() {
    Console.log(filePath: #file, function: #function, params: nil, message: nil)
    super.viewDidLoad()
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(MainView.notificationHandler(_:)),
      name: UIResponder.keyboardWillChangeFrameNotification, object: nil
    )
  } // ./viewDidLoad
  

}
