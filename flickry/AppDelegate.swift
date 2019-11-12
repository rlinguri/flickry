/**
 AppDelegate
 flickry
 - Author:    Roderic Linguri <rlinguri@mac.com>
 - Copyright: 2019 Roderic Linguri
 - Requires:  iOS >11
 - Version:   0.1.0
 - Since:     0.1.0
 */

@UIApplicationMain
class AppDelegate: UIResponder {
  
  // MARK: - Properties
  
  var window: UIWindow?
  
} // ./AppDelegate

extension AppDelegate: UIApplicationDelegate {
  
  /**
   Override point for customization after application launch.
   - Parameter application: UIApplication
   - Parameter launchOptions: [String:Any]
   - Returns:  Bool
   */
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
    [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return true
  } // ./applicationDidFinishLaunchingWithOptions
  
  /**
   Called when the application is about to move from active to inactive state
   - Parameter application: UIApplication
   */
  func applicationWillResignActive(_ application: UIApplication) {
    // Pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks.
  } // ./applicationWillResignActive
  
  /**
   Called when the application has moved to background state
   - Parameter application: UIApplication
   */
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Release shared resources, save user data, invalidate timers.
  } // ./applicationDidEnterBackground
  
  /**
   Called as part of the transition from the background to the active state
   - Parameter application: UIApplication
   */
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Undo the changes made in applicationDidEnterBackground
  } // ./applicationWillEnterForeground
  
  /**
   Called when the application has moved from inactive to active state
   - Parameter application: UIApplication
   */
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive.
  } // ./applicationDidBecomeActive
  
  /**
   Called when the application is about to terminate.
   - Parameter application: UIApplication
   */
  func applicationWillTerminate(_ application: UIApplication) {
    // Save data
  } // ./applicationWillTerminate
  
}
