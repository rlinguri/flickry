/**
 TimeInterval
 iOSCommon
 - Author:    Roderic Linguri <linguri@digices.com>
 - Copyright: 2019 Digices LLC
 - Requires:  iOS >11
 - Version:   0.2.3
 - Since:     0.2.3
 */

extension TimeInterval {
  
  /**
   Return a time string
   - Returns:  String
   */
  func format(decimalPlaces: Int = 0) -> String {
    
    let time = NSInteger(self)
    
    let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
    let seconds = time % 60
    let minutes = (time / 60) % 60
    let hours = (time / 3600)
    
    switch decimalPlaces {
      case 1:
        if hours > 0 {
          return String(format: "%0.2d:%0.2d:%0.2d.%0.1d", hours, minutes, seconds, ms)
        } else {
          return String(format: "%0.2d:%0.2d.%0.1d", minutes, seconds, ms)
      }
      case 2:
        if hours > 0 {
          return String(format: "%0.2d:%0.2d:%0.2d.%0.2d", hours, minutes, seconds, ms)
        } else {
          return String(format: "%0.2d:%0.2d.%0.2d", minutes, seconds, ms)
      }
      case 3:
        if hours > 0 {
          return String(format: "%0.2d:%0.2d:%0.2d.%0.3d", hours, minutes, seconds, ms)
        } else {
          return String(format: "%0.2d:%0.2d.%0.3d", minutes, seconds, ms)
      }
      default:
        if hours > 0 {
          return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
        } else {
          return String(format: "%0.2d:%0.2d", minutes, seconds)
      }
    }
    
  } // ./format
  
} // ./TimeInterval
