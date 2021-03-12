//
//  AppDelegate.swift
//  AppDemo
//
//  Created by KHUSHI on 17/02/21.
//

import UIKit
import Firebase
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var strDataBasePath : String = String()
    static var appDelegate : AppDelegate?
    var isLoggedIn = UserDefaults.standard.value(forKey: "login") as? Bool
    var isSignUp = UserDefaults.standard.value(forKey: "signup") as? Bool
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppDelegate.appDelegate = UIApplication.shared.delegate as! Self
        FirebaseApp.configure()
        strDataBasePath = self.getDatabasePath() as String
        if isLoggedIn == true {
                //If already login then show Home screen
            self.showHomeScreen()
        }else if isSignUp == true{
            self.showHomeScreen()
        }else  {
                //If not login then show Login screen
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let viewController = storyBoard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                let navigationController = UINavigationController.init(rootViewController: viewController)
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
             }
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
//        let navigationController = UINavigationController(rootViewController: nextViewController)
//        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//        appdelegate.window?.rootViewController = navigationController
//        navigationController.navigationBar.isHidden = true
//        appdelegate.window?.makeKeyAndVisible()
        
        // Override point for customization after application launch.
        return true
    }

    func showHomeScreen(){
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let navigationController = UINavigationController.init(rootViewController: viewController)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
  // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "AppDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func getDatabasePath() -> NSString{
        var strtempPath : NSString = NSString()
        let objFileManager = FileManager()
        var arrPath : NSArray = NSArray()
        arrPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)as NSArray
        
        strtempPath = arrPath[0] as! NSString
        strtempPath = strtempPath.appendingPathComponent("MakeupProduct.db")as NSString
        print(strtempPath)
        
        let sourcePath = Bundle.main.path(forResource: "MakeupProduct", ofType: "db")
        if !objFileManager.fileExists(atPath: strtempPath as String){
            
            do{
                try objFileManager.copyItem(atPath: sourcePath!, toPath: strtempPath as String)
                print("File has been copied")
            }catch{
                print("Some error has been there")
            }
        }
        
        return strtempPath
    }
}

